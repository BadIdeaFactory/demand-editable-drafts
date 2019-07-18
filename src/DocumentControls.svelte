<script>
  let previousPage = async () => {
    if (requestedPageNumber > 1) { requestedPageNumber--; }
    else { requestedPageNumber = 1; }
  };

  let nextPage = async() => {
    if (requestedPageNumber < pageCount) { requestedPageNumber++; }
    else { requestedPageNumber = pageCount; }
  };

  export let requestedPageNumber = 1;
  export let hidePDFText = false;
  export let pageCount;
  export let dumpDocX;
</script>

<header>
  <nav>
    <button on:click|preventDefault={previousPage} >previous</button>
    <p>Page {requestedPageNumber} of {pageCount}</p>
    <button on:click|preventDefault={nextPage}>next</button>
  </nav>
  <nav>
    <button on:click|preventDefault={dumpDocX}>download docx</button>
    <button on:click|preventDefault={() => { hidePDFText = (! hidePDFText); } } >
      {(hidePDFText) ? 'show' : 'hide' } pdfjs text
    </button>
  </nav>
</header>

<style>
  header {
    display: flex;
    justify-content: space-between
  }

  header nav {
    display: flex;
  }

  nav button {
    cursor: pointer;
  }

  header p {
    vertical-align: middle;
  }
</style>