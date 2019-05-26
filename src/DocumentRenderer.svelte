<svelte:options accessors={true}/>

<script>
  export let src;         // URL or data for the pdf
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

	import { afterUpdate, onMount, onDestroy } from 'svelte';
	// well this bit is a crazy mess
	// See: https://github.com/mozilla/pdf.js/issues/10317
	// and https://github.com/bundled-es-modules/pdfjs-dist
  import pdfjs from "@bundled-es-modules/pdfjs-dist/build/pdf";
  pdfjs.GlobalWorkerOptions.workerSrc = "./pdf.worker.js"; // this is the external url

  /* 
    External API for manipulating pages.
  */

  export async function getAttachments() {
    if (!page) { await getPage(pageNum); };
    return await app.analyzer.currentPage.pdfDoc.getAttachments();
  };

  export async function getXML(opts) {
    if (!page) { await getPage(pageNum); };
    let attachments = await getAttachments();
    // Assume the first XML file we can find is the legislative XML file.
    let xmlFile = Object.values(attachments).find((entry) => {
      return (entry.filename && entry.content && entry.filename.match(/\.xml$/) )
    });
  
    let output;
    if (xmlFile) {
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
    await drawTextBounds();
  };

  export async function getText() {
    if (!page) { await getPage(pageNum); };
    return await getPageText(pageNum);
  };

  export async function drawTextBounds(itemNumber) {
    if (!page) { await getPage(pageNum); };
    let items = await page.getTextContent();
    let textLayer = await document.createElement('div');
    textLayer.style = `left: ${pageCanvas.offsetLeft}px; top: ${pageCanvas.offsetTop}px; height: ${pageCanvas.height}px; width: ${pageCanvas.width}px;`;
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
    let currentTextLayer = document.getElementById('text-layer');
    container.replaceChild(textLayer, currentTextLayer);
    textLayer.id = 'text-layer';
  };

	onMount(async () => {
    await loadDocument(src);
    ctx = pageCanvas.getContext('2d');
    getPage(pageNum);
  });

  onDestroy(() => { unloadDocument(); });
</script>

<div class="page-wrapper" bind:this={container}>
  {#if pdfDoc }
    <header>
      <button on:click|preventDefault={previousPage} >&lt;</button>
      <p>Page {pageNum} of {pdfDoc.numPages}</p>
      <button on:click|preventDefault={nextPage}>&gt;</button>
    </header>
    <canvas bind:this={pageCanvas}></canvas>
    <div id="text-layer"></div>
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
  }

  .page-wrapper header p {
    vertical-align: middle;
  }

  :global(#text-layer) { 
    position: absolute;
    left: 0;
    top: 0;
    right: 0;
    bottom: 0;
    overflow: hidden;
    opacity: 0.2;
    line-height: 1.0;
  }
  
  :global(#text-layer) :global(span) {
    color: transparent;
    position: absolute;
    white-space: pre;
    cursor: text;
    transform-origin: 0% 0%;
    border: solid 1px black;
  }

</style>