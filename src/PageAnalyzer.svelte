<svelte:options accessors={true}/>

<script>
  import PageRenderer from './PageRenderer.svelte';

  export let src;
  export let currentPage;
</script>

<main>
  <PageRenderer src={src} bind:this={currentPage} />
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