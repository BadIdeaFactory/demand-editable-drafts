<svelte:options accessors={true}/>

<script>
	import documentStore from './DocumentStore.js';
	import DocumentRenderer from './DocumentRenderer.svelte';
	import FilePicker from './FilePicker.svelte'
	import FileCard from './FileCard.svelte'
	
	export let picker;
</script>

<main>
	<header>
		<FilePicker accept={"application/pdf"} />
		{#if $documentStore.contents }
			<FileCard file={$documentStore} />
		{/if}
	</header>
	<section class="document">
		{#if $documentStore.contents }
			<DocumentRenderer src={$documentStore.contents} />
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

