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

### Content analyzers:

- Paragraph identifiers
- List identifiers
- line number identifiers
- Table of contents identifiers
- SmallCaps identifiers

### pdf.js

Okay, given the fact that we can inspect the output of the `pdf.js` text layer generator, we can reverse engineer its mechanisms for mapping text instructions in the PDF to positions on the canvas.

Okay!  We've reverse engineered the text box positioning.  NOTE: this is not the same as the text _drawing_ code, in `pdf.js` the textLayer calculations and the visual rendering component are independent.

### Region analysis

The first thing we've implemented is a line grouping algorithm.  It's a greedy algorithm which scans all elements from top to bottom, and groups them based on whether the elements overlap (and overlap should be transitive).

The elements in each group are then ordered by their left position.  In some cases elements are neighbors but are separated by a gap rather than a space.  In such an event a space is inserted between them.  This structure works fine for ordering the text elements in a document from top left to bottom right.  However it has some shortcomings for our purposes.

First, the heading of each bill contains the bill title in the largest boldest font in the document.  Immediately to the left of the bill title is a block of smallcaps text designating which number congress and which session the bill is from.  The bill title text is large enough that it overlaps to both lines of the session information.

Second, main bill text is marked with line numbers, and those line numbers form a single column to the left of the main text.  Simply mashing all of the text that share a line together means that the line number ends up prepended to the main bill text.

Third, concatenating text items together loses information about indentation.

All three of these concerns should be resolveable through the mechanism outlined in [Breuel 2003a][].  A basic outline of the technique is to find the largest vertically oriented white space that separates text elements.

### Styling

OpenOfficeXML _should_ have all of the necessary formatting elements required to faithfully reproduce legislative PDFs.

- Paragraphs
- Paragraph indendation
- Font styling
- SmallCaps
- Sections (to divide the bill header from the numbered bill text)
- Line Numbering

Within LibreOffice it's possible to [turn off line numbering for partcular paragraphs](https://help.libreoffice.org/Writer/Adding_Line_Numbers) by creating a paragraph style without line numbers.  Likewise [this is possible in desktop Word](https://support.office.com/en-us/article/start-page-numbering-later-in-your-document-c73e3d55-d722-4bd0-886e-0b0bd0eb3f02#startlater) but requires creating a separate section and unlinking the styles from the previous section.

#### Congressional Style

##### Paragraphs

Paragraphs always begin with an indent

# Annotated Bibliography

### Breuel, Thomas M., "[High Performance Document Layout Analysis][Breuel 2003a]", 2003 ([pdf link][Breuel 2003a pdf])

[Breuel 2003a]: https://www.semanticscholar.org/paper/High-Performance-Document-Layout-Analysis-Breuel/0acbc8706cb3e5a43141a03342ded6025a7eb60c
[Breuel 2003a pdf]: https://pdfs.semanticscholar.org/0a78/09043fe4f50da53163d1fd318754c5f259e6.pdf

This paper has some key observations despite being 16 years old.  It uses a variety of approaches composed into a single layout analysis system.

#### Whitespace detection

Breuel calculates a series of rectangles which maximize the area of whitespace each covers in the image.  Just finding all of the whitespace isn't super useful so they added some additional criteria which require whitespace rectangles to be bounded on some number of sides by other elements (either text or page boundary presumably).

Breuel notes that in the simplest case calculating the whitespace is a matter of just maximizing the area in rectilinear areas orthogonal to the page bounds.  However there are a pile of cases where either complex layouts or poorly created documents may frustrate such an analysis.  He notes another paper in which he describes [a more robust mechanism for calculating whitespace boundaries independent of orientation][Breuel 2003b].

[Breuel 2002]: https://www.semanticscholar.org/paper/Two-Geometric-Algorithms-for-Layout-Analysis-Breuel/32004665dd4cba02bef7f1f3b3ddaf79f0e2eafc
[Breuel 2003b]: https://www.semanticscholar.org/paper/An-Algorithm-for-Finding-Maximal-Whitespace-at-for-Breuel/973d4afc87a911b2e6acb4a04059f2f5e85c66a9
[Shafait 2008]: https://www.semanticscholar.org/paper/Performance-Evaluation-and-Benchmarking-of-Six-Page-Shafait-Keysers/41d424d8b63e1f2a94f348d897bc19a817257894

The orientation-free analysis essentially functions using four vertex parameters and an angle to indication the rotation of the box.

### Konya, Iuliu Vasile and Stefan Eickeler. “[Logical structure recognition for heterogeneous periodical collections.][konya-eichkeler-2014]” DATeCH (2014).

[konya-eichkeler-2014][https://www.semanticscholar.org/paper/Logical-structure-recognition-for-heterogeneous-Konya-Eickeler/861f520f6916f5badb96602717e27456c17e537d]

