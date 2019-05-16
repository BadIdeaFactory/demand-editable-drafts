let pdfjsWorker = require("./node_modules/@bundled-es-modules/pdfjs-dist/build/pdf.worker.js");
(typeof window !== 'undefined' ? window : {}).pdfjsWorker = pdfjsWorker;
