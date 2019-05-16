# Notes

This is a scratch pad for research notes.

## pdf.js

Using pdf.js as a component is a little bit messy.  It's not set up by default to be used as an es6 import.  [Mozilla's instructions aren't super clear][pdfjs-instructions], and it appears that pdf.js is set up to use CommonJS modules.  [There's a ticket about this](https://github.com/mozilla/pdf.js/issues/10317).

[pdfjs-instructions]: https://github.com/mozilla/pdf.js/wiki/Setup-pdf.js-in-a-website

[react-pdf]: http://projects.wojtekmaj.pl/react-pdf/
[react-pdf-repo]: https://github.com/wojtekmaj/react-pdf