<svelte:options accessors={true}/>

<script>
  export let src;
  export let pdfDoc;
  let pageCanvas;
  let pageNum = 1;
  let pageRendering = false;
  let pageNumPending = null;
  let scale = 0.8;
  let ctx;


	import { onMount } from 'svelte';
	// well this bit is a crazy mess
	// See: https://github.com/mozilla/pdf.js/issues/10317
	// and https://github.com/bundled-es-modules/pdfjs-dist

  import pdfjs from "@bundled-es-modules/pdfjs-dist/build/pdf";
  pdfjs.GlobalWorkerOptions.workerSrc = "./pdf.worker.js"; // this is the external url
  
  let renderPage = async (num) => {
    pageRendering = true;
    // Using promise to fetch the page
    let page = await pdfDoc.getPage(num)
    let viewport = page.getViewport({scale: scale});
    pageCanvas.height = viewport.height;
    pageCanvas.width = viewport.width;

    // Render PDF page into canvas context
    var renderContext = {
      canvasContext: ctx,
      viewport: viewport
    };
    var renderTask = page.render(renderContext);

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
  
  let loadDocument = async (source) => {
    pdfDoc = await pdfjs.getDocument(source);
  };

	onMount(async () => {
    await loadDocument(src);
    ctx = pageCanvas.getContext('2d');
    renderPage(1);
	});

</script>

<div class="page-wrapper">
  {#if pdfDoc }
    <p>Got Doc!</p>
    <p>Document has {pdfDoc.numPages} pages</p>
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

  .page-wrapper canvas {
    width: 400px;
    min-height: 400px;
  }
</style>