<svelte:options accessors={true}/>
<script>
  import documentStore from './DocumentStore.js';
  let file;
  let fileInput;
  let fileContents;
  let form;
  export let accept = [];
  export let large;

  export function getFilesFromDom(){
    return filterTypes(fileInput.files);
  }

  function filterTypes(files, types=[accept].flat()) {
    const acceptable = Array.prototype.filter.call(files, f => {
      return types.some( type => type == f.type );
    });
    console.log(acceptable);
    return acceptable;
  }

  async function readFileContents(file) {
    let filePromise = (resolve, reject) => {
      let reader = new FileReader();
      reader.onload = (event) => {
        let data = new Uint8Array(event.target.result);
        resolve(data);
      };
      
      if (file){
        reader.readAsArrayBuffer(file);
      } else {
        throw "Unable to read file: No file selected";
      }
    }
    return new Promise(filePromise);
  }

  async function getFile(file) {
    if (file){
      $documentStore = file;
      fileContents = await readFileContents(file);
      $documentStore.contents = fileContents
    }
  }

  async function onInputHandler() {
    console.log("changing!");
    const files = getFilesFromDom();
    await getFile(files[0]);
  }

  async function onDrop(e){
    console.log("Dropped!", e.dataTransfer);
    const files = filterTypes(e.dataTransfer.files);
    await getFile(files[0]);
  }

  function onDragEnter(e){
    console.log("Dragged In!", e);
    form.classList.add('has-dragover');
  }

  function onDragLeave(e){
    console.log("Dragged Out!", e);
    form.classList.remove('has-dragover');
  }

</script>

<form class:large 
  on:drop|preventDefault={onDrop} 
  on:dragover|preventDefault|stopPropagation 
  on:dragenter|preventDefault|stopPropagation={onDragEnter}
  on:dragleave|preventDefault|stopPropagation={onDragLeave}
  bind:this={form} >
  <div id="drop-box">
    <input type="file" id="file" class="input-file" accept={accept} bind:this={fileInput} on:input={onInputHandler} />
    <div class="upload-icon"></div>
    <label class="upload-message" for="file">
      {#if !fileContents }
        <p><span class="click-here">Choose a file</span> or drag it here.</p>
      {:else}
        <p><span class="click-here">Choose a different file</span></p>
      {/if}
    </label>
  </div>
</form>

<style>
  form.large {
    outline: 2px dashed #92b0b3;
    outline-offset: -10px;
    
    -webkit-transition: outline-offset .15s ease-in-out, background-color .15s linear;
    transition: outline-offset .15s ease-in-out, background-color .15s linear;

    padding: 20px;

    height: 100%;
    max-height: 600px;
  }

  form {
    display: flex;
    padding: 10px;
  }

  :global(form.large.has-dragover) {
    outline-offset: -20px;
    outline-color: #c8dadf;
    background-color: #bbb;
  }

  #drop-box {
    display: grid;
    justify-items: center;
    width: 100%;
  }

  .upload-icon {
    padding: 10px;
  }

  .large .upload-icon {
    height: 175px;
    width: 175px;
    align-self: end;
    background-image: url(/images/upload.svg);
    background-size: contain;
    background-repeat: no-repeat;
  }

  label.upload-message {
    align-self: start;
  }

  .click-here {
    cursor: pointer;
    text-decoration: underline;
    font-weight: bold;
  }
  .input-file {
    width: 0.1px;
    height: 0.1px;
    opacity: 0;
    overflow: hidden;
    position: absolute;
    z-index: -1;
  }

</style>


<!--
  Notes:

  Getting files using input elements:
  https://developer.mozilla.org/en-US/docs/Web/API/File/Using_files_from_web_applications

  Oh yeah, gotta wrap the onload as a promise:
  https://stackoverflow.com/questions/38252194/how-can-i-convert-an-onload-promise-into-async-await/38252603

  Drag and drop for files:
  https://www.html5rocks.com/en/tutorials/file/dndfiles/

  Also see the previous resource for thoughts about implementing progress indicators.

  Loading documents via a typed Array
  https://stackoverflow.com/questions/22048395/how-to-open-a-local-pdf-in-pdfjs-using-file-input
-->