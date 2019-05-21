<svelte:options accessors={true}/>

<script>
  export let src;         // URL for the pdf
  export let pdfDoc;      // the pdf proxy object loaded by pdf.js
  export let page;        // the current page of the pdf we've loaded.
  export let viewport;    // the pdf.js viewport object for the current page
  export let pageCanvas;  // the canvas element the viewport is drawn into
  let ctx;                // the canvas context object
  let scale = 1.3;        // the presentational scale for the page
  let pageNum = 1;        // default to the first page of the PDF.
  let pageRendering = false;
  let pageNumPending = null;

	import { onMount } from 'svelte';
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
    let data = await getText();
    let items = data.items;

    let drawItem = (item, vp, context) => {
      const calculateCoordinates = (item) => {
        const itemRotated = pdfjs.Util.transform(vp.transform, item.transform);
        const x = itemRotated[4];
        const y = itemRotated[5];
        // item.height is not correct for some cases (https://github.com/mozilla/pdf.js/issues/8276)
        const height = Math.sqrt((itemRotated[2] * itemRotated[2]) + (itemRotated[3] * itemRotated[3]));
        const width =  item.width;
        const itemAngle =  Math.atan2(itemRotated[2], itemRotated[0]);
    
        // This will provide top left, clockwise bounding box
        const horizontalBoundingBox = [
            x, y - height,
            x + width, y - height,
            x + width, y,
            x, y
        ];
        // return rotated bounding box in pixels
        return rotateBoundingBox(horizontalBoundingBox, [x, y], itemAngle);
      };

      const rotateBoundingBox = (absBox, origin, rads) => {
          const [originX, originY] = origin;
          const cosT = Math.cos(rads);
          const sinT = Math.sin(rads);

          const rotate = (x, y) => ([
              (x - originX) * cosT - (y - originY) * sinT + originX, 
              (x - originX) * sinT + (y - originY) * cosT + originY
          ]);

          const [v1x, v1y, v2x, v2y, v3x, v3y, v4x, v4y] = absBox;
          return [
              rotate(v1x, v1y),
              rotate(v2x, v2y),
              rotate(v3x, v3y),
              rotate(v4x, v4y)
          ];
      };

      let drawBox = (coordinates) => {
        context.strokeStyle = 'green';
        context.beginPath();
        context.moveTo(...coordinates[3]);
        coordinates.forEach((point) => context.lineTo(...point));
        context.stroke();
        //context.strokeRect(...coordinates);
      };

      let coordinates = calculateCoordinates(item, viewport, context);
      console.log(coordinates);
      console.log(item)
      drawBox(coordinates, context);
    };

    if (itemNumber){
      drawItem(items[itemNumber], viewport, ctx);
    } else {
      items.forEach((item) => { drawItem(item, viewport, ctx); } );
    }
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
    return await page.getTextContent();
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

	onMount(async () => {
    await loadDocument(src);
    ctx = pageCanvas.getContext('2d');
    getPage(pageNum);
	});

</script>

<div class="page-wrapper">
  {#if pdfDoc }
    <header>
      <button on:click|preventDefault={previousPage} >&lt;</button>
      <p>Page {pageNum} of {pdfDoc.numPages}</p>
      <button on:click|preventDefault={nextPage}>&gt;</button>
    </header>
    <canvas bind:this={pageCanvas}></canvas>
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
</style>