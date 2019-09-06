import svelte from 'rollup-plugin-svelte';
import resolve from 'rollup-plugin-node-resolve';
import commonjs from 'rollup-plugin-commonjs';
import livereload from 'rollup-plugin-livereload';
import { terser } from 'rollup-plugin-terser';
import analyze from 'rollup-plugin-analyzer';
import replace from 'rollup-plugin-replace';

const production = !process.env.ROLLUP_WATCH;
const production_data = {
	ga_id: "UA-145851186-1",
};
const env_data = production ? production_data : {};

export default [
	{
		input: 'node_modules/@bundled-es-modules/pdfjs-dist/build/pdf.worker.entry.js',
		output: {
			format: 'iife',
			file: 'public/pdf.worker.js',
			name: 'pdfjsWorker',
		},
		context: 'window',
		plugins: [
			resolve(),
			commonjs(),
			analyze({summaryOnly: true}),
		]
	},
	{
		input: 'src/layout-worker/layout.worker.js',
		output: {
			format: 'iife',
			file: 'public/layout.worker.js',
			name: 'layoutWorker',
		},
		plugins: [
			resolve(),
			commonjs(),
			analyze({summaryOnly: true}),
		]
	},
	{
		input: 'src/main.js',
		output: {
			sourcemap: true,
			format: 'iife',
			name: 'app',
			file: 'public/bundle.js'
		},
		plugins: [
			svelte({
				// enable run-time checks when not in production
				dev: !production,
				// we'll extract any component CSS out into
				// a separate file — better for performance
				css: css => {
					css.write('public/bundle.css');
				},
				hydratable: true,
			}),
			replace({
				values: {
					ENVIRONMENT_DATA: JSON.stringify(env_data),
				},
			}),

			// If you have external dependencies installed from
			// npm, you'll most likely need these plugins. In
			// some cases you'll need additional configuration —
			// consult the documentation for details:
			// https://github.com/rollup/rollup-plugin-commonjs
			resolve(),
			commonjs(),

			// Watch the `public` directory and refresh the
			// browser on changes when not in production
			!production && livereload('public'),

			// If we're building for production (npm run build
			// instead of npm run dev), minify
			production && terser(),
			analyze({summaryOnly: true}),
		]
	}
];
