import App from './App.svelte';

const app = new App({
	target: document.body,
	props: {
		picker: null,
		fileContents: null,
	}
});

export default app;