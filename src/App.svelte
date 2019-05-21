<svelte:options accessors={true}/>

<script>
	import PageAnalyzer from './PageAnalyzer.svelte';
	
	export let name;
	export let analyzer;
</script>

<h1>Hello {name}!</h1>

<PageAnalyzer src="/documents/salma_bill.pdf" bind:this={analyzer} />

<footer class="attribution">
	Made with 💖 &amp; 🤔 for Demand Progress by Ted Han &amp; <img alt="the Bad Idea Factory (logo)" class="biffud_logo" src="/images/BIF_logo.svg"/>
</footer>

<style>
	h1 {
		color: purple;
	}

	footer.attribution {
		text-align: center;
	}

	.attribution .biffud_logo {
		height: 4em;
	}

</style>

