<svelte:options accessors={true}/>

<script>
	import documentStore from './DocumentStore.js';
	import DocumentRenderer from './DocumentRenderer.svelte';
	import FilePicker from './FilePicker.svelte';
	
	export let picker;
	export let renderer;
</script>

<header class="banner">
	<div class="logotype">DEMAND PROGRESS</div>
</header>
<main class:large-picker={!$documentStore.contents}>
	<section class="picker" >
		<FilePicker accept={"application/pdf"} bind:this={picker} large={!$documentStore.contents} />
	</section>
	{#if $documentStore.contents }
	<section class="document">
		<DocumentRenderer src={$documentStore} bind:this={renderer} />
	</section>
	{/if}
	<footer class="attribution">
		Made with 💖 &amp; 🤔 for Demand Progress by Ted Han &amp; the Bad Idea Factory.
	</footer>
</main>


<style>
	@import url('https://fonts.googleapis.com/css?family=Roboto+Slab:700&display=swap');

	:global(body) { padding:0; margin:0; }

	.banner {
	}

	.logotype {
		color: darkred;
		font-family: 'Roboto Slab', serif;
		font-weight: bold;
		font-size: 24pt;
		padding: 10px 30px;
	}

	main {
		display: grid;
		grid-template-rows: [mini-picker] 70px [main] auto [footer] 20px;
		height: 100%;
		margin: 0 20px;
	}

	.large-picker section.picker {
		grid-row-end: 	footer;
	}

	section.picker {
		grid-row-start: mini-picker;
		grid-row-end: main;
	}

	.large-picker section.document {
		display: none;
	}

	section.document {
		grid-row-start: main;
		grid-row-end: footer;
		display: flex;
		justify-content: center;
	}

	footer.attribution {
		grid-row-start: footer;
		grid-row-end: footer;
		text-align: center;
	}

</style>

<!--
<svelte:head>
	<script src='https://unpkg.com/tesseract.js@v2.0.0-alpha.10/dist/tesseract.min.js'></script>
</svelte:head>
-->