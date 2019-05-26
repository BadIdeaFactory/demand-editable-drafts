<svelte:options accessors={true}/>

<script>
  import DocumentRenderer from './DocumentRenderer.svelte';

  export let src;
  export let currentPage;
</script>

<main>
  <DocumentRenderer src={src} bind:this={currentPage} />
  <section class="analysis">
    
  </section>
</main>

<style>
  main {
    display: flex;
  }

  .page {
    width: 48%;
  }

  .analysis {
    width: 48%;
  }
</style>