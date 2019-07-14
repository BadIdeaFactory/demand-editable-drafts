<svelte:options accessors={true}/>

<script>
	import documentStore from './DocumentStore.js';
	import DocumentRenderer from './DocumentRenderer.svelte';
	import FilePicker from './FilePicker.svelte'
	import FileCard from './FileCard.svelte'
	
	export let picker;
	export let renderer;
	let tessWorker

	let ocr = () => {
		if (!tessWorker) { tessWorker = new Tesseract.TesseractWorker(); }
		let myImage = renderer.getCanvas();
		tessWorker.recognize(myImage)
  		.progress(message => console.log(message))
  		.catch(err => console.error(err))
  		.then(result => console.log(result))
  		.finally(resultOrError => console.log(resultOrError));
	}

	import LayoutAnalyzer from './layout-analyzer';

	let layoutAnalyzer;
	export let startWorkerInterface = () => {
		if (!layoutAnalyzer) {
			layoutAnalyzer = new LayoutAnalyzer();
		}
		return layoutAnalyzer;
	};
</script>

<main>
	<header>
		<FilePicker accept={"application/pdf"} bind:this={picker} />
		{#if $documentStore.contents }
			<!--<FileCard file={$documentStore} />-->
			<!--<button on:click|preventDefault={ocr}>OCR page</button>-->
		{/if}
	</header>
	<section class="document">
		{#if $documentStore.contents }
			<DocumentRenderer src={$documentStore} bind:this={renderer} />
		{/if}
	</section>
	<footer class="attribution">
		Made with 💖 &amp; 🤔 for Demand Progress by Ted Han &amp; <img alt="the Bad Idea Factory (logo)" class="biffud_logo" src="/images/BIF_logo.svg"/>
	</footer>
</main>


<style>

	main {
		max-width: 1024px;
		min-width: 500px;
		margin: auto;
	}

	section.document {
		display: flex;
		justify-content: center;
	}

	footer.attribution {
		text-align: center;
	}

	.attribution .biffud_logo {
		height: 4em;
	}

</style>

<!--
<svelte:head>
	<script src='https://unpkg.com/tesseract.js@v2.0.0-alpha.10/dist/tesseract.min.js'></script>
</svelte:head>
-->