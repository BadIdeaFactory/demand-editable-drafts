/* 
  Shamelessly stolen from https://github.com/sveltejs/svelte/blob/master/test/setup.js
  This hooks node's require syntax and rewrites es6 modules into node's commonjs module
  format.  See: https://gist.github.com/jamestalmage/df922691475cff66c7e6#gistcomment-2840127
*/
const fs = require('fs');

process.env.TEST = true;

require.extensions['.js'] = function(module, filename) {
	const exports = [];

	let code = fs.readFileSync(filename, 'utf-8')
		.replace(/^import \* as (\w+) from ['"]([^'"]+)['"];?/gm, 'var $1 = require("$2");')
		.replace(/^import (\w+) from ['"]([^'"]+)['"];?/gm, 'var {default: $1} = require("$2");')
		.replace(/^import {([^}]+)} from ['"](.+)['"];?/gm, 'var {$1} = require("$2");')
		.replace(/^export default /gm, 'exports.default = ')
		.replace(/^export (const|let|var|class|function) (\w+)/gm, (match, type, name) => {
			exports.push(name);
			return `${type} ${name}`;
		})
		.replace(/^export \{([^}]+)\}(?: from ['"]([^'"]+)['"];?)?/gm, (match, names, source) => {
			names.split(',').filter(Boolean).forEach(name => {
				exports.push(name);
			});

			return source ? `const { ${names} } = require("${source}");` : '';
		})
		.replace(/^export function (\w+)/gm, 'exports.$1 = function $1');

	exports.forEach(name => {
		code += `\nexports.${name} = ${name};`;
	});

	try {
		return module._compile(code, filename);
	} catch (err) {
		console.log(code); // eslint-disable-line no-console
		throw err;
	}
};
