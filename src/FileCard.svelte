<script>
  export let file;
</script>

<div class="file_card">
  {#if file }
  <p>Got File!</p>
  <p>It's name:  "{file.name}"</p>
  <p>It is {file.size} bytes long</p>
  {/if}
</div>

<style>
</style>