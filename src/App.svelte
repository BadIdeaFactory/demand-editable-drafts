<svelte:options accessors={true}/>

<script>
	import PageAnalyzer from './PageAnalyzer.svelte';
	import FilePicker from './FilePicker.svelte'
	
	export let picker;
	export let fileContents;
	export let analyzer;
</script>

<main>
<FilePicker accept={"application/pdf"} bind:fileContents={fileContents} bind:this={picker} />
<PageAnalyzer src="/documents/salma_bill.pdf" bind:this={analyzer} />
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

