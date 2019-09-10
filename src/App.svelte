<svelte:options accessors={true}/>

<script>
	import documentStore from './DocumentStore.js';
	import DocumentRenderer from './DocumentRenderer.svelte';
	import FilePicker from './FilePicker.svelte';
	
	export let picker;
	export let renderer;
	let hideAbout = true;

</script>

<div id="grid" class:large-picker={!$documentStore.contents}>
	<header id="banner">
		<div class="logotype">BillToText</div>
		<div><a href="#" on:click|preventDefault|stopPropagation={() => hideAbout = false}>About</a></div>
	</header>
	
	<div id="about-wrapper" class:hidden={hideAbout}>
		<div id="about">
			<div id="close-about" on:click={ () => hideAbout = true } ></div>
			<h2>About BillToText</h2>
			<p>We designed BillToText to make it easier for congressional staff to have 
					conversations around legislation. We have two major use cases in mind. 
					First, we want to make it easier for a congressional office to collaborate 
					with other offices and receive feedback from stakeholders. 
					Second, we want to make it easier for users to identify changes in draft 
					legislation by comparing multiple versions.</p>
	
			<p>BillToText is a project of <a href="https://demandprogresseducationfund.org/#/">the Demand Progress Education Fund</a>, a project of 
					the New Venture Fund. The website is free to use and the code is open source 
					and <a href="https://github.com/badideafactory/demand-editable-drafts">available online</a>. We encourage everyone to make use of and adapt the code, 
					and we impose no requirements on its reuse. Please report bugs to 
					<a href="https://github.com/DanielSchuman/demand-editable-drafts">our GitHub account</a> 
					and send comments to <a href="mailto:daniel@demandprogress.org">daniel@demandprogress.org</a></p>
		
			<p>The website was built by <a href="https://knowtheory.net">Ted Han</a> of <a href="https://biffud.com">the Bad Idea Factory</a>. 
					He did a great job, as you can see.
			</p>
		
			<p>We <a href="https://secure.actblue.com/contribute/page/crsreports">welcome your donations</a> to keep this website running.</p>
		</div>
	</div>
	<main class:large-picker={!$documentStore.contents}>
		<section class="picker" >
			<FilePicker accept={"application/pdf"} bind:this={picker} large={!$documentStore.contents} />
		</section>
		{#if !$documentStore.contents }
		<section id="front-matter">
			<p>BillToText.com turns PDFs of federal legislation into text files. 
				It provides a formatted document that you can download and edit 
				with a word processor program.
			</p>
			<p>To use, upload your bill. BillToText publishes the bill text in your browser 
				and allows you to download it as a .DOCX file. If you open the file in 
				Microsoft Word, BillToText preserves the line numbers on each page. 
				You can open it as a Google doc as well, although Google does not support line numbers.
			</p>
			<p>BillToText is designed specifically for discussion drafts of legislation prepared by 
				legislative counsel in the U.S. Senate or House of Representatives.
			</p>
			<p>We do not retain or share copies of legislation uploaded to the website. 
				We do use Google analytics to track general information about users of the website. 
				(Here is <a href="https://demandprogress.org/privacy-policy/">our privacy policy</a>).
			</p>
		</section>
		{/if}
		{#if $documentStore.contents }
		<section class="document">
			<DocumentRenderer src={$documentStore} bind:this={renderer} />
		</section>
		{/if}
	</main>
	<!--
	<footer class="attribution">
		Made <span class="extra">with 💖 &amp; 🤔</span> for <span class="logotype">Demand Progress</span> 
		by Ted Han <span class="extra">&amp; the Bad Idea Factory.</span>
	</footer>
	-->
</div>

<style>
	.large-picker section.picker {
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
</style>
