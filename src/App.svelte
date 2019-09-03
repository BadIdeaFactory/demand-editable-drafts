<svelte:options accessors={true}/>

<script>
	import documentStore from './DocumentStore.js';
	import DocumentRenderer from './DocumentRenderer.svelte';
	import FilePicker from './FilePicker.svelte';
	
	export let picker;
	export let renderer;

	function openAbout() {
		console.log("about!");
	}
</script>

<div id="grid">
	<header id="banner">
		<div class="logotype">BillToText</div>
		<div><a href="about" on:click|preventDefault|stopPropagation={openAbout}>About</a></div>
	</header>
	

	<main class:large-picker={!$documentStore.contents}>
		{#if !$documentStore.contents }
		<section id="front-matter">
			<p>BillToText.com turns PDFs of federal legislation into text files. 
				It provides a formatted document that you can download and edit with a word processor program.
			</p>
			<p>To use, upload your bill. BillToText publishes the bill text in your browser 
				and allows you to download it as a .DOCX file. If you open the file in 
				Microsoft Word, BillToText preserves the line numbers on each page. 
				You can open it as a Google doc as well, although Google does not support line numbers.
			</p>
			<p>BillToText is designed specifically for discussion drafts of legislation prepared by 
				legislative counsel in the U.S. Senate or House of Representatives.
			</p>
			<p>We do not retain or share copies of legislation uploaded to the website. We do use Google analytics 
				to track general information about users of the website. (Here is our privacy policy).
			</p>
		</section>
		{/if}
		<section class="picker" >
			<FilePicker accept={"application/pdf"} bind:this={picker} large={!$documentStore.contents} />
		</section>
		{#if $documentStore.contents }
		<section class="document">
			<DocumentRenderer src={$documentStore} bind:this={renderer} />
		</section>
		{/if}
	</main>
	<footer class="attribution">
		Made with 💖 &amp; 🤔 for <span class="logotype">Demand Progress</span> by Ted Han &amp; the Bad Idea Factory.
	</footer>
</div>

<style>
	.large-picker section.picker {
		grid-row-end: footer;
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
		position: fixed;
		bottom: 0px;
		text-align: center;
	}

</style>
