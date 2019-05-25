<svelte:options accessors={true}/>

<input type="file" accept={accept} bind:this={fileInput} on:input={onInputHandler} />

<style></style>

<script>
  import { afterChange } from 'svelte';

  let fileInput;
  let fileContents;
  export let accept;
  export let onInput;

  export function getFile(){
    return fileInput.files[0];
  }

  export async function readFile() {
    let filePromise = (resolve, reject) => {
      let reader = new FileReader();
      reader.onload = (event) => {
        let data = new Uint8Array(event.target.result);
        resolve(data);
      };
      
      if (fileInput.files.length > 0 ){
        reader.readAsArrayBuffer(fileInput.files[0]);
      } else {
        throw "Unable to read file: No file selected";
      }
    }
    return new Promise(filePromise);
  }

  let onInputHandler = async () => {
    console.log("changing!");
    fileContents = await readFile();
    if (onInput) { 
      console.log("Firing Change Handler");
      onInput(fileContents);
    }
  };
</script>

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