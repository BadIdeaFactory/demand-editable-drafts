# Notes

This is a scratch pad for research notes.

## pdf.js

Using pdf.js as a component is a little bit messy.  It's not set up by default to be used as an es6 import.  [Mozilla's instructions aren't super clear][pdfjs-instructions] on how to integrate it, and it appears that pdf.js is set up to use CommonJS modules.  [There's a ticket about this](https://github.com/mozilla/pdf.js/issues/10317).

Temporarily this is addressed by sucking the worker up using Rollup's CommonJS module into a separate worker file (which is how deployment is intended).

- lol stop screwing around and just use pdfjs's built in renderTextLayer: https://usefulangle.com/post/90/javascript-pdfjs-enable-text-layer
- A discussion of Ascenders, Descenders and Leading: http://pawlan.com/monica/articles/texttutorial/other.html
- [Scaling the page to the desired number of pixels][document-scaling] requires getting the pdf's native width and then rescaling it.

PDFjs lifecycle notes:

- Loading a pdf requires the PDFjs web worker.
- Flipping through the PDF is easy enough by using the pdfjs proxy object methods
- There are a bunch of issues on github on destroying PDFs resulting in a memory leak.
  - adding an `onDestroy` method to the `DocumentRenderer` to clean up the `pdfjs` worker, and destroy the document is the way to go.

### Text positioning

So, it's possible to use `pdf.js`'s textLayer rendering system to generate bounding boxes for text elements.  Understanding how `pdf.js` does this is a bit complicated.  Each text object is represented using a vector of six numbers.  These six numbers describe the bounds, orientation, scale and skew for the element.




[pdfjs-instructions]: https://github.com/mozilla/pdf.js/wiki/Setup-pdf.js-in-a-website

[react-pdf]: http://projects.wojtekmaj.pl/react-pdf/
[react-pdf-repo]: https://github.com/wojtekmaj/react-pdf
[hubgit-example]: https://gist.github.com/hubgit/600ec0c224481e910d2a0f883a7b98e3
[issue-about-font-extraction]: https://github.com/mozilla/pdf.js/issues/7914
[bananas-comment-about-bounding-boxes]: https://github.com/mozilla/pdf.js/issues/5643#issuecomment-69969258
[document-scaling]: https://mozilla.github.io/pdf.js/examples/#rendering-the-page



## Legislative XML

Congress has [an XML standard for publishing legislation](https://xml.house.gov/).  Some draft legislation PDFs include an XML representation as an attachment within each PDF (which is more likely for draft House legislation than Senate draft legislation).  

Extracting those XML documents isn't a challenge, the main question is what to _do_ with the XML documents.

It's not clear that transforming the XML documents into a draft document is any easier than iterating through the PDF & layout positions.  On the other hand the XML documents include a great deal of semantic information which the raw PDFs do not include.

The other challenge is that only a subset of the documents in question have the legislative XML.

Also see: https://github.com/usgpo/uslm/blob/master/USLM-User-Guide.md

## Layout Analysis

Okay, so as a general matter this topic is a huge can of worms.  There's a substantial body of literature about doing analysis of PDFs.  Additionally there are a pile of tools which claim to perform these sorts of analyses.  The best tool i've found in the past is pdf2htmlEX, which does an admirable job of matching the visual styles of a PDF in HTML + CSS.

Text needs to be grouped.  Each text element needs to be assessed for its:

- orientation
- font characteristics:
    - size
    - font name / glyph

Lines need to be grouped based on the similarity of text elements, and the dissimilarity to other elements.

- whitespace: (consistency of column and margin space)
- orientation of lines.

### Component analyzers:

- List identifiers
- line number identifiers
- Table of contents identifiers

### pdf.js

Okay, given the fact that we can inspect the output of the `pdf.js` text layer generator, we can reverse engineer its mechanisms for mapping text instructions in the PDF to positions on the canvas.

Okay!  We've reverse engineered the text box positioning.  NOTE: this is not the same as the text _drawing_ code, in `pdf.js` the textLayer calculations and the visual rendering component are independent.



# Annotated Bibliography

### Breuel, Thomas M., "[High Performance Document Layout Analysis][breuel-2003a]", 2003 ([pdf link][breuel-2003a-pdf])

[breuel-2003a]: https://www.semanticscholar.org/paper/High-Performance-Document-Layout-Analysis-Breuel/0acbc8706cb3e5a43141a03342ded6025a7eb60c
[breuel-2003a-pdf]: https://pdfs.semanticscholar.org/0a78/09043fe4f50da53163d1fd318754c5f259e6.pdf

This paper has some key observations despite being 16 years old.  It uses a variety of approaches composed into a single layout analysis system.

#### Whitespace detection

Breuel calculates a series of rectangles which maximize the area of whitespace each covers in the image.  Just finding all of the whitespace isn't super useful so they added some additional criteria which require whitespace rectangles to be bounded on some number of sides by other elements (either text or page boundary presumably).

Breuel notes that in the simplest case calculating the whitespace is a matter of just maximizing the area in rectilinear areas orthogonal to the page bounds.  However there are a pile of cases where either complex layouts or poorly created documents may frustrate such an analysis.  He notes another paper in which he describes [a more robust mechanism for calculating whitespace boundaries independent of orientation][breuel-2003b].

[breuel-2003b]: https://www.semanticscholar.org/paper/An-Algorithm-for-Finding-Maximal-Whitespace-at-for-Breuel/973d4afc87a911b2e6acb4a04059f2f5e85c66a9

The orientation-free analysis essentially functions using four vertex parameters and an angle to indication the rotation of the box.

### Konya, Iuliu Vasile and Stefan Eickeler. “[Logical structure recognition for heterogeneous periodical collections.][konya-eichkeler-2014]” DATeCH (2014).

[konya-eichkeler-2014][https://www.semanticscholar.org/paper/Logical-structure-recognition-for-heterogeneous-Konya-Eickeler/861f520f6916f5badb96602717e27456c17e537d]

