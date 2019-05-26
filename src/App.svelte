<svelte:options accessors={true}/>

<script>
	import documentStore from './DocumentStore.js';
	import DocumentRenderer from './DocumentRenderer.svelte';
	import FilePicker from './FilePicker.svelte'
	import FileCard from './FileCard.svelte'
	
	export let picker;
</script>

<main>
<FilePicker accept={"application/pdf"} />
{#if $documentStore.contents }
<FileCard file={$documentStore} />
<DocumentRenderer src={$documentStore.contents} />
{/if}
</main>

<footer class="attribution">
	Made with 💖 &amp; 🤔 for Demand Progress by Ted Han &amp; <img alt="the Bad Idea Factory (logo)" class="biffud_logo" src="/images/BIF_logo.svg"/>
</footer>

<style>

	footer.attribution {
		text-align: center;
	}

	.attribution .biffud_logo {
		height: 4em;
	}

</style>

