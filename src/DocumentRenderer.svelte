<svelte:options accessors={true}/>

<script>
  export let src;         // URL or data for the pdf
  let pdfDoc;      // the pdf proxy object loaded by pdf.js
  let page;        // the current page of the pdf we've loaded.
  let viewport;    // the pdf.js viewport object for the current page
  let container;   // the container element for our various elements.
  let pageCanvas;  // the canvas element the viewport is drawn into
  let ctx;                // the canvas context object
  let scale = 2;        // the presentational scale for the page
  let pageNum = 1;        // default to the first page of the PDF.
  let pageRendering = false;
  let pageNumPending = null;
  let hidePDFText = false;
  
  //import { calculateStyle } from './pdfjs-hax.js';
	import { afterUpdate, onMount, onDestroy } from 'svelte';
	// well this bit is a crazy mess
	// See: https://github.com/mozilla/pdf.js/issues/10317
	// and https://github.com/bundled-es-modules/pdfjs-dist
  import pdfjs from "@bundled-es-modules/pdfjs-dist/build/pdf";
  pdfjs.GlobalWorkerOptions.workerSrc = "./pdf.worker.js"; // this is the external url

  /* 
    External API for manipulating pages.
  */

  export function derp(item,styles) {
    return calculateStyle(item, styles, viewport, ctx);
  }

  export function calculateStyle(item, styles, viewport, context) {
      // This is cribbed from the `appendText` function in text_layer.js
      // START `appendText`
      let styleBuf = ['left: ', 0, 'px; top: ', 0, 'px; font-size: ', 0,
        'px; font-family: ', '', ';'];
    
      let textDiv = document.createElement('span');
      let textDivProperties = {
        style: null,
        angle: 0,
        canvasWidth: 0,
        isWhitespace: false,
        originalTransform: null,
        paddingBottom: 0,
        paddingLeft: 0,
        paddingRight: 0,
        paddingTop: 0,
        scale: 1,
      };
    
      let tx = pdfjs.Util.transform(viewport.transform, item.transform);
      // 
      let angle = Math.atan2(tx[1], tx[0]);
      let style = styles[item.fontName];
      if (style.vertical) {
        angle += Math.PI / 2;
      }
      // i'm still not clear what tx[2] and tx[3] represent.
      let fontHeight = Math.sqrt((tx[2] * tx[2]) + (tx[3] * tx[3]));
      // assume the that the font's ascenders are equal to the font height.
      let fontAscent = fontHeight;
      if (style.ascent) {
        // if the ascent is specified in the styles, scale the fontAscent
        // by the style's ascent
        fontAscent = style.ascent * fontAscent;
      } else if (style.descent) {
        // otherwise if the descent is specified modify by that.
        fontAscent = (1 + style.descent) * fontAscent;
      }
    
      let left;
      let top;
      if (angle === 0) {
        // if the text isn't rotated...
        left = tx[4];               // the left bound is tx[4]
        top = tx[5] - fontAscent;   // the top bound is tx[5] discounted by the fontAscent
      } else {
        // tx[4] plus the height of the element modified by the angle.
        // so for example, if angle is 90°, it's sine is 1.
        // Thus left is tx[4] + fontAscent
        // if angle is 45°, left is `tx[4] + (fontAscent * 0.5)`
        left = tx[4] + (fontAscent * Math.sin(angle));
        // Likewise if angle is 90° top is `tx[5] - (fontAscent * 0)`
        // and if angle is 0° top is `tx[5] - (fontAscent * 1)`
        // and if angle is 45° top is `tx[5] - (fontAscent * 0.5)`
        top = tx[5] - (fontAscent * Math.cos(angle));
        // So if we think about this basically, when a rotation happens with positive THETA
        // the element is rotated around its center, and the LEFT edge of the boundary increases 
        // by some fraction of the height+ascent of the text element.
        //
        // The BOTTOM LEFT corner must be moved further to the right
        // such that the TOP LEFT corner sits at tx[4] as it swings back to the left.
        // 
        // Likewise, as the TOP RIGHT corner swings UPWARD, the `top` field must be diminished
        // by the appropriately rotated fraction of the fontAscent so that the TOP RIGHT corner
        // sits at tx[5].
      }
      styleBuf[1] = left;
      styleBuf[3] = top;
      styleBuf[5] = fontHeight;
      styleBuf[7] = style.fontFamily;
      textDivProperties.style = styleBuf.join('');
      textDiv.setAttribute('style', textDivProperties.style);
    
      textDiv.textContent = item.str;
      // `fontName` is only used by the FontInspector, and we only use `dataset`
      // here to make the font name available in the debugger.
      /*if (task._fontInspectorEnabled) {
        textDiv.dataset.fontName = item.fontName;
      }*/
      if (angle !== 0) {
        textDivProperties.angle = angle * (180 / Math.PI);
      }
      if (style.vertical) {
        textDivProperties.canvasWidth = item.height * viewport.scale;
      } else {
        textDivProperties.canvasWidth = item.width * viewport.scale;
      }
      // END `appendText`
      // START `_layoutText`
    
      let fontSize = textDiv.style.fontSize;
      let fontFamily = textDiv.style.fontFamily;
    
      // pdf.js batches this and only set the font
      // if it differs between two text elements
      context.font = `${fontSize} ${fontFamily}`;
      let width = context.measureText(textDiv.textContent).width;
      let transform = '';
    
      if (textDivProperties.canvasWidth !== 0 && width > 0) {
        //// the scale is equal to the proportion of the `canvasWidth` to the calculated `width`
        textDivProperties.scale = textDivProperties.canvasWidth / width;
        transform = `scaleX(${textDivProperties.scale})`;
      }
      //// rotate the text as needed.
      if (textDivProperties.angle !== 0) {
        transform = `rotate(${textDivProperties.angle}deg) ${transform}`;
      }
      //// set the transform into the styles if there are any.
      if (transform.length > 0) {
        textDivProperties.originalTransform = transform;
        textDiv.style.transform = transform;
      }
    
      return textDivProperties;
    };


  export function getPDF() {
    return pdfDoc;
  };

  export function getCanvas() {
    return pageCanvas;
  };

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
    await loadDocument(src);
    ctx = pageCanvas.getContext('2d');
    getPage(pageNum);
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
    opacity: 0.2;
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
