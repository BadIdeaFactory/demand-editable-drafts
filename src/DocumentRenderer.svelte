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

  let pdfDoc;      // the pdf proxy object loaded by pdf.js
  let page;        // the current page of the pdf we've loaded.
  let viewport;    // the pdf.js viewport object for the current page
  let container;   // the container element for our various elements.
  let pageCanvas;  // the canvas element the viewport is drawn into
  let ctx;                // the canvas context object
  let scale = 1.3;        // the presentational scale for the page
  let pageNum = 1;        // default to the first page of the PDF.
  let pageRendering = false;
  let pageNumPending = null;
  let hidePDFText = false;
  export let textCollection;
  
  import TextCollection from './text-collection.js';
  import docx from 'docx';
  import FileSaver from 'file-saver';

	import { afterUpdate, onMount, onDestroy } from 'svelte';
	// well this bit is a crazy mess
	// See: https://github.com/mozilla/pdf.js/issues/10317
	// and https://github.com/bundled-es-modules/pdfjs-dist
  import pdfjs from "@bundled-es-modules/pdfjs-dist/build/pdf";
  pdfjs.GlobalWorkerOptions.workerSrc = "./pdf.worker.js"; // this is the external url

  /* 
    External API for manipulating pages.
  */

  async function getTextCollection(){
    let text = await getText();
    textCollection = new TextCollection(text, viewport, ctx);
    return textCollection;
  }

  export async function dumpDocX() {
    let doc = new docx.Document();

    for (let num = 1; num <= pdfDoc.numPages ; num++) {
      await getPage(num);
      let textCollection = await getTextCollection();
      textCollection.calculateStyles();
      let options = {};
      if (num == 1) { options.noPageBreak = true; }
      textCollection.appendTextToDocX(doc, options);
    }

    let packer = new docx.Packer();
    let docBuffer = await packer.toBuffer(doc);
    let blob = new Blob(
      [docBuffer], 
      {type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'}
    );
    FileSaver.saveAs(blob, fileName.replace(/pdf$/, 'docx'));
  }

  export async function drawTextBounds() {
    let textCollection = await getTextCollection();
    textCollection.calculateStyles();

    let textLayer = await document.createElement('div');
    textLayer.style = `
      height: ${pageCanvas.height}px; 
      width: ${pageCanvas.width}px;`;

    textCollection.appendTextElementsTo(textLayer);
    replaceTextLayer(textLayer);
    textCollection.appendWhiteSpaceTo(textLayer);
    textCollection.group();
    return textCollection;
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
    pageRendering = true;

    pageNum = num;
    page = await pdfDoc.getPage(num);
    viewport = page.getViewport({scale: scale});
    await renderPage(pageNum);
    let pageText = await drawTextBounds();
    console.log(pageText.dumpText());
  };

  export async function getText() {
    if (!page) { await getPage(pageNum); };
    return await getPageText(pageNum);
  };

  export async function pdfJSDrawTextBounds(itemNumber) {
    if (!page) { await getPage(pageNum); };
    let items = await page.getTextContent();
    let textLayer = await document.createElement('div');
    textLayer.style = `
      height: ${pageCanvas.height}px; 
      width: ${pageCanvas.width}px;`;
    replaceTextLayer(textLayer);
    // Just cheat by asking `pdfjs` to do it's default thing.
    // It'll draw a series of spans into the container
    await pdfjs.renderTextLayer({
      textContent: items,
      container: textLayer,
      viewport: viewport,
      textDivs: []
    });
  };

  /*
    Internal API below this point.
  */
  let renderPage = async (num) => {
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
      renderPage(pageNumPending);
      pageNumPending = null;
    }
    // Update page counters
    //document.getElementById('page_num').textContent = num;
  }

  let getPageText = async () => {
    if (!page) { await getPage(pageNum); };
    return await page.getTextContent({normalizeWhiteSpace: true});
  };

  let previousPage = async () => {
    if (pageNum > 1) { pageNum = pageNum - 1; }
    else { pageNum = 1; }
    await getPage(pageNum);
  };

  let nextPage = async() => {
    if (pageNum < pdfDoc.numPages) { pageNum = pageNum + 1; }
    else { pageNum = pdfDoc.numPages; }
    await getPage(pageNum);
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
    container.replaceChild(textLayer, currentTextLayer);
    textLayer.id = 'pdfjs-text-layer';
  };

	onMount(async () => {
    await loadDocument(data);
    ctx = pageCanvas.getContext('2d');
    await getPage(pageNum);
  });

  onDestroy(() => { unloadDocument(); });
</script>

<div class="page-wrapper">
  {#if pdfDoc }
    <header>
      <nav>
        <button on:click|preventDefault={previousPage} >&lt;</button>
        <p>Page {pageNum} of {pdfDoc.numPages}</p>
        <button on:click|preventDefault={nextPage}>&gt;</button>
      </nav>
      <nav>
        <button on:click|preventDefault={dumpDocX}>download docx</button>
        <button on:click|preventDefault={() => { hidePDFText = (! hidePDFText); } } >
          {(hidePDFText) ? 'show' : 'hide' } pdfjs text
        </button>
      </nav>
    </header>
    <div class="display-wrapper">
      <div class="text-layer-wrapper" class:hide={hidePDFText} bind:this={container}>
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

  .page-wrapper header {
    display: flex;
    justify-content: space-between
  }

  .page-wrapper header nav {
    display: flex;
  }

  .page-wrapper header p {
    vertical-align: middle;
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

  .text-layer-wrapper.hide {
    display: none;
  }

</style>
