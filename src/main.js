import App from './App.svelte';
import googleAnalytics from './google-analytics.js';

const env = JSON.parse('ENVIRONMENT_DATA')
if (env['ga_id']) {
	//console.log("Running in production!");
	googleAnalytics(env['ga_id']);
} else {
	//console.log("Not running in production!");
}

const app = new App({
	target: document.body,
	hydrate: true,
	props: {
		
	}
});

export default app;