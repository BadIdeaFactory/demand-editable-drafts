<svelte:options accessors={true}/>

<script>
  export let src;          // URL or data for the pdf
  let data = src.contents; // actually make this a file object.
  let fileName = src.name; // with a name.
  if (!fileName){
    let now = new Date();
    let nowDateString = `${now.getFullYear()}-${now.getMonth()}-${now.getDay()}`;
    let nowTimeString = `${now.getHours()}${now.getMinutes()}${now.getSeconds()}`;
    let nowString = `${nowDateString}-${nowTimeString}`;
    fileName = `demand-progress-download-${nowString}`;
  }

  let pdfDoc;             // the pdf proxy object loaded by pdf.js
  let page;               // the current page of the pdf we've loaded.
  let viewport;           // the pdf.js viewport object for the current page
  let textLayerParent;    // the textLayer textLayerParent for our various elements.
  let pageCanvas;         // the canvas element the viewport is drawn into
  let ctx;                // the canvas context object
  let scale = 1.3;        // the presentational scale for the page
  let pageNum = 1;        // default to the first page of the PDF.
  let requestedPageNumber = 1;
  let pageRendering = false;
  let pageNumPending = null;
  let hidePDFText = true;
  let componentMounted = false;
  let notification = {};
  export let billAnalyzer;
  export let layoutAnalyzer;
  
  import DocumentControls from './DocumentControls.svelte';
  import PageLayoutAnalyzer from './pdf/page-layout-analyzer.js';
  import BillDocument from './bill/bill-document.js';
  import docx from 'docx';
  import FileSaver from 'file-saver';

  import { onMount, onDestroy } from 'svelte';
  import { fade } from 'svelte/transition';

	// well this bit is a crazy mess
	// See: https://github.com/mozilla/pdf.js/issues/10317
	// and https://github.com/bundled-es-modules/pdfjs-dist
  import pdfjs from "@bundled-es-modules/pdfjs-dist/build/pdf";
  pdfjs.GlobalWorkerOptions.workerSrc = "./pdf.worker.js"; // this is the external url

  /* 
    External API for manipulating pages.
  */

  export async function getPageLayoutAnalyzer(){
    const text = await getText();
    layoutAnalyzer = new PageLayoutAnalyzer(text, viewport.transform, viewport.scale, pageCanvas.width, pageCanvas.height);
    return layoutAnalyzer;
  }

	import { tweened } from 'svelte/motion';
	import { cubicOut } from 'svelte/easing';
  let analyzeLayoutProgress;
  let analyzeRegionProgress;
  let dumpingDocument;
  export async function dumpDocX() {
    if (dumpingDocument) {
      console.log(`Already dumping document: ${dumpingDocument}`);
      billAnalyzer.cancel();
    } else {
      dumpingDocument = true;
      const analyzerProgressLogger = (pageNumber, layout) => { 
        analyzeLayoutProgress = (pageNumber / pdfDoc.numPages);
      };
      const regionProgressLogger = (pageNumber, layout) => { 
        analyzeRegionProgress = (pageNumber / pdfDoc.numPages);
      };

      try {
        setNotification("Analyzing Page Layout");
        if (await billAnalyzer.calculateLayout({ callback: analyzerProgressLogger })) {
          analyzeLayoutProgress = undefined;
          const opts = {
            progressCallback: regionProgressLogger,
          }
          setNotification("Converting to Word");
          const blob = new Blob(
            [await billAnalyzer.dumpDocX(opts)], 
            {type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'}
          );
          analyzeRegionProgress = undefined;
          FileSaver.saveAs(blob, fileName.replace(/pdf$/, 'docx'));
        }
      } catch (error) {
        console.error("OH NO SOMETHING WENT WRONG");
        console.log(error);
        setNotification("We encountered an error.")
      }
      analyzeLayoutProgress = undefined;
      dumpingDocument = false;
    }
    clearNotification();
  }

  export async function drawTextBounds() {
    let layoutAnalyzer = await getPageLayoutAnalyzer();
    layoutAnalyzer._calculateStyles();

    let textLayer = document.createElement('div');
    textLayer.style = `
      height: ${pageCanvas.height}px; 
      width: ${pageCanvas.width}px;`;

    layoutAnalyzer.appendTextElementsTo(textLayer, ctx);
    replaceTextLayer(textLayer);
    layoutAnalyzer.appendWhiteSpaceTo(textLayer);
    return layoutAnalyzer;
  }

  export function getPDF() {
    return pdfDoc;
  };

  export function getCanvas() {
    return pageCanvas;
  };

  export async function getAttachments() {
    if (!page) { await getPage(pageNum); };
    return await pdfDoc.getAttachments();
  };

  export async function getXML(opts) {
    if (!page) { await getPage(pageNum); };
    let attachments = await getAttachments();
    // Assume the first XML file we can find is the legislative XML file.
    let output;
    if (attachments) {
      let xmlFile = Object.values(attachments).find((entry) => {
        return (entry.filename && entry.content && entry.filename.match(/\.xml$/) )
      });
    
      let fileContents = new TextDecoder('utf-8').decode(xmlFile.content);
      if (opts && opts.text) {
        output = fileContents;
      } else {
        let parser = new DOMParser();
        let xmlDom = parser.parseFromString(fileContents, 'application/xml');
        output = xmlDom;
      }
    }
    return output;
  }

  export async function getPage(num) {
    pageNum = num;
    requestedPageNumber = num;
    renderPage();
  }
  
  export async function renderPage() {
    pageRendering = true;
    clearTextLayer();
    page = await pdfDoc.getPage(pageNum);
    viewport = page.getViewport({scale: scale});
    await drawPage(pageNum);
    let pageText = await drawTextBounds();
    //console.log(pageText.dumpText());
  };

  export async function getText() {
    if (!page) { await getPage(pageNum); };
    return await getPageText(pageNum);
  };

  /*
    Internal API below this point.
  */
  let drawPage = async (num) => {
    if (!page) { await getPage(pageNum); };
    pageRendering = true;
    // Using promise to fetch the page
    pageCanvas.height = viewport.height;
    pageCanvas.width = viewport.width;

    // Render PDF page into canvas context
    let renderContext = {
      canvasContext: ctx,
      viewport: viewport
    };
    let renderTask = page.render(renderContext);

    // Wait for rendering to finish
    await renderTask.promise;
    pageRendering = false;
    if (pageNumPending !== null) {
      // New page rendering is pending
      drawPage(pageNumPending);
      pageNumPending = null;
    }
    // Update page counters
    //document.getElementById('page_num').textContent = num;
  }

  let getPageText = async () => {
    if (!page) { await getPage(pageNum); };
    return await page.getTextContent({normalizeWhiteSpace: true});
  };

  let loadDocument = async (source) => {
    pdfDoc = await pdfjs.getDocument(source).promise;
  };

  let unloadDocument = async () => {
    clearCanvas();
    clearTextLayer();
    pdfDoc.cleanup();
    pdfDoc.destroy();
  };

  let clearCanvas = () => {
    ctx.clearRect(0, 0, pageCanvas.width, pageCanvas.height);
  };

  let clearTextLayer = () => replaceTextLayer();

  let replaceTextLayer = (node) => {
    let textLayer = ( node || document.createElement('div') );
    let currentTextLayer = document.getElementById('pdfjs-text-layer');
    textLayerParent.replaceChild(textLayer, currentTextLayer);
    textLayer.id = 'pdfjs-text-layer';
  };

	onMount(async () => {
    await loadDocument(data);
    ctx = pageCanvas.getContext('2d');
    billAnalyzer = new BillDocument(pdfDoc, {scale: scale});
    componentMounted = true;
    // console.log(billAnalyzer.getBillText());
  });

  onDestroy(() => { unloadDocument(); });

  $: {
    if (componentMounted){
      console.log(requestedPageNumber);
      getPage(requestedPageNumber);
    }
  }

  $: {
    if (pageRendering) {
      console.log("Rendering Page");
    } else {
      console.log("Done Rendering Page");
    }
  }

  let layoutProgressVisible = false;
  let analyzerProgress = tweened(0, { duration: 400, easing: cubicOut });
  $: {
    if (analyzeLayoutProgress) {
      layoutProgressVisible = true;
      analyzerProgress = tweened(analyzeLayoutProgress, { duration: 400, easing: cubicOut });
    } else {
      layoutProgressVisible = false;
      analyzerProgress = tweened(0, { duration: 400, easing: cubicOut });
    }
    //console.log(`${analyzeLayoutProgress*100}% complete analyzing document.`);
  }
  let regionProgress = tweened(0, { duration: 400, easing: cubicOut });
  $: {
    regionProgress = tweened(analyzeRegionProgress, { duration: 400, easing: cubicOut });
    //console.log(`${analyzeLayoutProgress*100}% complete analyzing document.`);
  }

  export const setNotification = (message) => {
    if (message){
      notification = {
        message: message
      };
    } else {
      notification = {};
    }
  }
  export const clearNotification = () => { setNotification(undefined) }

  let visible = true;
</script>

<div class="page-wrapper">
  {#if pdfDoc }
    <DocumentControls 
      bind:hidePDFText
      bind:requestedPageNumber
      pageCount={pdfDoc.numPages}
      dumpDocX={dumpDocX}
      dumpingDocument={dumpingDocument}
    />
    {#if notification.message }
      <p class="notification" in:fade out:fade >{notification.message}</p>
    {/if}
    {#if layoutProgressVisible }
      <progress value={($analyzerProgress || 0)} in:fade out:fade ></progress>
    {/if}
    {#if analyzeRegionProgress }
      <progress value={$regionProgress}></progress>
    {/if}
    <div class="display-wrapper">
      <div class="text-layer-wrapper" class:hide={hidePDFText} bind:this={textLayerParent}>
        <div id="pdfjs-text-layer"></div>
      </div>
      <canvas bind:this={pageCanvas}></canvas>
    </div>
  {:else }
    <p>Waiting for Page</p>
  {/if}
</div>

<style>
  .page-wrapper {
    padding: 10px;
    background-color: #ccc;
  }

  :global(#pdfjs-text-layer) { 
    position: absolute;
    overflow: hidden;
    /*opacity: 0.2;*/
    line-height: 1.0;
  }
  
  :global(#pdfjs-text-layer) :global(span) {
    color: transparent;
    position: absolute;
    white-space: pre;
    cursor: text;
    transform-origin: 0% 0%;
    border: solid 1px black;
  }

  :global(#pdfjs-text-layer) :global(span.whitespace) {
    background-color: palegreen;
    border: solid 1px green;
    opacity: 95%;
  }

  .text-layer-wrapper.hide :global(#pdfjs-text-layer) :global(span) {
    border: 0;
    background-color: transparent;
  }

  progress {
		display: block;
		width: 100%;
	}

  .notification {
    text-align: center;
  }


</style>
