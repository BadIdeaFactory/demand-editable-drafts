# Notes

This is a scratch pad for research notes.

## pdf.js

Using pdf.js as a component is a little bit messy.  It's not set up by default to be used as an es6 import.  [Mozilla's instructions aren't super clear][pdfjs-instructions] on how to integrate it, and it appears that pdf.js is set up to use CommonJS modules.  [There's a ticket about this](https://github.com/mozilla/pdf.js/issues/10317).

Temporarily this is addressed by sucking the worker up using Rollup's CommonJS module into a separate worker file (which is how deployment is intended).

The pdfjs core 

[pdfjs-instructions]: https://github.com/mozilla/pdf.js/wiki/Setup-pdf.js-in-a-website

[react-pdf]: http://projects.wojtekmaj.pl/react-pdf/
[react-pdf-repo]: https://github.com/wojtekmaj/react-pdf
[hubgit-example]: https://gist.github.com/hubgit/600ec0c224481e910d2a0f883a7b98e3
[issue-about-font-extraction]: https://github.com/mozilla/pdf.js/issues/7914
[bananas-comment-about-bounding-boxes]: https://github.com/mozilla/pdf.js/issues/5643#issuecomment-69969258



## Legislative XML

Congress has [an XML standard for publishing legislation](https://xml.house.gov/).  Some draft legislation PDFs include an XML representation as an attachment within each PDF (which is more likely for draft House legislation than Senate draft legislation).  

Extracting those XML documents isn't a challenge, the main question is what to _do_ with the XML documents.

It's not clear that transforming the XML documents into a draft document is any easier than iterating through the PDF & layout positions.  On the other hand the XML documents include a great deal of semantic information which the raw PDFs do not include.

The other challenge is that only a subset of the documents in question have the legislative XML.

Also see: https://github.com/usgpo/uslm/blob/master/USLM-User-Guide.md