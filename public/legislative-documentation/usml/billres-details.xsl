<!--  ===========================================================  -->
<!--  MODULE:    Legislative Branch Bills  XSLT                    -->
<!--  VERSION:   3.9                                          -->
<!--  DATE:      September 05, 2018                                    -->
<!--  Previous version and date: 3.8 December 22, 2017           -->
<!-- ============================================================= -->
<!--  Formal Public Identifier:  billres.xsl                       -->
<!--  SYSTEM:    Legislative Branch XSL                            -->
<!--  PURPOSE:   Contains Bill-specific information for display of -->
<!--             the Bills and Resolutions on the web              -->
<!--                                                               -->
<!--  CONTAINS:  1) Calls to res.dtd and bill.dtd                  -->
<!--             2) Overall structure of a Bill, Resolution,       -->
<!--                Amendments                                     -->
<!--                                                               -->
<!--  MODULES REQUIRED:                                            -->
<!--            XSL and DTD Common Elements
	Additional files required to be placed in same folder
	as billres.xsl:
	table.xsl (for tables)
	.gif (parchment on enrolled bills)
	light blue background.gif (blue for House engrossed bills)
	12 jpegs all beginning with the word "Enrolled" (This
	sets up the fancy Goudy type found at the beginning
	enrolled bills. as 0f 1/1/2012 good through 115th Congress)
	
-->
<!--                                                               -->
<!--  CREATED FOR:                                                 -->
<!--             House of Representatives, Senate and The Library  -->
<!--             of Congress                                       -->
<!--  ORIGINAL CREATION DATE:                                      -->
<!--             November 25, 2003                                 -->
<!--  DEVELOPED BY: Government Printing Office                     -->
<!--  DEVELOPER: Alia Malhas/Rost Schensnovich                       -->
<!--  SEND COMMENTS/QUERIES TO: Elena Tchumanov(etchumanov@gpo.gov) -->
<!-- ============================================================= -->
<!--                    CHANGE HISTORY
	Changes incorporated in version 3.9 (09/05/18):
	
	1. 	Fixed following reported-display-styles in the bill:
		reported-display-style=”brackets-boldface-roman”, 
		“brackets-boldface-italic”, “parentheses-boldface-roman”,
		“parentheses-boldface-italic” {in all browsers}.
	2. 	Reported-display-style values (italic, strikethrough,
		boldface-roman, boldface-italic, no change) display is fixed 
		according the rule, that if the child element is not defined with
		reported-display-style value, it should pick up from parent or it
		should get default value. And, if the child is defined with any
		above reported-display-style value, than it should remain defined
		value and not to pick up from parent. In general, verified and
		adjusted coding for the attributes value of the attribute change
		(added, deleted, no change). {In all browsers}.
	3. 	Fixed error where generated word “Sec." was not displaying in
		archaic style in quoted-block.
	4.	Fixed coding for “hidden” and “yes” values for commented attribute.
	    Everything defined with commented=”hidden” attribute should not appear 
	    and with commented=”yes” should have bold brackets.  
	5. 	Opening and closing brackets were missing or doubled in certain
		scenarios now appear.


	Changes incorporated in version 3.8 (12/22/17):

	1. Added missing strikes in quoted block at deleted <toc> in bill.
	2. Fixed missing strikeout type on the clause level when the clause
	   is a section wich has been marked as "deleted" {in all browsers}. 
	3. The word "DIVISION" now shows italic in Appropriations style in
	   reported bills where reported-display-style="italic". 
	4. Stopped displaying "EM dash" in the big levels (division through
	   subchapter) in amendments when these level-type'="undesignated".
	5. Created Star Print indicator (“Star Print” word together with
	   star sign) at the top left corner for Senate bills, resolutions,
	   requested as Senate-ordered Star Print ONLY at all stages.

	Changes incorporated in version 3.7.1 (10/18/17):
	1. Added Star Print indicator at the top for Senate order.       
	Changes incorporated in version 3.7 (05/26/17):
	1. Extended leaders closer to page numbers in right column of
        multi-column toc to eliminate white space.
	2. Added meta tag <meta http-equiv="X-UA-Compatible" content="IE=8" /> 
        to allow for legacy versions of IE. 
	
	Changes incorporated in version 3.6 (09/09/16):
	1. Stopped the strikethrough normally associated with deleted text
	continuing into the italic associated with added text found in the
	reported bills. In general, verified and adjusted coding for the
	attributes value of	the attribute change=.
	2. Fixed error where generated word section or sec. was not showing
	bold while the header in the same line was bold.
	3. Added coding to allow for creation of links from House resolutions
    proposing to amend House rules to the House Rules contained in the
    House Manual. 
	
	Changes incorporated in version 3.5.1 (12/23/15):
	1. Fixed coding for links to USC when chapter was called with no
	corresponding section in the code; updated some public law link
	coding as was looking for old GPO access website.		
	
	Changes incorporated in version 3.5 (12/15/15):
	1. Fixed type running together in multi-column toc elements found
	in some of the newer versions of browsers
	2. Adjusted code to cover for usc style multi-column toc, error had
	caused Chapter element found after the toc to go to the top of an
	enrolled bill
	3. Table not displaying when quoted-block was in traditional style
	now displays
	4. Alignment for headers in traditional style without enums now center 
	on page
	5. Action-date and Action-desc for concurrent resolutions now have proper
	capitalization and alignment
	6. Fixed alignment of headers in appropriations styles for reported bills   
	7. List now displays  when found within a section
	8. Within committee reports: 
	a. Stopped displaying "Part" in commitee-report-form if no form
	number was defined in the data
	b. Fixed indent when a header and the text following it both had
	the attribute "yes-display-inline"
	c. Made display of report-title all caps no matter how data was
	typed within a file
	d. Added rule at end of committee report
	e. Removed original coding for committee votes for House Committee
	on Rules as the committee has adopted the style created by 
	the committee vote utility
	f. Changed size of pl-cite and centered it   
	
	
	
	Changes incorporated in version 3.4 (05/26/15):
	1. Updated all text in bills, resolutions, and committee reports
	to be flush left instead of justified per request of Library of
	Congress.
	2. Separated billres.xsl into billres.xsl and billres-details.xsl
	so stylesheet could be incorporated into LOC stylesheet while still
	being used by other users
	3. Standardization of cascading stylesheet classes names, adding the 
	prefix LBEX, again to allow multiple useage of the stylesheet.
	4. No diplay of Quoted-toc-entry when found in elements subsection or
	below fixed so now display
	5. Added coding to allow display of Continuation-text in quoted-block
	for traditional, traditional-inline, archaic, and appropriations style 
	6. Added coding for display of the section-style attribute found on the
	big heads in appropriations
	7. Fixed stylesheet to allow the display of quoted-blocks in archaic
	style
	8. Improved stylesheet to keep in synchronization with xml to locator	
	translation. For more details see the Release Notes on the change
	management website: http://changemanagement.gpo.gov/ under the heading
	Congressional Bills 
	
	
	Changes incorporated in version 3.3 (03/18/14):
	1. Updated all text in bills, resolutions, and committee reports
	to be flush left instead of justified per request of Library of
	Congress.
	2. Separated billres.xsl into billres.xsl and billres-details.xsl
	so stylesheet could be incorporated into LOC stylesheet while still
	being used by other users
	3. Standardization of cascading stylesheet classes names, adding the 
	prefix LBEX, again to allow multiple useage of the stylesheet. 	
	
	Changes incorporated in version 3.2 (01/04/13):
	These changes were done to keep the web xslt stylesheet
	correctly display changes made in the xml to locator
	translation since the last release which was version 5.5.1.
	It should cover issues found in translation releases since
	September 2012. For more information see the Release Notes under
	the title Congressional bills on the Change Management website:
	http://changemanagement.gpo.gov/
	1. Adjusted total rows and the rules above them to more accurately
	reflect printed copy.
	2. Added committee-report-segment to amendments.
	3. Fixed display of subscript and supescript within toc-entries
	4. Brackets missing in certain scenarios around inline comments
	now appear
	5. Centered legis-num on endorsements for Internet Explorer
	6. Fixed display of division and subdivision headers
	
	
	
	Changes incorporated in version 3.1 (09/18/12):
	These changes were done to keep the web xslt stylesheet
	correctly display changes made in the xml to locator
	translation since the last release which was version 5.4.2.
	It should cover issues found in translation releases since
	February 2012. For more information see the Release Notes under
	the title Congressional bills on the Change Management website:
	http://changemanagement.gpo.gov/
	
	1. Fixed quoted-block starting with chapter level which 
	failed to display in Google Chrome
	2. Amendment-instruction now honors the default value of the
	blank-line-after attribute
	3. Fixed missing opening double quote for yes-display-inline
	subparagraph
	4. Worked on amendment display	

	Changes incorporated in version 3.1 (09/18/12):
	These changes were done to keep the web xslt stylesheet
	correctly display changes made in the xml to locator
	translation since the last release which was version 5.4.2.
	It should cover issues found in translation releases since
	February 2012. For more information see the Release Notes under
	the title Congressional bills on the Change Management website:
	http://changemanagement.gpo.gov/
	1. Fixed quoted-block starting with chapter level which 
	failed to display in Google Chrome
	2. Amendment-instruction now honors the default value of the
	blank-line-after attribute
	3. Fixed missing opening double quote for yes-display-inline
	subparagraph
	4. Worked on amendment display
	Changes incorporated in version 3.0 (07/02/12):
	These changes were done to keep the web xslt stylesheet
	correctly display changes made in the xml to locator
	translation since the last release which was version 5.4.2.
	It should cover issues found in translation releases since
	February 2012. For more information see the Release Notes under
	the title Congressional bills on the Change Management website:
	http://changemanagement.gpo.gov/
	1. Removed display of pre-form for amendments
	2. Allow comment to display in amendments
	3. Worked on missing quoted blocks from display such as  when
	quoted block started with a section in USC style (note verified
	in Internet Explorer extensively, but may still be problems in
	other browsers)
	4. In Firefox, fixed display of legis-num in enrolled bills so
	it no longer runs into the red border box and centered the 
	first-page-date in house amendments
	5. In Safari, Firefox and Google Chrome, for the element
	committee-report-subpara fixed the text size
	6. Adjusted coding to honor display="no" in various browsers on
	congress and session in house amendments
	7. Added support for footnotes for various documents 
	
	Changes incorporated in version 2.9 (02/21/12):
	These changes were done to keep the web xslt stylesheet
	correctly display changes made in the xml to locator
	translation since the last release. It should cover issues 
	found in translation releases since October 2011. For more
	information see the Release Notes under the title Congressional
	Bills on the Change Management website:http:
	//www.gpoaccess.gov/icreport/legdocs/change.htm
	Some of the corrections include:
	1. The form printing for the resolutions in the pre-introduction stage is 
	incorrect. The official title, current chamber and action description
	weren’t printed.
	2. Change display of committee votes (House Rules).
	3. Fixed problem with display of form information in enrolled
	bills
	4. Changed to proper format for toc-entries when these toc-entries
	were to be italic or strikethrough
	5. Justified text for committee reports
	
	Changes incorporated in version 2.8 (10/21/11):
	First release including rendering in browsers other than
	Internet Explorer. Specifically, the web xslt stylesheet was
	tested in the following browsers: Firefox (1.9.2.4280); 
	Safari(5.33.21.1) and Chrome (14.0.835.187).
	
		
	These changes were done to keep the web xslt stylesheet
	correctly display changes made in the xml to locator
	translation since the last release. It should cover issues 
	found in translation releases since June 2011. For more
	information see the Release Notes under the title Congressional
	Bills on the Change Management website:http:
	//www.gpoaccess.gov/icreport/legdocs/change.htm
	Some of the corrections include:
	1. Italic was not displaying in Firefox, Crome and Safari
	2. Fixed missing type in header found before and add-phrase
	element.
	3. Deleted space between italic header and generated period and
	em dash
	4. Adjusted coding for changing element name for headers in committee
	reports segments
	5. Official-title now displays twice where necessary when using Firefox
	6. Fixed display of outer quotes in certain nested-quoted-block scenarios
	7. Added coding to keep in sync with translate including allowing added-
	or deleted-phrases in afer-quoted-block, supporting subparagraph,
	margin-indent among others.  
	Changes incorporated in version 2.9 (02/21/12):
	These changes were done to keep the web xslt stylesheet
	correctly display changes made in the xml to locator
	translation since the last release. It should cover issues 
	found in translation releases since October 2011. For more
 	information see the Release Notes under the title Congressional
	Bills on the Change Management website:http:
	//www.gpoaccess.gov/icreport/legdocs/change.htm
	Some of the corrections include:
	1. The form printing for the resolutions in the pre-introduction stage is 
	incorrect. The official title, current chamber and action description
	 weren’t printed.
	2. Change display of committee votes (House Rules).
	3. Fixed problem with display of form information in enrolled
	bills
	4. Changed to proper format for toc-entries when these toc-entries
	were to be italic or strikethrough
 	5. Justified text for committee reports

	
	Changes incorporated in version 2.8 (10/21/11):
	First release including rendering in browsers other than
	Internet Explorer. Specifically, the web xslt stylesheet was
	tested in the following browsers: Firefox (1.9.2.4280); 
	Safari(5.33.21.1) and Chrome (14.0.835.187).
  	These changes were done to keep the web xslt stylesheet
	correctly display changes made in the xml to locator
	translation since the last release. It should cover issues 
	found in translation releases since June 2011. For more
 	information see the Release Notes under the title Congressional
	Bills on the Change Management website:http:
	//www.gpoaccess.gov/icreport/legdocs/change.htm
	Some of the corrections include:
	1. Italic was not displaying in Firefox, Crome and Safari
	2. Fixed missing type in header found before and add-phrase
	element.
	3. Deleted space between italic header and generated period 
	and em dash
	4. Adjusted coding for changing element name for headers in committee
	reports segments
	5. Official-title now displays twice where necessary when using Firefox
	6. Fixed display of outer quotes in certain nested-quoted-block scenarios
        7. Added coding to keep in sync with translate including allowing added-
	 or deleted-phrases in afer-quoted-block, supporting subparagraph,
	 margin-indent among others. 
	
	Changes incorporated in version 2.7 (06/21/11):
	These changes were done to keep the web xslt stylesheet
	correctly display changes made in the xml to locator
	translation since the last release. It should cover issues 
	found in translation releases since June 2010. For more
 	information see the Release Notes under the title Congressional
	Bills on the Change Management website.
	Some of the corrections include:
	1. Indent level for continuation-text to show proper
 	indentation level
	2. Removal of an unnecessary double closed quote only on the 
	last nested quoted block  
	3. Fixed Text in commitee-report-para which was printing as a
 	header  
 	4. Adjusted incorrect space between open quote mark and rules
	 header  
	5. Display of Opening and closing bold brackets in a deleted 
	TOC
	6. Added space between letters only when legis-type has data 
	"Report" only in committee reports
	7. Display of indentation on both sides for the new attribute
	for committee reports only "margin-index" 
	8. Added support for committee-report-subpara, Parts within
	committee reports  
	9 Allow added and deleted phrases in the after-quoted-block
 	element per change in dtd. 
	10. Graphic element added to web display.  -->
<!-- 	Changes incorporated in version 2.6 (06/22/10):
	These changes were done to keep the web xslt stylesheet
	correctly display changes made in the xml to locator
	translation since the last release. It should cover issues 
	found in translation releases since January 2010. 
	Some of the corrections include:
	1. Adding closing black brackets where missing, especially
	when the element's indentation level has been affected by
	up or down attribute values; also added missing brackets
	around the clause element 
	2. Fixing indentation issues found in certain scenarios
	involving up and down indentation attribute values
	3. Correcting error where style attribute not being picked 
	up in nested quoted blocks. 
	4. Now displaying the missing legis-num on endorsements 
	for engrossed amendments
	5. Allowing a word space between a closed quote and an
	opening bracket
	6. Fixing the display of appropriations section header
	7. Making the legis-num on endorsements all capitalized per
	correct style
	8. Adding various new development elements for committee
	reports including different style for committee votes for
	appropriations committee
	9. Dsiplaying opening bracket in commented Whereeas clause
	
	Changes incorporated in version 2.5 (12/22/09):
	These changes were done to keep the web xslt stylesheet
 	correctly display changes made in the xml to locator translation
 	since the last release. It should cover issues found in
        translation releases since January 2009. Some of the corrections
	include:
	1. Added anchors to sections per request
	2. Added committee-report-view and cbo-cost-estimate-line to the
        form of committee reports
	3. Added logic for undesignated-section-indent to display flush left
	when necessary
	4. Fixed boldface-roman reporting style for resolution
	5. Made the word "Amendment" in last amendment-description cap and small
	cap letter
	6. Added elements for amendments when printed by GPO
	7. Displayed official-title on endorsement in engrossed stage of concurrent
	resolutions
	8. Fixed the enum for section in appropriations style
	9. Fixed form for "house-order" type in resolutions 
	Changes incorporated in version 2.4 (9/02/09):
	These changes were done to keep the web xslt stylesheet
 	correctly display changes made in the xml to locator translation
 	since the last release. It should cover issues found in
        translation releases since January 2009. Some of the corrections
	include:
	1. Fixed fonts for Added and deleted phrases inside header-in-text
	for all styles
  	2. Fixed font changes necessary when Header-in-text element was
	inside added and deleted phrases all styles 
	3. Added and Deleted phrase inside TOC which was not displaying
	the strikethrough or added text 
	4. Worked on appropriations display to ensure that all headers
 	and text displayed properly, including  Appropriation Headers
	for Major and Intermediate levels where	there were added and/or
	deleted phrases was causing the headers	to break to multiple lines
	5. Fixed calendar number to display when display="yes" no matter
	what stage the bill shows 
	6. Corrected errors in Enum-in-header elements in the web
	7. Aligned display of tables within the web with changes made in
	the table tool including quote placement issues.
	8. Worked on formulas to display better on the web especially
	the quote issue.
	9. Text in the rules-paragraph now displays properly as running
	into the enum  
	Changes incorporated in version 2.3 (1/05/09):
	These changes were done in order to make the web xslt stylesheet
	correctly display Senate bills and resolutions though changes apply
	to both House and Senate bills and resolutions when necessary:
	1. Fixed tables making them a larger type size and filling the width 
	of the bill more closely as well as removing extra closed quotes as
	aligment issues.
	2. Missing type such as archaic-style subsection and paragraph headers
	now displays as does continuation-block text missing from some
	quoted blocks and calendar numbers for Placed-on-calendar stage.
	3. Returned paragraph indents to text in appropriations bills.
	4. Increased the indentation off the left margin of the carryover
	lines for section headers 
	5. Multiple Report numbers now appear on separate lines.
	6. Spacing issues around em dashes, usc section symbol and between
	enums worked to lessen white space 
	7. Missing strikethrough line in certain section enums and headers
	now aapears
	8. Fixed indentation on certain quoted blocks as well as missing
	quote marks at the beginning of quoted blocks
	9. Fixed indents on the Attest line, for continuation-text affected
	by the indent="up*" attribute for italic clause etc and various
	other scenarios -->
	
<!--                 
	Changes incorporated in version 2.2 (8/29/08): 
	1. Cleaned up the indention logic to eliminate wrong indentation
	on continuation-text, quoted-block elements and for the indent
	attribute among other scenarios
	2. Fixed error in display when quoted-block had yes-display-inline as
	the attribute value on the display-inline attribute
	3. Missing endorsement on Placed-on-Calendar for Senate bills now
	displays
	4. Correct display for added-phrase, quotes and deleted phrase in the
	short-title element
	5. Verified changes in 4.3.4 release work on web 
Changes incorporated in version 2.1 (6/20/08): 
1. All features found in the 4.3 translation release including:
   new style for Division, subdivision, chapter, subchapter for 
   traditional-inline and appropriations styles,  while the 
   section header for appropriation matches the traditional
   and not traditional-inline style
2. The displayHeader template has been completely optimized
3. The displayEnum template has been completely optimized 
4. Worked the stylesheet so that when file was pulled into a
   Microsoft Word
   document data did not get lost or jumbled.
5. Removed duplicate closed quotes at end of some quoted blocks
6. Fixed errors in added and deleted styles
Changes incorporated in version 2.0 (4/09/08) re-released with
css attached 4/10/09:
1. Parallel development for appropriations bills being added to
  he translate allowing for the following:
  a) the three appropriations blocks, small-, intermediate- and 
     major
  b) adding and deleting phrases and elements within appro-
	priations 
2. Fixed double printing of subsection in archaic and archaic-
   paragraph style
3. Fixed style for acronym as 1st word in header for elements from
   paragraph through subitem
4. Fixed superscripts to work on all big heads
5. Added various heads as found in committee prints
6. Adjusted the indentation on whereas clauses
7. Fixed header-in-text for certain styles (olc, traditional, usc
   archaic and archaic paragraph)
8. Added the generated text "Sec." in certain styles
9. Adjusted stylesheet to allow for Firefox browswer by cor-
   rected certain errors reported back to GPO (Note please report
   any errors specific to Firefox and we will try to incorporate
   them though no other browser will be worked at the moment). 
Changes incorporated in version 1.9 (2/08/08):
1. Added amendments and committee reports to the stylesheet though
   continued development may be need to these documents
2. Developed display for tables that will be using the new table
   tool but the existing display for legacy tables continues to work
3. In general, parallelled the development and bug issues found in
   printed copy from the last release including:
   a) enum-in-header in traditional style
   b) allowing for multiple action-date and action-desc elements on
      the endorsement
   c) last section of document not holding it style in a quoted block
   d) allowing the fraction in the big heads 
   e) allowing for added and deleted phrases in big heads
   f) allowed for appropriation elements
   g) fixed some reported bugs where strikethrough and italic were
      not showing 


Changes incorporated in version 1.8 (3/02/07):
1. Added to the coding to allow for more scenarios of a quoted-
   block within resolutions
2. Fixed the coding for enrolled bills to allow for the 110th and
   other Congresses
3. Adjusted coding to show constitution-articles for constitutional-
   amendments
4. Fixed missing quotes at the beginning of sections within enrolled
   bills  


Changes incorporated in version 1.7 (4/05/06):
1. Remove informational boxes from the top of the bills.
2. Fixed the coding for enrolled bills to allow for the 109th
   Congress

Changes incorporated in version 1.6 (9/23/05):
1. Eliminated display of attestor name when display="no" was the
   attribute.
2. Deleted additional official-title and chamber name that was
   appearing on House engrossed bills
3. Removed border box from House engrossed bills and added rule
   between end of bill and endorsement where necessary on House
   engrossed bills and resolutions
4. Adjusted House joint resolutions to reflect proper style.

Changes incorporated in version 1.5 (7/13/05):
1. Fixed engrossed stage to show a blue background for the House
   bills and resolutions while leaving the Senate versions with a
   white background
2. Added the first enrolled version of the bills and resolutions
   including a border around the bill and a parchment background.
3. Changed the information in the comment box found on House bills
   to correctly spell "activities" and to remove the "We welcome
   your comments"  line.

Changes incorporated in version 1.4 (2/22/05):
1. Added engrossed stage for both bills and simple, joint and
   concurrent resolutions.
2. Fixed bugs found in display dealing with display of headers in
   both traditional and archaic styles.

Changes incorporated in version 1.3.2 (1/27/05):
1. Fixed certain bugs found in the first bills of the 109th Congress
   including problems with semicolons in after quoted blocks; align-
   ment issues with clause as the first item in quoted block.
2. Started beginning stages of endorsed bills that simple resolutions
   are now displayable.

Changes incorporated in version 1.3 (12/29/04)
1. Added the typeface display elements used to amend bills; the four
   typefaces covered were strikethrough type, italic type, bold
   type and bold italic type.
2. Worked on completing the other styles including the big heads in
   text and toc, including internal links, in IRC, USC and traditonal
   and verifying they appeared correctly in the amended styles
   listed above. Started also the archaic style
3. Made corrections or additions to the header-in-text display in
   olc, usc, and traditional styles.
4. Added the following elements to the resolutions which reached a
   reported stage: calendar nos., report nos. and actions; also added
   the endorsement.

Changes incorporated in version 1.2 (9/09/04):
1. Added the following items, at least in initial simple scenarios
   in order to begin to run reported bills:
   a. Added to form calendar nos., report nos. and multiple
      actions, including adding the element action-instructions.
   b. Added endorsement including all elements.
   c. Define certain scenarios of reported bills, including without
      amendment, in the nature of a substitute, both single committee
      and multiple committee, and changes by one committee, showing
      text in strikethrough, italic and bold roman
2. Added the beginnings of the unnumbered list, defining them from
   section through sub-item but not defining them in relation to
   the "up*" attributes
3. Fixed the "up1" attribute to work in archaic style

Changes incorporated in version 1.1 (7/13/04):
1. Clean up and rewrite coding to adjust and/or add to the following
   coding tags and scenarios:
    a. The indents="up*" attributes (up1 to up6);
    b. The indent="down1" attribute;
    c. The indent as absolutes in the attribute;
    d. Quoted blocks affected the indent attribute occurring both
       within the quoted block and after the quoted block.
    e. Continuation text both in and out of quoted blocks and
       affected by the "indent=up*" attribute;
    f. quoted-block-continuation-text as affected by the above
       indent attributes.
2. Adjust logic to allow display of xml elements under Part and
   Chapter headings.
3. Account for quoted-blocks that run into the text
   before the quotes.
4. Allow display of tables in the paragraph and
   subparagraph elements.
                                                                   -->
<!-- Changes Date: April 2008
	Changes Owner : Tanya Braginsky	
	the complete appropriations functionality was inserted to make web to be identical with LXL translator for appropriations.
-->
<!-- ============================================================= -->
<!--                                                               -->
<!--                                                               -->
<!-- ========================== END ============================== -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ms="urn:schemas-microsoft-com:xslt" xmlns:dc="http://purl.org/dc/elements/1.1/">
	<xsl:include href="table.xsl"/>


	<xsl:variable name="enact"> Be it enacted by the Senate and House of Representatives of the
		United States of America in Congress assembled, </xsl:variable>
	<xsl:variable name="HouseResolution"> Resolved, </xsl:variable>
	<xsl:variable name="OrderedSection"> Ordered,</xsl:variable>
	<xsl:variable name="HouseJoint"> Resolved by the Senate and House of Representatives of the
		United States of America in Congress assembled, </xsl:variable>
	<xsl:variable name="HouseConcurrent"> Resolved by the House of Representatives (the Senate
		concurring), </xsl:variable>
	<xsl:variable name="ConstitutionalAmendment"> Resolved by the Senate and House of
		Representatives of the United States of America in Congress assembled (two-thirds of each
		House concurring therein), </xsl:variable>
	<xsl:variable name="SenateConcurrent"> Resolved by the Senate (the House of Representatives
		concurring), </xsl:variable>
	<xsl:variable name="SenateJoint"> Resolved by the Senate and House of Representatives of the
		United States of America in Congress assembled, </xsl:variable>
	<xsl:variable name="SenateResolution"> Resolved, </xsl:variable>
	<xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ'"/>
	<xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞß'"/>
	<xsl:variable name="number" select="0123456789"/>
	<xsl:variable name="punc" select="."/>
	<xsl:variable name="FlagTOC" select="bill/legis-body/section/subsection/toc"/>
	<xsl:variable name="billType" select="bill/@bill-type"/>
	<xsl:variable name="amendType" select="amendment-doc/@amend-type"/>
	<xsl:variable name="resolutionType" select="resolution/@resolution-type"/>
	<xsl:variable name="documentType" select="bill/@bill-type | resolution/@resolution-type"/>
	<xsl:variable name="billStage" select="bill/@bill-stage"/>
	<xsl:variable name="resolutionStage" select="resolution/@resolution-stage"/>
	<xsl:variable name="documentStage" select="bill/@bill-stage | resolution/@resolution-stage"/>
	<xsl:variable name="senateAmendment">
		<xsl:call-template name="IsSenateAmendment"/>
	</xsl:variable>
	<xsl:variable name="isReport">
		<xsl:call-template name="IsDocumentReport"/>
	</xsl:variable>
	<xsl:variable name="confReportStyle" select="//conference-report-form/@conference-report-style"/>
	<!-- this variable we need to be able to print headers and  -->
	<xsl:variable name="committeeID">
		<xsl:value-of select="//committee-report/@committee-id"/>
	</xsl:variable>
	<!--*****************is Stand alone vote**************-->
	<xsl:variable name="isStandAloneVote">
		<xsl:choose>
			<xsl:when
				test="//committee-report-form/@display = 'no' and contains(translate(//current-chamber, $upper, $lower), 'house')">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:strip-space elements="*"/>


	<xsl:template name="defineDocumentStyle">
		<style type="text/css">				
					a					{
		color: blue;
		text-decoration: none;
		}
.lbexAllcap {
		text-transform:uppercase;		
}	
.lbexMediumcap				{
		font-variant: small-caps;
		font-weight: bold;
		font-size: 16pt;
		}				
.lbexSmallcap				{
		font-variant: small-caps;
		font-weight: bold;																				
		}	
.lbexAllcapnormal				{
		font-size: 12pt;
		text-transform: uppercase;																				
		}
.lbexSimplecap				{
		font-variant: small-caps;
		}
.lbexSimplecapEx				{
		font-variant: small-caps;
		text-transform: uppercase;
		}
.lbexSimpleCapNormal				{
		font-variant: small-caps;
		text-transform: uppercase;
		font-weight: normal;
		}
.lbexInitialcap				{
		word-spacing: 2pt;
		letter-spacing: 1pt;
		font-variant: small-caps;
		font-weight: bold;
		text-transform: capitalize;
		}								
.lbexHang					{
		text-indent: -2em;		
		}
.lbexHangWithMargin			{
		text-indent: -2em;
                              margin-left: 2em		
		}
.lbexHangSmall		     
        {
        text-indent: -2em;	
		font-size: 11pt;
		}
		
.lbexHangSmalllWithMargin				
        {
		text-indent: -2em;	
		font-size: 11pt;
		 margin-left: 2em
		}
.lbexIndent					{
		text-indent: 2em;		
		}
.lbexNoMargin					{
		margin-left: 0em;		
		}		
.lbexIndentSubsection			{
		text-indent: 2em;
		margin-left: 0em;
		text-align:left;
		}	
.lbexIndentParagraph			{
		text-indent: 2em;
		margin-left: 2em;
		text-align:left;
		}
.lbexIndentSubpar                                                {
		text-indent: 2em;
		margin-left: 4em;
		text-align:left;
		}
.lbexNonIndentSubpar                                                {
		text-indent: 0em;
		margin-left: 4em;
		text-align:left;
		}
.lbexIndentClause                                                   {
		text-indent: 2em;
		margin-left: 6em;
		text-align:left;
		}
.lbexNonIndentClause                                                   {
		text-indent: 0em;
		margin-left: 6em;
		text-align:left;
		}
.lbexIndentSubclause                                         {
		text-indent: 2em;
		margin-left: 8em;
		text-align:left;
		}
.lbexNonIndentSubclause                                         {
		text-indent: 0em;
		margin-left: 8em;
		text-align:left;
		}
.lbexIndentItem                                                      {
		text-indent: 2em;
		margin-left: 10em;
		text-align:left;
		}
.lbexIndentSubItem				{
		text-indent: 2em;
		margin-left: 12em;
		text-align:left;
		}
.lbexNonIndentItem                                                      {
		text-indent: 0em;
		margin-left: 10em;
		text-align:left;
		}
.lbexNonIndentSubItem				{
		text-indent: 0em;
		margin-left: 12em;
		text-align:left;
		}
.lbexIndentFour {
        text-indent: 4em;
        }
 .lbexIndentFive {
        text-indent: 5em;
        }
.lbexNonIndentSubsection         {
        text-indent:0em;
        margin-left:0em;
        text-align:left;
        }
.lbexNonIndentParagraph			{
		text-indent: 0em;
		margin-left: 2em;
		/*text-align:left;*/
		}
.lbexIndentZero{
		text-indent: 0;
		}
.lbexLegisNum				{ 
		font-size: 37pt;
		font-weight: bold;
		}
.lbexLegisNumAvg			{						
		font-size: 36pt;						
		font-weight: bold;
		letter-spacing: -2pt;							
		}		
.lbexLegisNumLrg			{				
		font-size: 37pt;
		font-weight: bold;	
		letter-spacing: -3pt;				
		}
.lbexLegisNumSml			{				
		font-size: 17pt;
		font-weight: bold;											
		}
.lbexLegisType				{
		font-size: 30pt;
		}
.lbexChamber				{
		font-size: 15pt;
		}
.lbexChamberEngrHouse		{
		font-size: 20pt;
		font-weight: bold;
		font-style:italic;
		}
.lbexBldItalic {
		font-weight: bold;
		font-style:italic;    
		}
.lbexCongressEnrolled		{
		font-size: 30pt;
		font-weight: bold;
		font-family: Monotype Corsiva;
		}		
.lbexlegisEnrolled			{
		font-size: 30pt;
		font-weight: bold;
		font-family: Monotype Corsiva;
		word-spacing: 2pt;
		letter-spacing: 1pt;
		font-variant: normal;						
		text-transform: capitalize;
		}
.lbexLegisEngrossed			{
		font-size: 30pt;
		font-weight: bold;
		font-family: Monotype Corsiva;
		word-spacing: 2pt;
		letter-spacing: 1pt;						
		text-transform: capitalize;
		}
.lbexSessionEnrolled		{
		font-size: 12pt;
		font-weight: bold;						
		}
.lbexTextNormalBold		{
		font-size: 12pt;
		font-weight: bold;	
		text-transform:none;
		font-variant: normal;
		}
.lbexDateEnrolled		{
		font-size: 10pt;						
		font-style:italic;
		font-weight: bold;
		}	
.lbexThinSpace				{
		word-spacing: -5pt;
		}
.lbexNSpace				{
		word-spacing: -1pt;
		}
.lbexOmmitedTextSpace				{
		word-spacing: 60pt;
		}
.lbexInitialCapArchaic		{
		font-variant: normal;
		text-transform: capitalize;
		}
.lbexSectionlevelItalicOLCBold	{
		font-size:14pt;
		font-weight:bold;
        font-style:italic;		
		}
.lbexSectionlevelOLC		{						
		font-size:12pt;
		font-weight:bold;		
		}
.lbexSectionlevelOLCBold	{
		font-size:14pt;
		font-weight:bold;						
		}		
.lbexTitleLevelOLC			{
		font-size:18pt;
		font-weight:bold;
		}
.lbexSubTitleLevelOLC		{
		word-spacing: 2pt;
		letter-spacing: 1pt;
		font-variant: normal;
		font-size:18pt;
		font-weight:bold;
		text-transform: capitalize;
		}	
.lbexSubTitleLevelOLCBold	{
		word-spacing: 2pt;
		letter-spacing: 1pt;
		font-variant: normal;
		font-size:20pt;
		font-weight:bold;
		text-transform: capitalize;
		}
.lbexChapterLevelOLC		{		
		font-size:16pt;
		font-weight:bold;				
		}
.lbexChapterLevelOLCBold	{		
		font-size:20pt;
		font-weight:bold;
		}
.lbexSubChapterLevelOLC		{
		word-spacing: 2pt;
		letter-spacing: 1pt;
		font-variant: normal;
		font-size:16pt;
		font-weight:bold;
		text-transform: capitalize;
		}
.lbexChapterLevelOLCNuclear		{		
		font-size:16pt;						
		}
.lbexChapterLevelOLCBoldNuclear		{		
		font-size:16pt;
        font-weight:bold;						
		}
.lbexSectionLevelOLCnuclear		{		
		word-spacing: 2pt;
		letter-spacing: 1pt;
		font-variant: small-caps;						
		text-transform: capitalize;
		}
.lbexSubpartLevelOLC		{
		word-spacing: 2pt;
		letter-spacing: 1pt;
		font-variant: normal;
		font-size:14pt;
		font-weight:bold;
		text-transform: capitalize;
		}
.lbexTocSectionOLC			{		
		font-size: 80%;						
		text-indent: 2em;
		margin-left: 2em;						
		}
.lbexTocDivisionOLC			{			
		font-size: 11pt;
		}
.lbexTocSubDivisionOLC		{			
		font-size: 10pt;
		font-variant: small-caps;
		text-transform: capitalize;
		}
.lbexTocSubTitleOLC			{
		font-variant: normal;
		text-transform: capitalize;
		font-size: 11pt;
		}		
.lbexTocSubChapterOLC		{						
		font-size: 9pt;
		}
.lbexTocSubPartOLC     		{
		font-variant: small-caps;
		font-size: 9pt;
		}	
.lbexSmallCapTrad			{	
		font-variant: small-caps;						
		font-size: 12pt;
		}
.lbexSmallCapBackTitle			{	
		font-variant: small-caps;						
		font-size: 11pt;
		}
.lbexInitialCapTrad			{
		word-spacing: 2pt;
		letter-spacing: 1pt;
		font-size: 14pt;
		font-variant: small-caps;
		text-transform: capitalize;
		}
.lbexInitialCapTradInd			{
		word-spacing: 2pt;
		letter-spacing: 1pt;
		font-size: 14pt;
		font-variant: small-caps;
		text-transform: capitalize;
		text-indent: 2em;
		}
.lbexLargeCapTrad			{						
		font-variant: small-caps;						
		font-size: 16pt;
		}
.lbexSectionTitleTrad 		{
		font-variant: small-caps;
		text-transform: capitalize;
		}
.lbexSectionLevelTradBold	{			
		font-size:14pt;
		}
.lbexSectionLevelTradBoldUp	{			
		font-size:14pt;
		text-transform: uppercase;
		}
.lbexRepTitle	{			
		font-size:15pt;
		}
.lbexTitleLevelTrad			{
		font-size:16pt;
		font-variant: small-caps;
		text-transform: capitalize;
		}				
.lbexTitleLevelTradIn			{
		font-size:16pt;
		text-transform: uppercase;
		font-weight:bold;
		}		
.lbexTitleLevelTradEx          {
        font-size:16pt;		
		text-transform: uppercase;
        }
.lbexTitleLevelTradBold		{
		font-size:18pt;
		}
.lbexSubTitleLevelTrad		{		
		word-spacing: 2pt;
		letter-spacing: 1pt;
		font-size:16pt;
		font-variant: normal;
		text-transform: capitalize;
		}
.lbexSubTitleLevelTradUp		{		
		word-spacing: 2pt;
		letter-spacing: 1pt;
		font-size:16pt;
		font-variant: normal;
		text-transform: uppercase;
		}
.lbexPartlevelTrad			{
    	font-size:16pt;
    	font-variant: small-caps;
    	text-transform: capitalize;
    	}
.lbexSubPartLevelTradBold	{
		word-spacing: 2pt;
		letter-spacing: 1pt;
		font-variant: normal;
		font-size:18pt;
		text-transform: capitalize;
		}
.lbexChapterLevelTrad		{
		word-spacing: 2pt;
		letter-spacing: 1pt;						
		text-transform: uppercase; 
		font-size:16pt;
		font-weight:bold;
		}
.lbexSubChapterLevelTrad	{
		word-spacing: 2pt;
		letter-spacing: 1pt;
		font-variant: small-caps;
		text-transform: capitalize;
		font-size:16pt;
		}
.lbexSubChapterLevelTradEx       {
                            word-spacing: 2pt;
		letter-spacing: 1pt;		
		text-transform: uppercase;
		font-size:16pt;
        }
.lbexSubChapterLevelTradInline	{
		word-spacing: 2pt;
		letter-spacing: 1pt;	
		font-variant: small-caps;
		font-size:16pt;			
		}
.lbexSubChapterLevelTradBold {
		word-spacing: 2pt;
		letter-spacing: 1pt;
		font-variant: small-caps;
		text-transform: capitalize;
		font-size:18pt;
		}
.lbexTocSectionTrad			{			
		font-size: 80%;
		text-indent: 2em;
		margin-left: 2em;
		}
.lbexTocTitleTrad			{												
		font-size: 11pt;
		font-variant: normal;			
		}
.lbexTocChapterTrad     	{						
		font-variant: small-caps;						
		text-transform: capitalize;
		font-size: 11pt;	
		}
.lbexTocSubchapterTrad		{
		font-variant: normal;		
		font-size: 11pt;
		}
.lbexTocPartTrad     		{				
		font-variant: small-caps;
		font-size: 10pt;
		}
.lbexTocSubPartTrad     	{
		font-variant: normal;		
		font-size: 10pt;
		}

.lbexSectionLevelIRCEx		{				
        font-size:12pt;
        font-weight:bold;
        text-transform: uppercase;
		}	
.lbexTitleLevelIRCEx		{
		font-size:18pt;
		font-weight:bold;
		text-transform: uppercase;	
		}
.lbexSubTitleLevelIRCBold	{
		word-spacing: 2pt;
		letter-spacing: 1pt;
		font-variant: normal;
		font-size:22pt;
		font-weight:bold;
		text-transform: capitalize;
		}		
.lbexChapterLevelIRCEx		{
		font-size:16pt;
		font-weight:bold;
		text-transform: uppercase;	
		}	
.lbexPartLevelIRCEx			{
		font-size:14pt;
		font-weight:bold;		
		text-transform: uppercase;
		}	
.lbexTocSectionIRCTax		{
		font-size:11pt;
		font-variant: normal;
		text-transform: capitalize;
		}
.lbexTocSectionIRCBold		{
	      font-size:12pt;
		}
.lbexTocBigCapsLowCapsIRC	{
		font-size:11pt;
		font-variant: small-caps;
		text-transform: capitalize;
		}
.lbexTocBigCapsLowCapsIRCBold{
		font-size:12pt;
		font-variant: small-caps;
		text-transform: capitalize;
		}
.lbexTocPartIRCBold			{
		font-variant: normal;
		text-transform: capitalize;
		font-size: 12pt;
		}
.lbexInitialCapUSC			{	
		font-variant: small-caps;						
		font-size: 14pt;
		text-transform:uppercase;
		}				
.dot-leader				{			
		vertical-align:bottom;
		background-image:url(dot_line1.gif);
		background-repeat:repeat-x;
		background-position: bottom;
		}
.td						{		
		font-size:90%;
		}	
.lbexCalendarOLC			{
		font-size:24pt;
		font-weight:bold;
		letter-spacing: -1pt;						
		}	
.lbexHangTable				{
		text-indent: -3em;
		font-size:10pt;											
		}
		
.lbexEndsmtHead				{
		font-size:12pt;
		font-weight:bold;
		}
.lbexEndsmtSimpleCap		{
		font-size:10pt;						
		font-variant: small-caps;
		}
.lbexSmtlegisNum			{				
		font-size: 28pt;
		font-weight: bold;
		}
.lbexSmtlegisNumAvg			{
		font-size: 28pt;
		font-weight: bold;
		letter-spacing: -2pt;
		text-transform:uppercase;
		}
.lbexSmtlegisNumlrg			{
		font-size: 28pt;
		font-weight: bold;
		letter-spacing: -3pt;
		text-transform:uppercase;
		}
.lbexEnumUcs {
		word-spacing: -3pt;    
		}
.lbexBold				{
		font-weight: bold;
		}	
.lbexBoldLrge				{
		font-weight: bold;
		font-size: 15pt;
		}	
.lbexBrakets			{
		font-size: 16pt;
		font-weight: bold;
		font-family: Arial;						
		}
.lbexAttest				{
		font-size: 13pt
		}	
.lbexHeaderAppropMajor {
        font-size: 16pt; 		
		text-transform: uppercase;		
		}	
.lbexHeaderAppropMajorItalic {
        font-size: 16pt; 		
		text-transform: uppercase;	
		font-style:italic;
		}
.lbexHeaderAppropIntermediate {
     		font-size:16pt;
    		font-variant: small-caps;
    		text-transform: capitalize;    		
    	}
.lbexHeaderAppropIntermediateItalic {
     		font-size:16pt;
    		font-variant: small-caps;
    		text-transform: capitalize;    
    		font-style:italic;
    	}
.lbexHeaderAppropSmall {
		font-variant: small-caps;
		text-transform:lowercase;		
		}
.lbexHeaderAppropSmallItalic {
		font-variant: small-caps;
		text-transform:lowercase;		
		font-style:italic;
		}
.lbexAllNormal  {
        font-variant: normal;
        text-transform: lowercase;
        }   
.lbexVotesStyle {
        font-family: Arial Narrow; 
        }   
.lbexSmallText {
         font-size: 12pt;
        }
 .lbexSmallTextNormal {
         font-size: 12pt;
         text-transform:none;
         font-variant: normal;
        }     
.lbexTextNormal {         
         text-transform:none;
         font-variant: normal;
        } 
 .lbexBlack
        {
        color:black;
        }
.lbexListStyle
        {
        list-style-type:lower-alpha;
        }
.lbexTextStrikethrough
{
    text-decoration:line-through;
}

.lbexBlockNeutral
{
    text-decoration: none;
    display: block;
}

.lbexTextNeutral
{
    text-decoration: none;
    display: inline-block;
    margin-left:inherit;
}

.lbexTextNeutralInline
{
    text-decoration: none;
    display: inline-block;    
}

.lbexTableStyleOne
{
    width:100%;
    text-align:left;
}
.lbexTableStyleTwo
{
    width:70%;
}
.lbexTableStyleThree
{
    width:12%;
    height:50px;
    text-align:right;
}
.lbexTableStyleFour
{
    width:25%;
    height:50px;
    text-align:right;
}
.lbexTableStyleFive
{
     width:80%;
     border-style:solid;
     border-width:thin;
     border-color:gray;
}
.lbexTableStyleSix
{
    width:25%;
    height:50px;
    text-align:left;
}
.lbexTableStyleSeven
{
    width:80%;       
    font-size:14pt;
}
.lbexTableStyleEight
{
    width:90%;       
    font-size:14pt;
}

.lbexTableStyleEight    {
    width:80%;   
     font-size:12pt;
}

.lbexTableStyleEnr
{
     width:100%;
     border-style:solid;
     border-width:medium;
     border-color:#CC0000;
     padding:30px;
}
.lbexReportCoverTableTop
{    
    border-bottom-style:solid;
    border-bottom-width:thin;
    border-bottom-color:gray;
}
.lbexTdStyleOne
{
    width:3%;
    text-align:right;
}
.lbexTdStyleTwo
{
    width:10%;
    text-align:right;
}
.lbexTdStyleThree
{
    width:25%;
    text-align:left;
}
.lbexTdStyleFour
{
    width:6%;
    text-align:center;
}
.lbexTdStyleFourStAlone
{
    width:12%;
    text-align:center;
}
.lbexTdStyleSix
{
    width:50%;
    text-align:right;
}
.lbexTdStyleSeven
{
    width:6%;
}
.lbexGeneralStyle100
{
    width:100%;
}
P.lbexBreakHere {page-break-before: always}
			body.lbexBody					{
			font-size: 14pt;
			margin-left: 40pt;
			margin-right: 40pt;						
			<xsl:choose>
				<xsl:when test="
						$resolutionStage = 'Enrolled-House' or $resolutionStage = 'Enrolled-in-Senate'
						or $billStage = 'Enrolled-Bill' or $resolutionStage = 'Enrolled-Bill' or
						$resolutionStage = 'Re-enrolled-in-Senate' or
						$billStage = 'Re-Enrolled-Bill'">
					background-image: url(background.gif);
				</xsl:when>
				<xsl:when test="
						$resolutionStage = 'Engrossed-in-House' or
						$billStage = 'Engrossed-in-House' or $resolutionStage = 'Engrossed-House' or
						$billStage = 'Engrossed-House'">
					background-image: url(light_blue_bkg.gif);
				</xsl:when>
			</xsl:choose>
			}
			
			ul.leaders
			{
			    padding: 0px;
			}
			
			ul.leaders li
			{
			    display: table;
			}
			
			ul.leaders li span
			{
			    display: table-cell;
			}
			
			ul.leaders li span:first-child
			{ /* TITLE */
			    position: relative;
			    overflow: hidden; /* Don't go underneath the page number */
			}
			
			ul.leaders li span:first-child:after
			{ /* DASHES */
			    content: "";
			    position: absolute;
			    bottom: 0.5em; /* Set as you want */
			    margin-left: 0.5em; /* Keep same for the next span's left padding */
			    width: 100%;
			    border-bottom: 1px dashed #000;
			}
			
			ul.leaders li span + span
			{ /*page number*/
			    text-align: right;
			    width: 0.01%; /* Trick it */
			    vertical-align: bottom; /* Keep text bottom-aligned */
			    padding-left: 0.5em;
			    text-indent: 0;
			    /* white-space: nowrap;       /* Uncomment if needed */
			}
			.noneTextDecorationBlock{
			    display: inline-block;
			    text-decoration: none;
			}
			
			.noneTextDecorationInline{
			    display: inline-block;
			    text-decoration: none;
			    /*  margin-left: -40px; */
			    margin-top: -20px;
			}
			.normalFontStyleBlock{
			    font-style: normal;
			    font-weight: normal;
			}
			.normalFontStyleInline{
			    font-style: normal;
			    font-weight: normal;
			    margin-left: -0px;
			    margin-top: -20px;
			}
			.lbexChapterLevelOLCNuclearIn{
			    font-size: 16pt;
			    margin-bottom: 40px;
			    margin-top: -20px;
			}
			.lbexSimpleItalic{
			    font-style: italic;
			    font-weight: normal;
			}
			.lbexChapterLevelOLCNuclearIn{
			    font-size: 16pt;
			    margin-top: 10px;
			}
			.hidden {
               display: none;
            }</style>
	</xsl:template>

	<xsl:template name="printDocumentTitle">
		<xsl:call-template name="GetNumberToPrint"/>
		<xsl:text> (</xsl:text>
		<xsl:value-of select="bill/@bill-stage"/>
		<xsl:value-of select="resolution/@resolution-stage"/>
		<xsl:value-of select="amendment-doc/@amend-type"/>
		<xsl:value-of select="committee-report/committee-report-form/legis-type"/>
		<xsl:text>)</xsl:text>
	</xsl:template>

	<xsl:template name="prePrintWebDocument">
		<xsl:variable name="drawRedBoarder">
			<xsl:choose>
				<xsl:when
					test="
						$documentStage = 'Enrolled-in-Senate'
						or $documentStage = 'Enrolled-House'
						or $documentStage = 'Enrolled-Bill'
						or $documentStage = 'Re-Enrolled-in-Senate'
						or $documentStage = 'Re-Enrolled-Bill'
						">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no</xsl:text>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:variable>
		<xsl:if
			test="
				$billStage = 'Enrolled-Bill' or $resolutionStage = 'Enrolled-in-Senate' or
				$resolutionStage = 'Enrolled-House' or $resolutionStage = 'Enrolled-Bill'">
			<table class="lbexGeneralStyle100">
				<tr>
					<td style="width:5%"/>
					<td style="width:40%">
						<xsl:if test="not(//form/legis-num/@display = 'no')">
							<span class="lbexSectionLevelTradBold">
								<xsl:text>    </xsl:text>
								<xsl:apply-templates select="//form/legis-num"/>
							</span>
						</xsl:if>
					</td>
					<td style="width:10%"/>
					<xsl:choose>
						<xsl:when test="//form/action/action-date != ''">
							<td class="lbexSectionLevelTradBold" style="width:40%;text-align:right">
								<xsl:value-of select="//form/action/action-desc"/>
								<xsl:text> </xsl:text>
								<xsl:value-of select="//form/action/action-date"/>
							</td>
							<td style="width:5%"/>
						</xsl:when>
						<xsl:otherwise>
							<td style="width:50%"/>
						</xsl:otherwise>
					</xsl:choose>

				</tr>
			</table>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="$drawRedBoarder = 'yes'">
				<table class="lbexTableStyleEnr">
					<tr style="height:30px">
						<td style="width:5%"/>
						<td/>
						<td style="width:5%"/>
					</tr>
					<tr>
						<td style="width:5%"/>
						<td>
							<xsl:call-template name="printWebDocument"/>
						</td>
						<td style="width:5%"/>
					</tr>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="printWebDocument"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="printWebDocument">
		<p/>
		<!-- TB 4Jan2008  -->
		<xsl:if test="//pre-form/meta-senate">
			<xsl:apply-templates select="//pre-form/meta-senate"/>
		</xsl:if>

		<xsl:call-template name="PrintStarInLeftCornerForSenate"/>

		<xsl:apply-templates select="bill"/>
		<xsl:apply-templates select="resolution"/>
		<xsl:apply-templates select="amendment-doc"/>
		<xsl:apply-templates select="committee-report"/>
	</xsl:template>

	<xsl:template name="DisplayEndorsement">
		<xsl:param name="displayFlag"/>
		<xsl:choose>
			<xsl:when test="$displayFlag = 'no'"/>
			<xsl:when test="//amendment-doc/@dms-id = 'G'">
				<p class="lbexBreakHere"/>
				<div style="text-align:center">
					<xsl:value-of select="//amendment-form/amend-num"/>
					<br/>
					<p/>
					<xsl:value-of select="//amendment-form/legis-num"/>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<p class="lbexBreakHere"/>
				<div style="text-align:center">
					<table class="lbexTableStyleTwo" align="center">
						<xsl:if
							test="not(//first-page-header/@display = 'no') and not(//pre-form/@display = 'no') and contains(translate(//first-page-header/text(), $upper, $lower), 'committee')">
							<tr>
								<td>
									<div style="text-align:center">
										<xsl:if test="not(//first-page-header/@display = 'no')">
											<p class="lbexSectionlevelOLCBold">
												<xsl:value-of select="//first-page-header"/>
											</p>
										</xsl:if>
									</div>
								</td>
							</tr>
						</xsl:if>
						<tr>
							<td>
								<p style="text-align:right;" class="lbexEndsmtHead">
									<xsl:if
										test="not(//form/calendar/@display = 'no') and not(//form/@display = 'no')">
										<xsl:apply-templates select="form/calendar"/>
									</xsl:if>
									<!-- TB 10Jan2008 -->
									<xsl:if test="not(//amendment-form/calendar/@display = 'no')">
										<xsl:apply-templates select="//amendment-form/calendar"/>
									</xsl:if>
									<xsl:if
										test="not(//engrossed-amendment-form/calendar/@display = 'no')">
										<xsl:apply-templates
											select="//engrossed-amendment-form/calendar"/>
									</xsl:if>
								</p>
							</td>
						</tr>
						<tr>
							<td>
								<table class="lbexTableStyleOne" style="width:100%">
									<tr>
										<td style="width:20%;text-align:left">
											<div class="lbexEndsmtSimpleCap" style="text-align:left">
												<xsl:if
												test="//form/congress and (not(//form/congress/@display = 'no') and not(//form/@display = 'no'))">
												<xsl:apply-templates select="form/congress"/>
												</xsl:if>
												<xsl:if test="//amendment-form/congress">
												<xsl:apply-templates
												select="//amendment-form/congress">
												<xsl:with-param name="source"
												>Endorsement</xsl:with-param>
												</xsl:apply-templates>
												</xsl:if>
												<xsl:if test="//engrossed-amendment-form/congress">
												<xsl:apply-templates
												select="//engrossed-amendment-form/congress"/>
												</xsl:if>
												<br/>
												<xsl:text disable-output-escaping="yes">&#x00A0;</xsl:text>
												<xsl:text disable-output-escaping="yes">&#x00A0;</xsl:text>
												<xsl:text disable-output-escaping="yes">&#x00A0;</xsl:text>
												<xsl:text disable-output-escaping="yes">&#x00A0;</xsl:text>
												<xsl:text disable-output-escaping="yes">&#x00A0;</xsl:text>
												<xsl:if
												test="//form/session and (not(//form/session/@display = 'no') and not(//form/@display = 'no'))">
												<xsl:apply-templates select="form/session"/>
												</xsl:if>
												<!--xsl:if test="not (//amendment-formsession/@display='no')"-->
												<xsl:if test="(//amendment-form/session)">
												<xsl:apply-templates
												select="//amendment-form/session">
												<xsl:with-param name="source"
												>Endorsement</xsl:with-param>
												</xsl:apply-templates>
												</xsl:if>
												<!--xsl:if test="not (//engrossed-amendment-form/session/@display='no')"-->
												<xsl:if test="//engrossed-amendment-form/session">
												<xsl:apply-templates
												select="//engrossed-amendment-form/session"/>
												</xsl:if>
											</div>
										</td>
										<xsl:variable name="theNumberToPrint">
											<xsl:call-template name="GetNumberToPrint"/>
										</xsl:variable>
										<xsl:if
											test="(not(//legis-num/@display = 'no') and not(//form/@display = 'no')) or $amendType = 'engrossed-amendment'">
											<td style="text-align:center">
												<xsl:variable name="tempNumberToPrint"
												select="$theNumberToPrint"/>
												<xsl:choose>
												<xsl:when
												test="string-length($theNumberToPrint) = 16">
												<span class="lbexSmtlegisNumlrg">
												<xsl:value-of select="$theNumberToPrint"/>
												</span>
												</xsl:when>
												<xsl:when
												test="string-length($theNumberToPrint) &lt; 16 and string-length($theNumberToPrint) &gt; 13">
												<table class="lbexTableStyleThree">
												<tr>
												<td/>
												</tr>
												<tr>
												<td/>
												</tr>
												</table>
												<div style="text-align:center">
												<span class="lbexSmtlegisNumlrg">
												<xsl:value-of select="$theNumberToPrint"/>
												</span>
												</div>
												</xsl:when>
												<xsl:when
												test="string-length($theNumberToPrint) &lt; 14 and string-length($theNumberToPrint) &gt; 10">
												<table class="lbexTableStyleFour">
												<tr>
												<td/>
												</tr>
												<tr>
												<td/>
												</tr>
												</table>
												<div style="text-align:center">
												<span class="lbexSmtlegisNumAvg">
												<xsl:value-of select="$theNumberToPrint"/>
												</span>
												</div>   
												</xsl:when> 
												<xsl:when
												test="number(string-length($theNumberToPrint)) &lt; 11">
												<table class="lbexTableStyleFour">
												<tr>
												<td/>
												</tr>
												<tr>
												<td/>
												</tr>
												</table>
												<div style="text-align:center">
												<span class="lbexSmtlegisNum">
												<xsl:value-of select="$theNumberToPrint"/>
												</span>
												</div>

												</xsl:when>
												</xsl:choose>

											</td>
											<td style="width:20%"/>
										</xsl:if>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<xsl:if
								test="not(form/associated-doc/@display = 'no') and not(//form/@display = 'no')">
								<td>
									<!--div align="center" class="EndsmtHead"-->
									<!-- TB 12-Dec-2008 fixing of printing several accoc. docs in different lines.   -->
									<!--xsl:value-of select="form/associated-doc"/-->
									<xsl:apply-templates select="form/associated-doc"
										mode="Endorsement"/>
									<!--/div-->
									<hr/>
								</td>
							</xsl:if>
						</tr>
						<tr>
							<td>
								<xsl:if
									test="form/associated-doc/@display = 'no' or //form/@display = 'no' and (not(//legis-type/@display = 'no') and not(//form/@display = 'no'))">
									<hr/>
								</xsl:if>
								<xsl:if
									test="not(//legis-type/@display = 'no') and not(//form/@display = 'no')">
									<div style="text-align:center" class="lbexChapterLevelOLCBold">
										<xsl:apply-templates select="form/legis-type"/>
										<xsl:apply-templates select="//amendment-form/legis-type"/>
										<xsl:if test="//engrossed-amendment-form/legis-type">
											<xsl:call-template name="printEngrossedAmendLegisType"/>
										</xsl:if>
									</div>
								</xsl:if>
							</td>
						</tr>
						<tr>
							<td>
								<!--ul-->
								<xsl:variable name="oficialTitleToValidateLength">
									<xsl:call-template name="getOficialTitleToValidateLength"/>
								</xsl:variable>
								<xsl:if
									test="((not(//official-title/@display = 'no') and not(//form/@display = 'no')) or (contains(translate($documentStage, $upper, $lower), 'engrossed') and contains(translate($documentType, $upper, $lower), 'concurrent'))) and not(//amendment-doc)">
									<xsl:choose>
										<xsl:when
											test="string-length($oficialTitleToValidateLength) &lt; 75">
											<div class="lbexHangTable"
												style="align:center;margin-left: 2em">
												<xsl:apply-templates select="form/official-title"/>
												<xsl:apply-templates
												select="//amendment-form/official-title"/>
												<xsl:apply-templates
												select="//engrossed-amendment-form/form/official-title"
												/>
											</div>
										</xsl:when>
										<xsl:otherwise>
											<div class="lbexHangTable"
												style="text-align:left;margin-left: 4em">
												<xsl:apply-templates select="form/official-title"/>
												<xsl:apply-templates
												select="//amendment-form/official-title"/>
												<xsl:apply-templates
												select="//engrossed-amendment-form/form/official-title"
												/>
											</div>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
								<!--/ul-->
								<xsl:if
									test="not($resolutionStage = 'Engrossed-in-Senate' or $billStage = 'Engrossed-in-Senate' or $amendType = 'engrossed-amendment' or $billStage = 'Pre-Introduction') and not(//amendment-doc)">
									<hr/>
								</xsl:if>
							</td>
						</tr>

						<xsl:for-each select="endorsement/action-date">
							<xsl:call-template name="ActualPrintEndorsmentAction"/>
						</xsl:for-each>

					</table>
				</div>
			</xsl:otherwise>
		</xsl:choose>


	</xsl:template>

	<xsl:template name="ActualPrintEndorsmentAction">
		<tr>
			<td>
				<xsl:choose>
					<xsl:when
						test="(translate($documentStage, $upper, $lower) = 'engrossed-in-senate' or translate($documentStage, $upper, $lower) = 'engrossed-amendment-senate') and (//bill/@public-print = 'yes' or //resolution/@public-print = 'yes')">
						<xsl:if test="not(@display = 'no')">
							<div style="text-align:center" class="lbexBold">
								<xsl:value-of select="."/>
							</div>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="not(@display = 'no')">
							<div style="text-align:center" class="lbexEndsmtSimpleCap">
								<xsl:value-of select="."/>
							</div>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
		<xsl:if test="local-name(following-sibling::*[1]) = 'action-desc'">
			<tr>
				<td>
					<!--ul-->
					<xsl:choose>
						<xsl:when
							test="(translate($documentStage, $upper, $lower) = 'engrossed-in-senate' or translate($documentStage, $upper, $lower) = 'engrossed-amendment-senate') and (//bill/@public-print = 'yes' or //resolution/@public-print = 'yes')">
							<xsl:if test="not(following-sibling::action-desc[1]/@display = 'no')">
								<div class="lbexBold" style="text-align:center">
									<xsl:value-of select="following-sibling::action-desc[1]"/>
								</div>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="not(following-sibling::action-desc[1]/@display = 'no')">
								<div class="lbexHangTable"
									style="text-align:center;margin-left: 2em">
									<xsl:value-of select="following-sibling::action-desc[1]"/>
								</div>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
					<!--/ul-->
				</td>
			</tr>
		</xsl:if>
	</xsl:template>

	<xsl:template name="displayBill">
		<xsl:apply-templates select="pre-form"/>
		<xsl:apply-templates select="form"/>
		<xsl:apply-templates select="legis-body"/>
		<xsl:apply-templates select="official-title-amendment"/>
		<xsl:apply-templates select="attestation"/>
		<xsl:if test="not($billStage = 'Enrolled-Bill' or $billStage = 'Re-Enrolled-Bill')">
			<hr/>
		</xsl:if>
		<xsl:call-template name="printFootnotes"/>
		<xsl:if
			test="
				($billStage = 'Reported-in-House' or $billStage = 'Reported-in-Senate'
				or $billStage = 'Engrossed-in-Senate' or $billStage = 'Engrossed-in-House' or
				$billStage = 'Received-in-Senate' or $billStage = 'Received-in-House' or
				$billStage = 'Referred-in-Senate' or $billStage = 'Referred-in-House'
				or $billStage = 'Pre-Introduction' or $billStage = 'Placed-on-Calendar-Senate') and child::endorsement">

			<p/>
			<!--TB 5Sep2007 #692 added descendant-or-self to find out if the endorsement should be printed or not-->
			<xsl:call-template name="DisplayEndorsement">
				<xsl:with-param name="displayFlag" select="descendant-or-self::endorsement/@display"
				/>
			</xsl:call-template>

		</xsl:if>

	</xsl:template>

	<xsl:template match="bill">
		<xsl:call-template name="displayBill"/>
	</xsl:template>

	<!-- TB 4Jan2008 New Part of Amendment support taken from Senate proggramers -->
	<xsl:template match="amendment-doc">
		<xsl:if test="$isReport = 'yes' and not($confReportStyle = 'bill')">
			<xsl:call-template name="BuildReportHeader"/>
		</xsl:if>
		<xsl:apply-templates select="pre-form"/>
		<xsl:apply-templates select="amendment-form"/>
		<xsl:apply-templates select="engrossed-amendment-form"/>
		<xsl:apply-templates select="conference-report-form"/>
		<xsl:apply-templates select="amendment-body"/>
		<xsl:apply-templates select="engrossed-amendment-body"/>
		<xsl:apply-templates select="preamble-amends"/>
		<xsl:apply-templates select="title-amends"/>
		<xsl:apply-templates select="attestation"/>
		<xsl:call-template name="printFootnotes"/>
		<xsl:apply-templates select="endorsement"/>
	</xsl:template>

	<xsl:template match="engrossed-amendment-form">
		<xsl:apply-templates select="current-chamber"/>
		<xsl:apply-templates select="action/action-date"/>
		<xsl:call-template name="displayResolvedSections"/>
		<xsl:call-template name="printEngrossedAmendLegisType"/>
	</xsl:template>

	<xsl:template match="amendment-form">
		<xsl:apply-templates/>
		<!-- print this one for senate only -->
		<xsl:if
			test="(./congress[not(@display = 'no')] and ./session[not(@display = 'no')]) and $senateAmendment = 'yes'"
			> Viz: <br/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="conference-report-form">
		<xsl:apply-templates select="legis-num"/>
		<xsl:apply-templates select="report-title"/>
		<xsl:apply-templates select="current-chamber"/>
		<xsl:apply-templates select="action"/>
		<xsl:apply-templates select="legis-type"/>
	</xsl:template>

	<xsl:template match="committee-report">
		<xsl:if test="@front-matter-cover = 'yes'">
			<xsl:call-template name="PrintCoverPageTitlePage">
				<xsl:with-param name="isCoverTitle">cover</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<!--xsl:if test="@front-matter-spine='yes'">
			<xsl:call-template name="PrintSpine"/>				
		</xsl:if-->

		<xsl:if test="@front-matter-titlepage = 'yes'">
			<xsl:call-template name="PrintCoverPageTitlePage">
				<xsl:with-param name="isCoverTitle">title</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<!-- print front-matter-back-titlepage  -->
		<xsl:call-template name="printFrontMatterBackTitlepage"/>

		<xsl:if test="//committee-report/@front-matter-toc = 'yes'">
			<xsl:call-template name="printTocForCommitteeReportsFrontMatter"/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="committee-report-form/@display = 'no'">
				<!-- nothing -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="BuildReportHeader"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="pre-form/@display = 'no'">
				<!-- nothing -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="pre-form"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="committee-report-form/@display = 'no'">
				<!-- nothing -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="committee-report-form"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="committee-report-body"/>

		<!--TB Nov-2015 bug fixing #1408 -->
		<xsl:if test="not(//pre-form) and $isStandAloneVote = 'no'">
			<hr/>
		</xsl:if>

		<xsl:call-template name="printFootnotes"/>
	</xsl:template>

	<xsl:template name="PrintCoverPageTitlePage">
		<xsl:param name="isCoverTitle"/>
		<!-- TB January 2014 cleanup for the result html validation -->
		<xsl:if
			test="//committee-report-form/calendar and not(//committee-report-form/calendar/@display = 'no') and //committee-report-form/calendar != ''">
			<table style="width:80%;" align="center">
				<tr>
					<td style="text-align:right" class="lbexLegisNumSml">
						<xsl:value-of select="//committee-report-form/calendar"/>
					</td>
				</tr>
			</table>
		</xsl:if>
		<table class="lbexTableStyleFive" align="center">
			<tr>
				<td style="width:100%;text-align:center">
					<table class="lbexReportCoverTableTop">
						<tr>
							<td style="width:15%;text-align:center" class="lbexTocSubDivisionOLC">
								<xsl:value-of select="//congress"/>
								<br/>
								<xsl:value-of select="//committee-report-form/session"/>
							</td>
							<td style="width:2%" class="lbexLegisType">
								<xsl:text>}</xsl:text>
							</td>
							<td style="text-align:center" class="lbexSmallCapTrad">
								<xsl:value-of select="translate(//current-chamber, $lower, $upper)"
								/>
							</td>
							<td style="width:2%" class="lbexLegisType">
								<xsl:text>{</xsl:text>
							</td>
							<td style="width:15%;text-align:center" class="lbexTocSubDivisionOLC">
								<xsl:choose>
									<xsl:when
										test="//report-num/@part != '' and //report-num/@part != '0'">
										<xsl:text>Rept.</xsl:text>
										<xsl:value-of select="//report-num"/>
										<br/>
										<xsl:text>Part </xsl:text>
										<xsl:value-of select="//report-num/@part"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="//legis-type"/>
										<br/>
										<xsl:value-of select="//report-num"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</table>
				</td>

			</tr>
			<tr>
				<td>
					<xsl:variable name="allSpacesForTitlePage">
						<xsl:call-template name="GetSpacesForTitlePage"/>
					</xsl:variable>
					<xsl:variable name="theFirstSecondSpace"
						select="substring-before($allSpacesForTitlePage, '=')"/>
					<xsl:variable name="theThirdSpace"
						select="substring-before(substring-after($allSpacesForTitlePage, '='), '=')"/>
					<xsl:variable name="theFourthSpace"
						select="substring-after(substring-after($allSpacesForTitlePage, '='), '=')"/>


					<table align="center" class="lbexTableStyleTwo">

						<!-- tr for spacing -->
						<tr>
							<td>
								<xsl:attribute name="height">
									<xsl:value-of select="$theFirstSecondSpace"/>
								</xsl:attribute>
							</td>
						</tr>

						<tr>
							<td>
								<xsl:if
									test="//report-title and not(//report-title/@display = 'no')">
									<div style="text-align:center">
										<span class="lbexInitialCapUSC">
											<xsl:value-of
												select="translate(//report-title, $lower, $upper)"/>
										</span>
									</div>
								</xsl:if>
							</td>
						</tr>
						<!-- tr for spacing -->
						<tr>
							<td>
								<xsl:attribute name="height">
									<xsl:value-of select="$theFirstSecondSpace"/>
								</xsl:attribute>

							</td>
						</tr>
						<xsl:if test="//report-title and not(//report-title/@display = 'no')">
							<tr>
								<td>
									<hr style="width:85px"/>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="not(//report-title) or //report-title/@display = 'no'">
							<tr>
								<td style="height:10"/>
							</tr>
						</xsl:if>
						<tr>
							<td style="height:34;text-align:center;" class="lbexLargeCapTrad">
								<xsl:call-template name="insertSpaces">
									<xsl:with-param name="origString"
										select="translate(//legis-type, $lower, $upper)"/>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td style="text-align:center" class="lbexTocSubPartOLC">
								<xsl:text>of the</xsl:text>
							</td>
						</tr>
						<tr>
							<td style="height:6"/>
						</tr>
						<tr>
							<td style="text-align:center">
								<xsl:value-of
									select="normalize-space(translate(//committee-name, $lower, $upper))"
								/>
							</td>
						</tr>
						<xsl:if test="//current-chamber and not(//current-chamber/@display = 'no')">
							<tr>
								<td style="text-align:center">
									<xsl:value-of
										select="normalize-space(translate(//current-chamber, $lower, $upper))"
									/>
								</td>
							</tr>
						</xsl:if>
						<tr>
							<td style="height:12"/>
						</tr>

						<xsl:if test="//legis-num and not(//legis-num/@display = 'no')">
							<tr>
								<td style="height:12"/>
							</tr>
							<tr>
								<td style="text-align:center" class="lbexTocSubPartOLC">
									<xsl:text disable-output-escaping="yes">on</xsl:text>
								</td>
							</tr>

							<tr>
								<td style="height:8"/>
							</tr>
							<tr>
								<td style="text-align:center">
									<xsl:value-of select="//legis-num"/>
								</td>
							</tr>
						</xsl:if>

						<xsl:if
							test="//committee-report-views/@display != 'no' and //committee-report-views">
							<tr>
								<td style="height:6"/>
							</tr>
							<tr>
								<td style="text-align:center" class="lbexTocSubChapterOLC">
									<xsl:text disable-output-escaping="yes">together with</xsl:text>
								</td>
							</tr>
							<tr>
								<td style="height:12"/>
							</tr>
							<tr>
								<td style="text-align:center">
									<xsl:value-of
										select="translate(//committee-report-views, $lower, $upper)"
									/>
								</td>
							</tr>
						</xsl:if>
						<xsl:if
							test="//cbo-cost-estimate-line and not(cbo-cost-estimate-line/@display = 'no')">
							<tr>
								<td style="height:6"/>
							</tr>
							<xsl:if test="not(//cbo-cost-estimate-line/@display = 'no')">
								<tr>
									<td style="text-align:center" class="lbexTocDivisionOLC">
										<xsl:value-of select="//cbo-cost-estimate-line"/>
									</td>
								</tr>
							</xsl:if>
						</xsl:if>
						<tr>
							<td>
								<xsl:attribute name="height">
									<xsl:value-of select="$theThirdSpace"/>
								</xsl:attribute>

							</td>
						</tr>
						<tr>
							<td style="text-align:center">
								<img alt="Embedded Image"
									src="data:image/png;base64,R0lGODlhYgBYAHAAACH5BAEAAAYALAAAAABiAFgAgv///zMzM8zMzAAAAGZmZpmZmQAAAAAAAAP/CLrc/jDKSau9OOvNu/9gKI5kaZ5KgK6UmgkDwc5OMGjEMBR0n98ZQiHH660IhIAsMwQQjSckrIgRuHJLaMg6ECQ5AYFgqBNoP8kkTK2xOgsFHfVcDYS7NvkLLhP+5nQUVgRWdgFwQBg6ekpxMYEVjj87Cl04XWleOjZhH16NIT9JjwpIHKYAXjkqhRxiTmJwSh5YKTw8bq6zZgU2S2wYvXaEhwq9gBZ2ZgBxVgWFQro8v6S9yxZNzEJ2RXGEF0pjPIZiWJQ4Y5bf3sadFkmgVp9kiRNrg05lMCq9G96cpW4NOPSsWIUpehjAuyZhirN8A5PgcrFhVyaJ0A4ZvBCt/8HGhjswDtv37I2HWam8yCJmSGIGiqkAoARpZ0ecIodUwgGhbMiYPIuCnjuIyVivLBBgbNJBqGnET2MYblDjTBOhMZOGTkCyU+awCQRTUXK6Q9NAG8gsfBp4a1REYtu0QmiWJY9Uj1SOhcmjJJwZYBrKYo02ySm1uw3KfuMll4E3M0qfRbyp4K+7ikt2jhqyMscyOxKkhOvHDoKvaZyyHGuiDI2lo7WGcOv6xLTKN3h0RPhTOYxmPfdCPGbmKMaoa5LmZkkzcFFasbq55MyDxJeItUyrP+NzjrptGRqLJ3xAREzNrlPIfHONq7I3zotS5Xk+kFlNofUdRNWdwjhchf+kdFBIW4ZskkZlcrjEAAzMbEJPUA7Ak49kMTzzgyG45IcGWhbaUM5AkOl2yCo+waPHb851yNYN+5TixyLijLIeCMJwhiEiYbQoxHZKnFUSZz6lgsRZUvBwAzvq8QOUhsLlN0RWMDoik0xBLrASHFg2ghwfAHRxExecHfchUuxBJk4MYnQXww1cYYnljm4CGacfXQqzDBGpCfFXY65kdZ42scVHZEuEDlNoX18tokJhToy2FmIeHKUJQZP8pBtXfoSpaaacPqnCJsuUhSUmvfDpiU1kgWjQDzIh4eqrsMYKKzdyHHUWU191SWYoqOakBlPPKOXMm3HyUaycT8bRCbD/XOhJz640FvjhmTmkREyx4sSZrZsxyrZAgWilU9YMG93KRUzGygnnusSm64cKNQmRnQxrzOCNjPuIi2p1scLmr3av3lDrDgQ3M4ZYz43Axyzb3DSMNX7EUpKeTkSDlZB87IOhgVTuyCQLr8UQLl+D6LkjleM0IQug8FWKRxMiSzFDiM01NWJZe1EVpMxcCUnviErtAJQs5kGLQhzaHJNqOjuavFNYSsiwsqfF8bGNUhLSkAZrXaZylLIAFQnHXxNb3IROElXYpRdrcNaDxrKVSsTCZACpE8odE8fPry+aMbLRR4w94gIsAr2XTLF8w7PFpqj0h7JerZkwClyUQUpz/2iGg0k5Tz9tysry0CqbIfZBCnKKXahSsi9SEDL2G3+ZTW/dpTeI1CdQtKyelfXR6njnKUvdDyFBkUnFZlA8xI0NjlkZBng7K864FE7OhApEppsQNFpRk5mLT1B7LjwxaotVioaka3Gzc/wtsE55ipeNy7sKIm6VizFpIc8Ud1zWtSplYE3npCavRbiOSo3qA0zOUBVMUAxBrVJUjN5noco9oiSdKEY/BlGPHvCFL11pUIOC4puwvOpeBgpVmhpEs8lFYUTyul4lLIgz8/DCY5mJj/ms0Yk0+M8IPbuQRwoIIvmk7HlDMUvsGlUhNB0sECSyjkIOoajKSGgcM0mBL/jk0aVN/BCKI7LLK6DjnICkhjpkWpIv2AIJ/UikVIp6EJpSUB1wfcwrNeleG5Mii5AIRUtWjBrBDAipNHhmjxN4CxsdgIghOcI7EWJKgBAJgVVI0Y3GEZhbshALzBWRkhGgYVqYVi1F7UIWe0ELKA/iqV19gop1chCnGgWD7K1yQT1a4CeGJBMvuipGYbwlOJo4B04gjYq1GluyWiPMCmhnDu+5QR5zJDFiNdMTtIpgtbzGGay48Jot4CUyMyMzn9gSnBRoThc/qY3YAQ6d7/DQkIzmNnjSQmhIa4g9PTAID+1zBjL7p0AHStCCGvSgCE2oQhfK0DYmAAA7"/>

							</td>
						</tr>

						<tr>
							<td>
								<xsl:attribute name="height">
									<xsl:value-of select="$theFourthSpace"/>
								</xsl:attribute>

							</td>
						</tr>

						<xsl:variable name="lastActionDate">
							<xsl:call-template name="getLastActionDate"/>
						</xsl:variable>
						<tr>
							<td style="text-align:center" class="lbexTocDivisionOLC">
								<xsl:call-template name="printActionDateForCommitteeReport">
									<xsl:with-param name="aActionDateText">
										<xsl:value-of
											select="substring-before($lastActionDate, '=')"/>
									</xsl:with-param>
								</xsl:call-template>
								<xsl:text>.— </xsl:text>
								<xsl:value-of select="substring-after($lastActionDate, '=')"/>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:attribute name="height">
									<xsl:value-of select="24"/>
								</xsl:attribute>
								<xsl:if test="$isCoverTitle = 'title'">
									<div style="text-align:center" class="lbexSimplecap">
										<hr style="width:20%"/>
										<div> u.s. government publishing office </div>
										<div> washington : 2009 </div>
									</div>
								</xsl:if>


							</td>
						</tr>
					</table>
				</td>
			</tr>

		</table>
		<br/>
		<p class="lbexBreakHere"/>

	</xsl:template>


	<xsl:template match="front-matter-back-titlepage">
		<!-- skip -->
	</xsl:template>
	<!-- *************Print Action Date for Committee Reports******************* -->
	<xsl:template name="printActionDateForCommitteeReport">
		<xsl:param name="aActionDateText"/>
		<xsl:variable name="theActionDateTrim">
			<xsl:value-of select="normalize-space($aActionDateText)"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="contains($theActionDateTrim, ' ')">
				<!--Take first letter of the string-->
				<xsl:variable name="tempFirstPartString">
					<xsl:value-of
						select="translate(substring-before($theActionDateTrim, ' '), $upper, $lower)"
					/>
				</xsl:variable>
				<!--xsl:variable name="firstPasrtString"-->
				<xsl:choose>
					<xsl:when
						test="$tempFirstPartString = 'january' or $tempFirstPartString = 'february' or $tempFirstPartString = 'march' or $tempFirstPartString = 'april' or $tempFirstPartString = 'may' or $tempFirstPartString = 'june' or $tempFirstPartString = 'july' or $tempFirstPartString = 'august' or $tempFirstPartString = 'september' or $tempFirstPartString = 'october' or $tempFirstPartString = 'november' or $tempFirstPartString = 'december'">
						<xsl:variable name="theMonth">
							<xsl:value-of
								select="concat(substring-before($theActionDateTrim, ' '), ' ')"/>
						</xsl:variable>
						<span class="lbexSectionLevelOLCnuclear">
							<xsl:value-of select="$theMonth"/>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of
							select="concat(substring-before($theActionDateTrim, ' '), ' ')"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:call-template name="printActionDateForCommitteeReport">
					<xsl:with-param name="aActionDateText"
						select="substring-after($theActionDateTrim, ' ')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$theActionDateTrim"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ***********calculate space for the title / cover page *********************-->
	<xsl:template name="GetSpacesForTitlePage">
		<xsl:variable name="theTitleLines">
			<xsl:choose>
				<xsl:when test="not(//report-title) or //report-title/@display = 'no'">
					<xsl:text>0</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="roundToNumberOfLines">
						<xsl:with-param name="numberOfLines"
							select="string-length(normalize-space(//report-title)) div 35"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="theCommitteeNameLines">
			<xsl:choose>
				<xsl:when test="not(//committee-name) or //committee-name/@display = 'no'">
					<xsl:text>0</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="roundToNumberOfLines">
						<xsl:with-param name="numberOfLines"
							select="string-length(normalize-space(//committee-name)) div 35"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="theCommitteeViewsLines">
			<xsl:choose>
				<xsl:when
					test="not(//committee-report-views) or //committee-report-views/@display = 'no'">
					<xsl:text>0</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="roundToNumberOfLines">
						<xsl:with-param name="numberOfLines"
							select="string-length(normalize-space(//committee-report-views)) div 39"
						/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="lastActionDateAndDesc">
			<xsl:call-template name="getLastActionDate"/>
		</xsl:variable>
		<xsl:variable name="theLastActionDateLines">
			<xsl:choose>
				<xsl:when test="string-length($lastActionDateAndDesc) &lt; 2">
					<xsl:text>0</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="roundToNumberOfLines">
						<xsl:with-param name="numberOfLines"
							select="string-length($lastActionDateAndDesc) div 64"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="theCboCostLines">
			<xsl:choose>
				<xsl:when
					test="not(//cbo-cost-estimate-line) or //cbo-cost-estimate-line/@display = 'no'">
					<xsl:text>0</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="roundToNumberOfLines">
						<xsl:with-param name="numberOfLines"
							select="string-length(normalize-space(//cbo-cost-estimate-line)) div 64"
						/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="totalVariableTextVerticalPoints"
			select="14 * $theTitleLines + 14 * $theCommitteeNameLines + 14 * $theCommitteeViewsLines + 12 * $theLastActionDateLines + 12 * $theCboCostLines"/>

		<xsl:variable name="adjustment1">
			<xsl:text>0</xsl:text>
		</xsl:variable>

		<xsl:variable name="adjustment2">
			<xsl:choose>
				<xsl:when test="not(//legis-num/text()) or //legis-num/@display = 'no'">
					<xsl:text>40</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="adjustment3">
			<xsl:choose>
				<xsl:when
					test="(not(//committee-report-views) or //committee-report-views/@display = 'no') and (not(//legis-num) or //legis-num/@display = 'no')">
					<xsl:text>26</xsl:text>
				</xsl:when>
				<xsl:when
					test="not(//committee-report-views) or //committee-report-views/@display = 'no'">
					<xsl:text>15</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="adjustment4">
			<xsl:choose>
				<xsl:when test="not(//current-chamber) or //current-chamber/@display = 'no'">
					<xsl:text>14</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="totalAdjustment">
			<xsl:value-of select="$adjustment1 + $adjustment2 + $adjustment3 + $adjustment4"/>
		</xsl:variable>

		<xsl:variable name="theTotlaSpaces">
			<xsl:value-of select="248 + $totalAdjustment - $totalVariableTextVerticalPoints"/>
		</xsl:variable>

		<xsl:variable name="firstAndSecondSpace">
			<xsl:choose>
				<xsl:when test="$theTotlaSpaces &gt; 108">
					<xsl:text>36</xsl:text>
				</xsl:when>
				<xsl:when test="$theTotlaSpaces &gt; 56">
					<xsl:value-of select="format-number((($theTotlaSpaces - 36) div 2), '##')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(($theTotlaSpaces div 4), '##')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="thirdSpace">
			<xsl:choose>
				<xsl:when test="$theTotlaSpaces &gt; 108">
					<xsl:value-of select="format-number(((($theTotlaSpaces - 72) div 2) - 3), '##')"
					/>
				</xsl:when>
				<xsl:when test="$theTotlaSpaces &gt; 56">
					<xsl:text>15</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number((($theTotlaSpaces div 4) - 3), '##')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="fourthSpace">
			<xsl:choose>
				<xsl:when test="$theTotlaSpaces &gt; 108">
					<xsl:value-of select="format-number((($theTotlaSpaces - 72) div 2) + 3, '##')"/>
				</xsl:when>
				<xsl:when test="$theTotlaSpaces &gt; 56">
					<xsl:text>21</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(($theTotlaSpaces div 4) + 3, '##')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="$firstAndSecondSpace"/>
		<xsl:text>=</xsl:text>
		<xsl:value-of select="$thirdSpace"/>
		<xsl:text>=</xsl:text>
		<xsl:value-of select="$fourthSpace"/>
	</xsl:template>

	<xsl:template name="getLastActionDate">
		<xsl:for-each select="//action-date">
			<xsl:if test="position() = count(//action-date)">
				<xsl:value-of select="."/>
				<xsl:text>=</xsl:text>
				<xsl:value-of select="parent::action/action-desc"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="roundToNumberOfLines">
		<xsl:param name="numberOfLines"/>
		<!--xsl:text>2</xsl:text-->
		<xsl:choose>
			<xsl:when test="(format-number($numberOfLines, '##') >= $numberOfLines)">
				<xsl:value-of select="number(format-number($numberOfLines, '##'))"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-number($numberOfLines + 1, '##')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="printTocForCommitteeReportsFrontMatter">
		<xsl:if test="//toc/header">
			<div style="text-align:center" class="lbexLargeCapTrad">
				<xsl:value-of select="translate(//toc/header, $lower, $upper)"/>
				<br/>
				<hr style="width:85px"/>
				<br/>
			</div>
		</xsl:if>

		<table align="center">
			<xsl:if test="//toc/multi-column-toc-entry">
				<!-- build first row -->
				<tr>
					<xsl:if test="//toc/multi-column-toc-entry/toc-enum">
						<td class="lbexTdStyleTwo"> </td>
						<td class="lbexTdStyleOne"> </td>
					</xsl:if>
					<td style="text-align:left"> </td>
					<td style="text-align:right;width:7%" class="lbexTocSubChapterOLC"> Page </td>
				</tr>
			</xsl:if>
			<xsl:for-each select="//toc/multi-column-toc-entry">
				<tr>
					<xsl:if test="toc-enum">
						<td style="text-align:right;" class="lbexTocSubChapterOLC">
							<xsl:value-of select="toc-enum"/>
						</td>
						<td class="lbexTdStyleOne"> </td>
					</xsl:if>
					<xsl:variable name="spacesToIndent">
						<xsl:choose>
							<xsl:when test="not(toc-enum)">
								<xsl:call-template name="geToctIndentNumber">
									<xsl:with-param name="aLevel" select="level-header/@level"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>0</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<td class="lbexTocSubChapterOLC">
						<xsl:variable name="tocLengthForCalc">
							<xsl:call-template name="calcLengthForLeader">
								<xsl:with-param name="currStringLength"
									select="number($spacesToIndent) + string-length(normalize-space(level-header))"/>
								<xsl:with-param name="isFirstLine">true</xsl:with-param>
								<xsl:with-param name="lenghtToMatch">200</xsl:with-param>
							</xsl:call-template>
						</xsl:variable>
						<table>
							<tr>
								<td>
									<xsl:attribute name="width">
										<xsl:value-of select="$spacesToIndent"/>
										<xsl:text>%</xsl:text>
									</xsl:attribute>
								</td>

								<td class="lbexTocSubChapterOLC">
									<xsl:attribute name="width">
										<xsl:value-of select="100 - number($spacesToIndent)"/>
										<xsl:text>%</xsl:text>
									</xsl:attribute>
									<xsl:value-of select="level-header"/>
									<xsl:call-template name="loop">
										<xsl:with-param name="index"
											select="number($tocLengthForCalc)"/>
									</xsl:call-template>
								</td>
							</tr>
						</table>
					</td>
					<td style="text-align:right" class="lbexTocSubChapterOLC">
						<xsl:value-of select="page-num"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<br/>
		<p class="lbexBreakHere"/>
	</xsl:template>



	<xsl:template name="printTocForCommitteeReports">
		<xsl:if test="header">
			<div style="text-align:center" class="lbexLargeCapTrad">
				<xsl:value-of select="translate(header, $lower, $upper)"/>
				<br/>
				<hr style="width:85px"/>
				<br/>
			</div>
		</xsl:if>

		<table align="center">
			<xsl:if test="multi-column-toc-entry">
				<!-- build first row -->
				<tr>
					<xsl:if test="multi-column-toc-entry/toc-enum">
						<td class="lbexTdStyleTwo"> </td>
						<td class="lbexTdStyleOne"> </td>
					</xsl:if>
					<td style="text-align:left"> </td>
					<td style="text-align:right;width:7%;" class="lbexTocSubChapterOLC"> Page </td>
				</tr>
			</xsl:if>
			<xsl:for-each select="multi-column-toc-entry">
				<tr>
					<xsl:if test="toc-enum">
						<td style="text-align:right;" class="lbexTocSubChapterOLC">
							<xsl:value-of select="toc-enum"/>
						</td>
						<td class="lbexTdStyleOne"> </td>
					</xsl:if>
					<xsl:variable name="spacesToIndent">
						<xsl:choose>
							<xsl:when test="not(toc-enum)">
								<xsl:call-template name="geToctIndentNumber">
									<xsl:with-param name="aLevel" select="level-header/@level"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>0</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<td style="text-align:left;" class="lbexTocSubChapterOLC">
						<xsl:variable name="tocLengthForCalc">
							<xsl:call-template name="calcLengthForLeader">
								<xsl:with-param name="currStringLength"
									select="number($spacesToIndent) + string-length(normalize-space(level-header))"/>
								<xsl:with-param name="isFirstLine">true</xsl:with-param>
								<xsl:with-param name="lenghtToMatch">200</xsl:with-param>
							</xsl:call-template>
						</xsl:variable>
						<span>
							<xsl:attribute name="margin-left">
								<xsl:value-of select="$spacesToIndent"/>
								<xsl:text>em</xsl:text>
							</xsl:attribute>
							<xsl:value-of select="level-header"/>
						</span>
						<xsl:call-template name="loop">
							<xsl:with-param name="index" select="number($tocLengthForCalc)"/>
						</xsl:call-template>

					</td>
					<td style="text-align:right;" class="lbexTocSubChapterOLC">
						<xsl:value-of select="page-num"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<br/>
		<p class="lbexBreakHere"/>
	</xsl:template>

	<xsl:template name="geToctIndentNumber">
		<xsl:param name="aLevel"/>

		<xsl:choose>
			<xsl:when test="$aLevel = 'paragraph'">
				<xsl:text>2</xsl:text>
			</xsl:when>
			<xsl:when test="$aLevel = 'subparagraph'">
				<xsl:text>4</xsl:text>
			</xsl:when>
			<xsl:when test="$aLevel = 'clause'">
				<xsl:text>6</xsl:text>
			</xsl:when>
			<xsl:when test="$aLevel = 'subclause'">
				<xsl:text>8</xsl:text>
			</xsl:when>
			<xsl:when test="$aLevel = 'item'">
				<xsl:text>10</xsl:text>
			</xsl:when>
			<xsl:when test="$aLevel = 'subitem'">
				<xsl:text>12</xsl:text>
			</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="amendment-body">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="amendment">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="amendment-block">
		<!-- TB May2011 bug fixing #1205 -->
		<xsl:choose>
			<xsl:when test="@margin-indent = 'yes' and not(ancestor::legis-body)">
				<table style="width:80%;" align="center" class="lbexSectionLevelTradBold">
					<tr>
						<td class="lbexIndent">
							<xsl:apply-templates/>
						</td>
					</tr>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
		<!--xsl:apply-templates/-->
	</xsl:template>

	<xsl:template match="amendment-instruction">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="preamble-amends">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="title-amends">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="amendment-form/amend-num">
		<xsl:choose>
			<xsl:when test="$senateStyle1 = 'yes'">
				<xsl:call-template name="PrintAmendNumberForSenate"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="amendment-form/calendar">
		<!-- TB 7Jan2008 calenndar will be printed with Amend number for Senate Amentment -->
		<xsl:if test="not($senateStyle1 = 'yes')">
			<xsl:apply-templates/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="amendment-form/purpose">
		<xsl:if test="$senateStyle1 = 'yes' and not(@display = 'no')">
			<p>Purpose: <xsl:apply-templates/>
			</p>
		</xsl:if>
	</xsl:template>
	<xsl:template match="conference-report-form/purpose">
		<xsl:if test="@display = 'yes' or not(@display)">
			<p>Purpose: <xsl:apply-templates/>
			</p>
		</xsl:if>
	</xsl:template>
	<xsl:template match="amendment-form/congress">
		<xsl:param name="source"/>
		<xsl:if
			test="(not($senateStyle1 = 'yes') or $source = 'Endorsement') and not(@display = 'no')">
			<xsl:apply-templates/>
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:template>
	<xsl:template match="amendment-form/session">
		<xsl:param name="source"/>
		<xsl:if
			test="(not($senateStyle1 = 'yes') or $source = 'Endorsement') and not(@display = 'no')">
			<xsl:apply-templates/>
			<br/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="amendment-form/current-chamber">
		<!-- TB 8Jan2008 Amendment Support -->
		<xsl:choose>
			<xsl:when test="$senateStyle1 = 'yes'">
				<p style="text-align:center" class="lbexMediumcap">
					<xsl:if test="not(@display = 'no')">
						<xsl:apply-templates/>
					</xsl:if>
					<!-- Print Congress and session here inline -->
					<xsl:call-template name="printCongressAndSessionForSenateAmend"/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p style="text-align:center;">
					<xsl:apply-templates/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="engrossed-amendment-form/current-chamber">

		<p style="text-align:center;" class="lbexChamberEngrHouse">
			<!-- TB Sep2001 MultBrowsers italic tag inserted -->
			<i>
				<xsl:apply-templates/>
			</i>
		</p>
	</xsl:template>
	<xsl:template match="amendment-form/legis-num">
		<div style="text-align:center">
			<xsl:choose>
				<xsl:when
					test="$senateStyle1 = 'yes' and contains(translate(., $upper, $lower), 'no')">
					<p class="lbexSectionLevelTradBold">
						<xsl:apply-templates/>
					</p>
				</xsl:when>
				<xsl:otherwise>
					<p class="lbexInitialcap">
						<xsl:apply-templates/>
					</p>
					<xsl:if test="$senateStyle1 = 'yes'">
						<span style="height:40px"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>


		</div>
	</xsl:template>
	<xsl:template match="amendment-form/official-title">
		<div style="text-align:center">
			<xsl:choose>
				<xsl:when test="@display = 'no'"/>
				<xsl:when
					test="$senateStyle1 = 'yes' and contains(translate(., $upper, $lower), 'title')">
					<p class="lbexSectionLevelTradBold">
						<xsl:apply-templates/>
					</p>
					<span style="height:60px"/>
				</xsl:when>
				<xsl:otherwise>
					<p>
						<xsl:apply-templates/>
					</p>
					<xsl:if test="$senateStyle1 = 'yes'">
						<span style="height:40px"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>
	<xsl:template match="amendment-form/action">
		<div style="text-align:center">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="conference-report-form/amend-num">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="conference-report-form/calendar">
		<p style="text-align:right">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="conference-report-form/congress"/>
	<xsl:template match="conference-report-form/session"/>
	<xsl:template match="conference-report-form/report-num"/>
	<xsl:template match="conference-report-form/current-chamber"/>

	<xsl:template match="committee-report-form/congress"/>
	<xsl:template match="committee-report-form/session"/>
	<xsl:template match="committee-report-form/report-num"/>
	<xsl:template match="committee-report-form/current-chamber"/>


	<xsl:template match="conference-report-form/legis-num">
		<xsl:if test="$confReportStyle = 'bill'">
			<xsl:call-template name="printLegisNumForBillReports"/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="committee-report-form/legis-num">
		<xsl:if test="not(//committee-report-views) or (//committee-report-views/@display = 'no')">
			<xsl:call-template name="printToAccompanyText"/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="conference-report-form/official-title">
		<p>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="conference-report-form/report-title">
		<div style="text-align:center" class="lbexInitialCapUSC">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="committee-report-form/report-title">
		<xsl:variable name="theRepTitleText">
			<xsl:apply-templates/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="@display = 'no'"/>
			<xsl:when test="text() != ''">
				<div style="text-align:center" class="lbexInitialCapUSC">
					<!--xsl:apply-templates/-->
					<xsl:value-of select="translate($theRepTitleText, $lower, $upper)"/>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div style="text-align:center" class="lbexRepTitle">
					<xsl:text>(title)_________________________________________</xsl:text>
					<br/>
					<xsl:text>_______________________________________________</xsl:text>
				</div>
			</xsl:otherwise>
		</xsl:choose>


	</xsl:template>
	<xsl:template match="conference-report-form/action">
		<div style="text-align:center">
			<xsl:if test="action-instruction/text() != ''">
				<br/>
				<hr style="width:100px"/>
				<br/>
			</xsl:if>
			<xsl:apply-templates select="action-instruction"/>
			<xsl:if
				test="action-desc/text() != '' and not(contains(translate(action-desc, $upper, $lower), '[to accompany'))">
				<br/>
				<hr style="width:100px"/>
				<br/>
				<xsl:apply-templates select="action-desc"/>
			</xsl:if>
		</div>
	</xsl:template>

	<xsl:template match="committee-report-form/action">
		<div style="text-align:center">
			<xsl:if
				test="(action-desc/@display != 'no' or not(action-desc/@display)) and not(contains(translate(action-desc, $upper, $lower), '[to accompany'))">
				<br/>
				<hr style="width:100px"/>
				<br/>
			</xsl:if>
			<xsl:apply-templates select="action-desc"/>
			<xsl:if test="action-instruction/text() != ''">
				<xsl:if
					test="preceding-sibling::action[1]/action-date/text() or preceding-sibling::action[1]/action-desc/text()">
					<br/>
					<hr style="width:100px"/>
					<br/>
				</xsl:if>
			</xsl:if>
			<xsl:apply-templates select="action-instruction"/>

		</div>
	</xsl:template>

	<!-- **************************Committee report views **************************-->
	<xsl:template match="committee-report-form/committee-report-views">
		<xsl:choose>
			<xsl:when test="@display = 'no'">
				<!-- nothing -->
			</xsl:when>
			<xsl:otherwise>
				<div>
					<xsl:attribute name="style">
						<xsl:text>font-size: 75%;text-align:center</xsl:text>
					</xsl:attribute>
					<xsl:text disable-output-escaping="yes">together with</xsl:text>
					<br/>
					<p/>
					<xsl:value-of select="translate(., $lower, $upper)"/>
					<p/>
				</div>
				<xsl:call-template name="printToAccompanyText"/>
			</xsl:otherwise>

		</xsl:choose>


	</xsl:template>



	<!-- **************************cbo cost estimate line **************************-->
	<xsl:template match="committee-report-form/cbo-cost-estimate-line">
		<xsl:choose>
			<xsl:when test="@display = 'no'">
				<!-- nothing -->
			</xsl:when>
			<xsl:otherwise>
				<p/>
				<div>
					<xsl:attribute name="style">
						<xsl:text>font-size: 75%;text-align:center</xsl:text>
					</xsl:attribute>
					<xsl:value-of select="."/>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="meta-senate">
		<xsl:if test="//pre-form//slc-for">
			<xsl:text disable-output-escaping="yes">
				FOR: </xsl:text>
			<xsl:if test="//pre-form//slc-for-office">
				<xsl:value-of select="//pre-form//slc-for-office"/>
			</xsl:if>
			<xsl:if test="//pre-form//slc-for-sponsor">
				<xsl:text disable-output-escaping="yes">/</xsl:text>
				<xsl:value-of select="//pre-form//slc-for-sponsor"/>
			</xsl:if>
			<xsl:if test="//pre-form//slc-for-staffer">
				<xsl:text disable-output-escaping="yes">/</xsl:text>
				<xsl:value-of select="//pre-form//slc-for-staffer"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="not(//pre-form//slc-for)">
			<xsl:text disable-output-escaping="yes">
				FOR: </xsl:text>
		</xsl:if>
		<xsl:if test="//pre-form//slc-subject">
			<xsl:if test="//pre-form//slc-subject-field1">
				<br/>
				<br/>
				<xsl:text disable-output-escaping="yes">
					SUB: </xsl:text>
				<xsl:value-of select="//pre-form//slc-subject-field1"/>
			</xsl:if>
			<xsl:if test="//pre-form//slc-subject-field2">
				<xsl:text disable-output-escaping="yes">/</xsl:text>
				<xsl:value-of select="//pre-form//slc-subject-field2"/>
			</xsl:if>
			<xsl:if test=".//slc-subject-field3">
				<xsl:text disable-output-escaping="yes">/</xsl:text>
				<xsl:value-of select="//pre-form//slc-subject-field3"/>
			</xsl:if>
			<xsl:if test="//pre-form//slc-subject-field4">
				<xsl:text disable-output-escaping="yes">/</xsl:text>
				<xsl:value-of select="//pre-form//slc-subject-field4"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="not(//pre-form//slc-subject)">
			<br/>
			<br/>
			<xsl:text disable-output-escaping="yes">
				SUB: </xsl:text>
		</xsl:if>
		<xsl:if test="//pre-form//slc-type">
			<br/>
			<br/>
			<xsl:text disable-output-escaping="yes">
				TYP: </xsl:text>
			<xsl:value-of select="//pre-form//slc-type"/>
		</xsl:if>
		<xsl:if test="not(//pre-form//slc-type)">
			<br/>
			<br/>

			<xsl:text disable-output-escaping="yes">
				TYP: 
			</xsl:text>
		</xsl:if>
		<xsl:if test="//pre-form//slc-description">
			<br/>
			<br/>
			<xsl:text disable-output-escaping="yes">
				DES: </xsl:text>
			<xsl:apply-templates select="//slc-description"/>
		</xsl:if>
		<xsl:if test="not(//pre-form//slc-description)">
			<br/>
			<br/>
			<xsl:text disable-output-escaping="yes">
				DES: </xsl:text>
		</xsl:if>
		<xsl:if test="//pre-form//slc-received">
			<br/>
			<br/>
			<xsl:text disable-output-escaping="yes">
				REC: </xsl:text>
			<xsl:value-of select="//pre-form//slc-received"/>
		</xsl:if>
		<xsl:if test="not(//pre-form//slc-received)">
			<br/>
			<br/>
			<xsl:text disable-output-escaping="yes">
				REC: </xsl:text>

		</xsl:if>
		<xsl:if test="//pre-form//slc-delivered">
			<br/>
			<br/>
			<xsl:text disable-output-escaping="yes">
				DLV: </xsl:text>
			<xsl:value-of select="//pre-form//slc-delivered"/>
		</xsl:if>
		<xsl:if test="not(//pre-form//slc-delivered)">
			<br/>
			<br/>
			<xsl:text disable-output-escaping="yes">
				DLV: </xsl:text>
		</xsl:if>
		<xsl:if test="//pre-form//slc-staff">
			<br/>
			<br/>
			<xsl:text disable-output-escaping="yes">
				STF: </xsl:text>
			<xsl:value-of select="//pre-form//slc-staff"/>
		</xsl:if>
		<xsl:if test="not(.//slc-staff)">
			<br/>
			<br/>
			<xsl:text disable-output-escaping="yes">
				STF: </xsl:text>
		</xsl:if>
		<xsl:if test="//pre-form//slc-peer-reviewed-by">
			<br/>
			<br/>
			<xsl:text disable-output-escaping="yes">
				PRBY: </xsl:text>
			<xsl:value-of select="//pre-form//slc-peer-reviewed-by"/>
			<br/>
			<br/>
		</xsl:if>
		<xsl:if test="not(//pre-form//slc-peer-reviewed-by)">
			<br/>
			<br/>
			<xsl:text disable-output-escaping="yes">
				PRBY: </xsl:text>
			<br/>
			<br/>
		</xsl:if>

		<!-- TB 7Jan2008 pagebreak after pre-form/meta-senate -->
		<p class="lbexBreakHere"/>
	</xsl:template>

	<!-- End of TB 4Jan2008 -->
	<xsl:template match="resolution">
		<xsl:apply-templates select="form"/>
		<xsl:apply-templates select="preamble"/>
		<xsl:apply-templates select="resolution-body"/>
		<xsl:apply-templates select="official-title-amendment"/>
		<xsl:apply-templates select="attestation"/>
		<!-- TB 29-Aug-2007 Bug#664 remove the end of file mark line in case of Enrolled-Bill resolution -->
		<xsl:if
			test="
				not($resolutionStage = 'Enrolled-in-Senate' or $resolutionStage = 'EnrolledHouse' or
				$resolutionStage = 'Re-enrolled-in-Senate' or $resolutionStage = 'Enrolled-Bill')">
			<hr/>
		</xsl:if>
		<xsl:call-template name="printFootnotes"/>
		<xsl:if
			test="
				($resolutionStage = 'Reported-in-Senate' or $resolutionStage = 'Engrossed-in-Senate'
				or $resolutionStage = 'Engrossed-in-Senate' or $resolutionStage = 'Pre-Introduction' or
				$resolutionStage = 'Reported-House' or $resolutionStage = 'Reported-in-House' or
				($resolutionStage = 'Engrossed-House' and $resolutionType = 'house-joint') or
				($resolutionStage = 'Engrossed-House' and $resolutionType = 'senate-concurrent') or
				($resolutionStage = 'Engrossed-House' and $resolutionType = 'house-concurrent') or
				($resolutionStage = 'Engrossed-in-House' and $resolutionType = 'house-joint') or
				($resolutionStage = 'Engrossed-in-House' and $resolutionType = 'senate-concurrent') or
				($resolutionStage = 'Placed-on-Calendar-Senate' and $resolutionType = 'house-concurrent') or
				($resolutionStage = 'Engrossed-in-House' and $resolutionType = 'house-concurrent')) and child::endorsement">

			<p/>
			<xsl:call-template name="DisplayEndorsement">
				<xsl:with-param name="displayFlag" select="endorsement/@display"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template match="form">
		<xsl:variable name="toDisplayOpeningRuller">
			<xsl:call-template name="toPrintAnOpeningRuler"/>
		</xsl:variable>

		<xsl:if test="not(@display = 'no')">
			<xsl:choose>
				<!--TB 30Aug2007 #673 to print calendar for Reported-In-House and Placed-on-Calendar-Senate resolutions -->
				<xsl:when
					test="(translate($documentStage, $upper, $lower) = 'engrossed-in-senate' or translate($documentStage, $upper, $lower) = 'engrossed-amendment-senate') and (//bill/@public-print = 'yes' or //resolution/@public-print = 'yes')">
					<div style="text-align:center" class="lbexBold">
						<xsl:if
							test="//form/action[position() = last()]/action-date and not(//form/action[position() = last()]/action-date/@display = 'no') and not(//form/action[position() = last()]/@display = 'no')">
							<xsl:value-of select="//form/action[position() = last()]/action-date"/>
						</xsl:if>
						<xsl:if
							test="//form/action[position() = last()]/action-desc and not(//form/action[position() = last()]/action-desc/@display = 'no') and not(//form/action[position() = last()]/@display = 'no')">
							<br/>
							<br/>
							<xsl:value-of select="//form/action[position() = last()]/action-desc"/>
						</xsl:if>
					</div>
					<br/>
					<br/>
					<br/>
					<br/>
				</xsl:when>
				<!--xsl:when
					test="($documentStage='Reported-in-House' or $documentStage='Reported-in-Senate' or
					$documentStage='Reported-House'  or $documentStage ='Placed-on-Calendar-Senate' )  and not (calendar/@display='no')"-->
				<xsl:when test="calendar and not(calendar/@display = 'no')">
					<p style="text-align:right" class="lbexCalendarOLC">
						<xsl:apply-templates select="calendar"/>
					</p>
				</xsl:when>
				<xsl:otherwise>
					<p>
						<br/>
					</p>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when
					test="
						$billStage = 'Enrolled-Bill' or $resolutionStage = 'Enrolled-in-Senate' or
						$resolutionStage = 'Enrolled-House' or $resolutionStage = 'Enrolled-Bill'">
					<!-- TB July-6-2015 Bug fixing #1395 -->
					<!--table>
						<tr>
							<td>
								
							</td>
							<td style="text-align:right">								
								<xsl:if test="$resolutionStage='Enrolled-in-Senate'">
									<span class="lbexLegisNumSml">
										<xsl:apply-templates
											select="/resolution/attestation/attestation-group/attestation-date"
										/>
									</span>
								</xsl:if>
								<xsl:if
									test="$resolutionStage='Enrolled-Bill' or $billStage='Enrolled-Bill'">									
									<span class="lbexSectionLevelTradBold">
										<xsl:call-template name="actionDateText"/>
									</span>
								</xsl:if>

							</td>
						</tr>
					</table-->

					<div style="text-align:center">
						<span class="lbexCongressEnrolled">

							<!--TB 28Aug 2007 bug# 667+ not printed session number in the enrollment bill . the long choose statement was moved to the template. Templated values added  and added general representation -->
							<xsl:call-template name="CongressText">
								<xsl:with-param name="CNum" select="congress"/>
							</xsl:call-template>

						</span>
					</div>
					<div style="text-align:center">
						<p/>
						<span class="lbexSessionEnrolled">
							<!--TB 28Aug 2007 bug# 667 Choose statement was moved to the template. -->
							<xsl:call-template name="SessionTextAll">
								<xsl:with-param name="SText" select="session"/>
							</xsl:call-template>
						</span>
					</div>
					<span class="lbexDateEnrolled">
						<!-- TB Sep2001 MultBrowsers italic tag inserted -->
						<div style="text-align:center">
							<i>
								<p/>
								<xsl:if test="enrolled-dateline">
									<xsl:value-of select="substring-before(enrolled-dateline, ',')"/>
									<xsl:text>, </xsl:text>
									<br/>
									<xsl:value-of select="substring-after(enrolled-dateline, ',')"/>
								</xsl:if>
							</i>
						</div>
					</span>
					<div style="text-align:center">
						<p/>
						<xsl:choose>
							<xsl:when test="$billStage = 'Enrolled-Bill'">
								<xsl:choose>
									<xsl:when
										test="contains(normalize-space(translate(legis-type, $upper, $lower)), 'an act')">
										<img src="Enrolled_An_Act.JPG" alt=""/>
									</xsl:when>
									<xsl:otherwise>
										<span class="lbexlegisEnrolled">
											<xsl:value-of
												select="translate(legis-type, $upper, $lower)"/>
										</span>
									</xsl:otherwise>
								</xsl:choose>

							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when
										test="contains(normalize-space(translate(legis-type, $upper, $lower)), 'joint resolution')">
										<img src="Enrolled_Joint_Resolution.JPG" alt=""/>
									</xsl:when>
									<xsl:when
										test="contains(normalize-space(translate(legis-type, $upper, $lower)), 'concurrent resolution')">
										<img src="Enrolled_Concurrent_Resolution.JPG" alt=""/>
									</xsl:when>
									<xsl:otherwise>
										<span class="lbexLegisEngrossed">
											<xsl:value-of
												select="translate(legis-type, $upper, $lower)"/>
										</span>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</div>
					<xsl:choose>
						<xsl:when test="$resolutionStage = 'Engrossed-in-Senate'">
							<div style="text-align:center">
								<xsl:if test="not(official-title/@display = 'no')">
									<div class="lbexTocDivisionOLC">
										<xsl:apply-templates select="official-title"/>
									</div>
								</xsl:if>
							</div>
						</xsl:when>
						<xsl:when test="not($resolutionStage = 'Enrolled-in-Senate')">
							<ul>
								<xsl:if test="not(official-title/@display = 'no')">
									<p style="text-align:left" class="lbexHang">
										<xsl:apply-templates select="official-title"/>
									</p>
								</xsl:if>
							</ul>
						</xsl:when>
					</xsl:choose>
					<p/>
				</xsl:when>
				<xsl:when
					test="
						($resolutionStage = 'Engrossed-House' and $resolutionType = 'house-resolution') or
						($resolutionStage = 'Engrossed-in-House' and $resolutionType = 'house-resolution') or
						($resolutionStage = 'Engrossed-Senate' and $resolutionType = 'senate-resolution') or
						($resolutionStage = 'Engrossed-in-Senate' and $resolutionType = 'senate-resolution')">
					<span class="lbexLegisNumSml">
						<!-- commented by TB Jan-15-2014 printing legis-num instead -->
						<!-- uncommented and inserted choose case by TB Mar-3-2014 H.Res. must be  not all cap -->
						<xsl:choose>
							<xsl:when
								test="contains(translate(legis-num, $lower, $upper), 'H. RES.')">
								<xsl:text>H. Res. </xsl:text>
								<xsl:value-of
									select="substring-after(substring-after(legis-num, '.'), '.')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="legis-num"/>
							</xsl:otherwise>
						</xsl:choose>
					</span>
					<br/>
					<br/>
					<br/>
					<br/>
					<xsl:if
						test="not(current-chamber/@display = 'no') and (not(parent::form/@display = 'no') or not(action/action-date/@display = 'no')) and not(translate($documentStage, $upper, $lower) = 'engrossed-in-house') and not(translate($documentStage, $upper, $lower) = 'engrossed-in-senate')">
						<hr style="width:40%"/>
					</xsl:if>
					<xsl:if
						test="not(current-chamber/@display = 'no') and not(parent::form/@display = 'no')">
						<div style="text-align:center">
							<span class="lbexChamberEngrHouse">
								<!-- TB Sep2001 MultBrowsers italic tag inserted -->
								<i>
									<xsl:apply-templates select="current-chamber"/>
								</i>
							</span>
						</div>
						<p/>
					</xsl:if>
					<xsl:if test="not(action/action-date/@display = 'no')">
						<xsl:apply-templates select="action/action-date"/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="printLegisNumForBills"/>
					<p/>
					<!-- TB 30Aug2007 #673 print assosiated doc resolution stage Reported-in-house was added. previously was only Reported-House -spelling mistake or old version of the resolution stage value enum -->
					<!--xsl:if
						test="($billStage='Reported-in-House' or $billStage='Reported-in-Senate'
						or $resolutionStage='Reported-House' or $resolutionStage='Reported-in-House') and not (associated-doc/@display='no') "-->
					<!--xsl:if
						test="$documentStage != 'Pre-Introduction'  and not (associated-doc/@display='no') and associated-doc/text() != '' "-->
					<!-- print associated doc for pre-introduction stage too TB 4May2009 -->
					<xsl:if
						test="contains($documentStage, 'Engrossed') and contains($documentType, 'order') and not(//current-chamber/@display = 'no')">
						<div style="text-align:center" class="lbexChamberEngrHouse">
							<!-- TB Sep2001 MultBrowsers italic tag inserted -->
							<i>
								<xsl:value-of select="//current-chamber"/>
							</i>
						</div>
					</xsl:if>
					<xsl:if
						test="not(associated-doc/@display = 'no') and associated-doc/text() != ''">
						<p style="text-align:center" class="lbexSectionlevelOLCBold">
							<xsl:apply-templates select="associated-doc"/>
						</p>
					</xsl:if>
					<!-- made a change here 4/6-->
					<xsl:choose>
						<!-- TB 15-Oct-2008 -->
						<xsl:when
							test="(translate($documentStage, $upper, $lower) = 'engrossed-in-senate' or translate($documentStage, $upper, $lower) = 'engrossed-amendment-senate') and (//bill/@public-print = 'yes' or //resolution/@public-print = 'yes')">
							<xsl:call-template name="printActionDateForBills"/>
						</xsl:when>
						<xsl:when
							test="translate($documentStage, $upper, $lower) = 'engrossed-in-senate' or translate($documentStage, $upper, $lower) = 'engrossed-amendment-senate'">
							<div style="text-align:center">
								<xsl:if test="$toDisplayOpeningRuller = 'yes'">
									<hr style="width:40%"/>
								</xsl:if>
								<xsl:apply-templates select="action"/>
							</div>
						</xsl:when>
						<xsl:when
							test="
								$resolutionStage = 'Engrossed-in-Senate' or
								($resolutionStage = 'Engrossed-House' and $resolutionType = 'house-joint') or
								($resolutionStage = 'Engrossed-in-House' and $resolutionType = 'house-joint') or
								($resolutionStage = 'Engrossed-House' and $resolutionType = 'senate-concurrent') or
								($resolutionStage = 'Engrossed-in-House' and $resolutionType = 'senate-concurrent') or
								($resolutionStage = 'Engrossed-House' and $resolutionType = 'house-concurrent') or
								($resolutionStage = 'Engrossed-in-House' and $resolutionType = 'house-concurrent')"> </xsl:when>
						<xsl:when
							test="
								$billStage = 'Received-in-Senate' or $billStage = 'Received-in-House' or
								$billStage = 'Referred-in-Senate' or $billStage = 'Referred-in-House'">
							<hr style="width:40%"/>
							<p/>
							<div style="text-align:center">
								<span class="lbexChamber">
									<xsl:apply-templates select="current-chamber"/>
									<xsl:apply-templates select="action"/>
								</span>
							</div>
						</xsl:when>
						<!-- TB 4Sep2007 #679 Do not display title for the PCS and RS concurrent resolutions. Added resolution stages in the appropriate -current- case -->
						<xsl:when
							test="
								$resolutionStage = 'Referred-in-Senate' or $resolutionStage = 'Received-in-Senate' or
								$resolutionStage = 'Reported-in-Senate' or $resolutionStage = 'Placed-on-Calendar-Senate'">
							<hr style="width:40%"/>
							<p/>
							<div style="text-align:center">
								<span class="lbexChamber">
									<xsl:apply-templates select="current-chamber"/>
								</span>
							</div>
							<xsl:apply-templates select="action"/>
						</xsl:when>
						<xsl:otherwise>
							<!--xsl:if
								test="not ($billStage='Engrossed-in-House' or $billStage='Engrossed-in-Senate' )"-->
							<xsl:if
								test="not($documentStage = 'Engrossed-in-House' or $documentStage = 'Engrossed-in-Senate')">
								<br/>
								<xsl:if
									test="not(official-title/@display = 'no') and not(parent::form/@display = 'no')">
									<!--ul-->
									<p style="text-align:left;margin-left: 2em;" class="lbexHang">
										<xsl:apply-templates select="official-title"/>
									</p>
									<!--/ul-->
									<hr style="width:40%"/>
								</xsl:if>
								<p/>
								<xsl:if
									test="not(current-chamber/@display = 'no') and not(parent::form/@display = 'no')">
									<div style="text-align:center">
										<span class="lbexChamber">
											<xsl:apply-templates select="current-chamber"/>
										</span>
									</div>
								</xsl:if>
							</xsl:if>
							<xsl:if
								test="($billStage = 'Engrossed-in-House' or $billStage = 'Engrossed-in-Senate') and $toDisplayOpeningRuller = 'yes'">
								<hr style="width:40%"/>
							</xsl:if>
							<xsl:apply-templates select="action"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if
						test="not(contains($documentType, 'order') or ($documentStage = 'Engrossed-in-House' and $documentStage = 'Engrossed-in-Senate'))">
						<hr style="width:40%"/>
					</xsl:if>
					<p/>
					<xsl:if test="not(legis-type/@display = 'no')">
						<div style="text-align:center">
							<b>
								<span class="lbexLegisType">
									<xsl:apply-templates select="legis-type"/>
								</span>
							</b>
						</div>
					</xsl:if>
					<p/>
					<xsl:choose>
						<xsl:when
							test="
								($resolutionStage = 'Engrossed-in-Senate' and $resolutionType = 'senate-concurrent') or
								($resolutionStage = 'Engrossed-House' and $resolutionType = 'senate-concurrent') or
								($resolutionStage = 'Engrossed-in-House' and $resolutionType = 'senate-concurrent') or
								($resolutionStage = 'Engrossed-House' and $resolutionType = 'house-concurrent') or
								($resolutionStage = 'Engrossed-in-House' and $resolutionType = 'house-concurrent')
								"/>
						<xsl:otherwise>
							<p style="text-align:left" class="lbexHangWithMargin">
								<xsl:if test="not(official-title/@display = 'no')">
									<!-- TB 4Sep2007 #679 fix for display=no attribute -->
									<xsl:apply-templates select="official-title"/>
								</xsl:if>
							</p>
							<p/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<xsl:template name="toPrintAnOpeningRuler">
		<xsl:choose>
			<xsl:when test="contains($documentStage, 'Enrolled')">
				<xsl:text>no</xsl:text>
			</xsl:when>
			<xsl:when
				test="(translate($documentType, $upper, $lower) = 'house-resolution' or translate($documentType, $upper, $lower) = 'senate-order' or translate($documentType, $upper, $lower) = 'senate-resolution') and (contains(translate($documentStage, $upper, $lower), 'engrossed'))">
				<xsl:text>no</xsl:text>
			</xsl:when>
			<xsl:when
				test="//current-chamber and not(//current-chamber/@display = 'no') and not(//current-chamber/text = '') and (not((contains(translate($documentStage, $upper, $lower), 'engrossed'))) and contains(translate($documentType, $upper, $lower), 'concurrent'))">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="not(//form/action) and not(//form/action/@display = 'yes' or not(//form/action/@display))">
				<xsl:text>no</xsl:text>
			</xsl:when>
			<xsl:when
				test="//form/action[@display = 'yes' or not(@display)]/child::*[@display = 'yes' or not(@display)]">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="action">
		<xsl:apply-templates select="action-date"/>
		<div style="text-align:left;" class="lbexHang">
			<xsl:apply-templates select="action-desc"/>
		</div>
		<xsl:if test="action-instruction and action-instruction != ''">
			<div style="text-align:center">
				<xsl:apply-templates select="action-instruction"/>
			</div>
		</xsl:if>
		<p/>
	</xsl:template>

	<xsl:template match="action-date">
		<xsl:if test="not(@display = 'no') and not(parent::action/@display = 'no')">
			<xsl:choose>
				<xsl:when test="$isReport = 'yes'"/>
				<xsl:when
					test="contains(., 'legislative day') and not(contains($documentType, 'order') or ($documentStage = 'Engrossed-in-House' and $documentStage = 'Engrossed-in-Senate'))">
					<div style="text-align:center">
						<p/>
						<span class="lbexSimplecap">
							<xsl:value-of
								select="substring-before(., substring-before(substring-after(., '('), ')'))"
							/>
						</span>
						<xsl:value-of select="substring-before(substring-after(., '('), ',')"/>
						<span class="lbexSimplecap">
							<xsl:text>, </xsl:text>
							<xsl:value-of select="substring-before(substring-after(., ','), ')')"/>
							<xsl:value-of
								select="substring-after(., substring-before(substring-after(., '('), ')'))"
							/>
						</span>
						<p/>
					</div>
				</xsl:when>
				<xsl:when
					test="$resolutionStage = 'Engrossed-House' or $resolutionStage = 'Engrossed-in-House' or $amendType = 'engrossed-amendment'">
					<p style="text-align:right">
						<i>
							<xsl:apply-templates/>
							<xsl:if test="substring(., string-length(.)) != '.'">
								<xsl:text>.</xsl:text>
							</xsl:if>
							<xsl:text disable-output-escaping="yes">&#x00A0;</xsl:text>
							<xsl:text disable-output-escaping="yes">&#x00A0;</xsl:text>
						</i>
					</p>
				</xsl:when>
				<xsl:otherwise>
					<div style="text-align:center">
						<p/>
						<xsl:choose>
							<xsl:when test="contains(normalize-space(.), 'legislative day')">
								<span class="lbexSimplecap">
									<xsl:value-of select="substring-before(., 'legislative')"/>
								</span>
								<span class="lbexAllNormal">
									<xsl:text>legistlative day</xsl:text>
								</span>
								<span class="lbexSimplecap">
									<xsl:value-of select="substring-after(., 'day')"/>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<span class="lbexSimplecap">
									<xsl:apply-templates/>
								</span>
							</xsl:otherwise>
						</xsl:choose>
						<p/>
					</div>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<xsl:template match="legis-body">
		<xsl:choose>
			<xsl:when
				test="local-name(child::*[1]) = 'section' and child::section[1]/@section-type = 'undesignated-section' and child::section[1]/@display-inline = 'yes-display-inline' and @display-enacting-clause = 'no-display-enacting-clause'">
				<p style="text-align:left">
					<xsl:call-template name="print-legis-body"/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p style="text-align:left" class="lbexIndent">
					<xsl:call-template name="print-legis-body"/>
				</p>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>
	<xsl:template name="print-legis-body">
		<xsl:choose>
			<xsl:when
				test="./@display-enacting-clause = 'no-display-enacting-clause' or (//amendment-doc/@amend-type = 'conference-report')"/>
			<xsl:otherwise>
				<em>
					<xsl:value-of select="$enact"/>
				</em>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when
				test="./@added-display-style = 'boldface-roman' or ./@reported-display-style = 'boldface-roman'">
				<b class="lbexChapterLevelOLCNuclear">
					<xsl:call-template name="displayLegisBody"/>
				</b>
			</xsl:when>
			<xsl:when
				test="./@added-display-style = 'italic' or ./@reported-display-style = 'italic'">
				<i>
					<xsl:call-template name="displayLegisBody"/>
				</i>
			</xsl:when>
			<xsl:when
				test="./@added-display-style = 'boldface-italic' or ./@reported-display-style = 'boldface-italic'">
				<i class="lbexChapterLevelOLCNuclear">
					<xsl:call-template name="displayLegisBody"/>
				</i>
			</xsl:when>
			<xsl:when
				test="./@deleted-display-style = 'strikethrough' or ./@reported-display-style = 'strikethrough'">
				<div class="lbexTextStrikethrough">
					<xsl:call-template name="displayLegisBody"/>
				</div>
			</xsl:when>
			<xsl:when test="preceding-sibling::legis-body">
				<div class="normalFontStyleBlock">
					<xsl:call-template name="displayLegisBody"/>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="displayLegisBody"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>
	<xsl:template name="displayLegisBody">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="preamble">
		<xsl:call-template name="displayPreamble"/>
		<!--<xsl:choose>
			<!-\- TB 30Aug2007 #678  changed was added to the whhen condition-\->
			<xsl:when test="(whereas/@added-display-style = 'italic' or whereas/@reported-display-style = 'italic') and whereas/@changed = 'added'">
				<i class="lbexTextNeutral">
					<xsl:call-template name="displayPreamble"/>
				</i>
			</xsl:when>
			<xsl:when
				test="(whereas/@deleted-display-style = 'strikethrough' or whereas/@reported-display-style='strikethrough') and whereas/@changed = 'deleted'">
				<!-\\- TB 30Aug2007 #678  changed was added to the when condition-\\->
				<span class="lbexTextStrikethrough">
					<xsl:call-template name="displayPreamble"/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="displayPreamble"/>
			</xsl:otherwise>
		</xsl:choose>-->
	</xsl:template>
	<xsl:template name="displayPreamble">
		<p style="text-align:left">
			<xsl:choose>
				<xsl:when
					test="(@added-display-style = 'italic' or @reported-display-style = 'italic')">
					<i class="lbexTextNeutral">
						<xsl:apply-templates/>
					</i>
				</xsl:when>
				<xsl:when
					test="(@added-display-style = 'boldface-italic' or @reported-display-style = 'boldface-italic')">
					<i class="lbexTextNeutral">
						<b>
						<xsl:apply-templates/>
						</b>
					</i>
				</xsl:when>
				<xsl:when
					test="(@added-display-style = 'boldface-roman' or @reported-display-style = 'boldface-roman')">
					<b class="lbexTextNeutral">
							<xsl:apply-templates/>
					</b>
				</xsl:when>
				<xsl:when
					test="(@deleted-display-style = 'strikethrough' or @reported-display-style = 'strikethrough') and @changed = 'deleted'">
					<div class="lbexTextStrikethrough">
						<xsl:apply-templates/>
					</div>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
		</p>
	</xsl:template>
	<xsl:template match="whereas">
		<ul>
			<p class="lbexHang" style="text-align:left">
				<xsl:if test="@commented = 'yes'">
					<xsl:call-template name="openBracketStyles"/>
				</xsl:if>
				<xsl:choose>
				<xsl:when test="@reported-display-style = 'boldface-roman'">
					<div class="lbexChapterLevelOLCBoldNuclear">
						<xsl:apply-templates/>
					</div>
				</xsl:when>
				<xsl:when test="@reported-display-style = 'boldface-italic'">
					<div>
						<i class="lbexChapterLevelOLCBoldNuclear">
							<xsl:apply-templates/>
						</i>
					</div>
				</xsl:when>
				<xsl:when test="@reported-display-style = 'italic'">
					<div class="lbexSimpleItalic">
							<xsl:apply-templates/>
					</div>
				</xsl:when>
				<xsl:when test="@reported-display-style = 'strikethrough'">
						<div class="lbexTextStrikethrough">
							<xsl:apply-templates/>
						</div>
				</xsl:when>
				<xsl:otherwise>
						<xsl:apply-templates/>
				</xsl:otherwise>
				</xsl:choose>
				<xsl:variable name="isToCloseTheBrackets">
					<xsl:call-template name="toCloseTheBrakets"/>
				</xsl:variable>
			<xsl:if test="@commented = 'yes'">
					<xsl:choose>
						<xsl:when test= "child::text">
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="closedBracketStyles"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</p>
		</ul>
	</xsl:template>
	<xsl:template match="resolution-body">
		<xsl:choose>
			<xsl:when test="$resolutionType = 'house-concurrent'">
				<p style="text-align:left" class="lbexIndent">
					<em>
						<xsl:value-of select="$HouseConcurrent"/>
					</em>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when test="./@style = 'constitutional-amendment'">
				<p style="text-align:left" class="lbexIndent">
					<em>
						<xsl:value-of select="$ConstitutionalAmendment"/>
					</em>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when test="$resolutionType = 'house-joint'">
				<p style="text-align:left" class="lbexIndent">
					<em>
						<xsl:value-of select="$HouseJoint"/>
					</em>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<!--xsl:when
				test="$resolutionType='house-resolution' and //resolution-body[position() =1] = self::*"-->
			<xsl:when
				test="$resolutionType = 'house-resolution' and not(ancestor-or-self::resolution-body/@display-resolving-clause = 'no-display-resolving-clause')">
				<p style="text-align:left" class="lbexIndent">
					<em>
						<xsl:value-of select="$HouseResolution"/>
					</em>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when
				test="($resolutionType = 'house-order' or $resolutionType = 'senate-order') and not(ancestor-or-self::resolution-body/@display-resolving-clause = 'no-display-resolving-clause')">
				<p style="text-align:left" class="lbexIndent">
					<em>
						<xsl:value-of select="$OrderedSection"/>
					</em>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when test="$resolutionType = 'senate-concurrent'">
				<p style="text-align:left" class="lbexIndent">
					<em>
						<xsl:value-of select="$SenateConcurrent"/>
					</em>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when test="$resolutionType = 'senate-joint'">
				<p style="text-align:left" class="lbexIndent">
					<em>
						<xsl:value-of select="$SenateJoint"/>
					</em>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when
				test="$resolutionType = 'senate-resolution' and not(@display-resolving-clause = 'no-display-resolving-clause')">
				<p style="text-align:left" class="lbexIndent">
					<em>
						<xsl:value-of select="$SenateResolution"/>
					</em>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when
				test="local-name(child::*[1]) = 'section' and child::section[1]/@section-type = 'undesignated-section' and child::section[1]/@display-inline = 'yes-display-inline' and @display-resolving-clause = 'no-display-resolving-clause'">
				<!-- bug fixing #1093 TB 15Dec2009 -->
				<xsl:choose>
					<xsl:when
						test="./@added-display-style = 'boldface-roman' or ./@reported-display-style = 'boldface-roman'">
						<b>
							<p style="text-align:left">
								<xsl:apply-templates/>
							</p>
						</b>
					</xsl:when>
					<xsl:when
						test="./@added-display-style = 'italic' or ./@reported-display-style = 'italic'">
						<p style="text-align:left" class="lbexIndent">
							<i>
								<p style="text-align:left">
									<xsl:apply-templates/>
								</p>
							</i>
						</p>
					</xsl:when>
					<xsl:when
						test="./@deleted-display-style = 'strikethrough' or ./@reported-display-style = 'strikethrough'">
						<span class="lbexTextStrikethrough">
							<p style="text-align:left">
								<xsl:apply-templates/>
							</p>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<div style="text-align:left">
							<xsl:apply-templates/>
						</div>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:when>
			<!--otherwise test added by SLC on 12/13/2007 to deal with resolutions of type="standard"-->
			<xsl:otherwise>
				<!-- bug fixing #1093 TB 15Dec2009 -->
				<xsl:choose>
					<xsl:when
						test="./@added-display-style = 'boldface-roman' or ./@reported-display-style = 'boldface-roman'">
						<b class="lbexChapterLevelOLCNuclear">
							<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
						</b>
					</xsl:when>
					<xsl:when
						test="./@added-display-style = 'italic' or ./@reported-display-style = 'italic'">

						<i class="lbexTextNeutral">
							<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
						</i>

					</xsl:when>
					<xsl:when
						test="./@deleted-display-style = 'strikethrough' or ./@reported-display-style = 'strikethrough'">
						<span class="lbexTextStrikethrough">
							<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--changes made 12/28-->
	<xsl:template match="action-desc">
		<xsl:choose>
			<xsl:when test="@display = 'no' or parent::action/@display = 'no'"/>
			<xsl:when test="ancestor::committee-report-form">
				<div>
					<xsl:if test="preceding-sibling::action-date">
						<xsl:attribute name="style">
							<xsl:text>font-size: 75%;text-align:center</xsl:text>
						</xsl:attribute>
					</xsl:if>
					<xsl:if
						test="(@display-inline = 'yes-display-inline' or not(@display-inline)) and preceding-sibling::action-date[@display = 'yes']">
						<xsl:choose>
							<xsl:when test="preceding-sibling::action-date/@display = 'no'"/>
							<xsl:when test="preceding-sibling::action-date/text() != ''">
								<xsl:choose>
									<xsl:when test="//committee-report">
										<xsl:call-template name="printActionDateForCommitteeReport">
											<xsl:with-param name="aActionDateText">
												<xsl:value-of
												select="preceding-sibling::action-date"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="preceding-sibling::action-date"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>________</xsl:text>
							</xsl:otherwise>
						</xsl:choose>


						<xsl:text>.— </xsl:text>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="@display = 'no'"/>
						<xsl:when test="text() != ''">
							<xsl:apply-templates/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>_____________________________________________</xsl:text>
						</xsl:otherwise>
					</xsl:choose>


				</div>
			</xsl:when>
			<xsl:when test="ancestor::*/amendment-form">
				<xsl:call-template name="printActionDescForAmendment"/>
			</xsl:when>
			<xsl:when
				test="$isReport = 'yes' or contains(translate($documentStage, $upper, $lower), 'engrossed')">
				<p style="text-align:center" class="lbexHangSmall">
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<!--ul-->
				<p style="text-align:left" class="lbexHangSmalllWithMargin">
					<xsl:apply-templates/>
				</p>
				<!--/ul-->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="action-instruction">
		<xsl:choose>
			<xsl:when test="ancestor::*/amendment-form">
				<xsl:call-template name="printActionInstructionForAmendmennt"/>
			</xsl:when>
			<xsl:when test="$isReport = 'yes'">
				<div style="text-align:center; font-size: 65%">
					<xsl:if
						test="(@display-inline = 'yes-display-inline' or not(@display-inline)) and preceding-sibling::action-date[@display = 'yes']">
						<xsl:value-of select="preceding-sibling::action-date"/>
						<xsl:text>.— </xsl:text>
					</xsl:if>

					<xsl:choose>
						<xsl:when test="@display = 'no'"/>
						<xsl:when test="text() != ''">
							<xsl:text>[ </xsl:text>
							<xsl:apply-templates/>
							<xsl:text> ]</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>[ </xsl:text>
							<xsl:text>__________________________________</xsl:text>
							<xsl:text> ]</xsl:text>
						</xsl:otherwise>
					</xsl:choose>

				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="text() != ''">
					<div style="text-align:center">
						<p style="font-size: 65%">
							<xsl:text>[</xsl:text>
							<xsl:apply-templates/>
							<xsl:text>]</xsl:text>
						</p>
					</div>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- TB 5Feb2008 Committee Reports support -->
	<xsl:template match="sponsor | cosponsor">
		<xsl:choose>
			<xsl:when test="contains(., '.')">
				<xsl:call-template name="ActualPrintSponsor"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="ActualPrintSponsor">
		<xsl:variable name="flag">
			<xsl:value-of select="contains(., ' of ')"/>
		</xsl:variable>
		<xsl:if test="$flag = 'false'">
			<xsl:value-of select="substring-before(., '.')"/>
			<xsl:text>. </xsl:text>
			<span class="lbexSimplecap">
				<xsl:value-of select="substring-after(., '.')"/>
			</span>
		</xsl:if>
		<xsl:if test="$flag = 'true'">
			<xsl:value-of select="substring-before(., '.')"/>
			<xsl:text>. </xsl:text>
			<xsl:variable name="State">
				<xsl:value-of select="substring-before(substring-after(., '.'), 'of')"/>
			</xsl:variable>
			<span class="lbexSimplecap">
				<xsl:value-of select="substring-before(substring-after(., '.'), 'of')"/>
			</span>
			<xsl:value-of select="substring-after(., $State)"/>
		</xsl:if>
	</xsl:template>
	<!--end of form-->

	<xsl:template name="getOutputStyle">
		<xsl:choose>
			<xsl:when
				test="
					(@reported-display-style = 'boldface-roman' and not(ancestor::*[@reported-display-style = 'boldface-roman'])) or
					(not(@reported-display-style ) and parent::*/@reported-display-style = 'boldface-roman' and not(parent::*/ancestor::*[@reported-display-style = 'boldface-roman']) and not(@changed = 'not-changed')) or
					(contains(ancestor::legis-body/@reported-display-style, 'boldface-roman') and not(@reported-display-style)) or(not(@reported-display-style) and ancestor::*[@reported-display-style ='boldface-roman'] and (@changed != 'not-changed' or not(@changed)))">
				<xsl:text>lbexSectionlevelOLCBold</xsl:text>
			</xsl:when>
			<xsl:when test="@reported-display-style = 'boldface-roman' and parent::*[@reported-display-style = 'boldface-roman'] and (@changed != 'not-changed' or not(@changed))  ">
				<xsl:text>lbexSectionlevelOLCBold</xsl:text>	
			</xsl:when>
			<xsl:when
				test="
					(not(@reported-display-style) and (ancestor::legis-body/@reported-display-style = 'brackets-boldface-italic' or contains(ancestor::legis-body/@reported-display-style, 'boldface-italic'))) or
					(@reported-display-style = 'boldface-italic' and (ancestor::*[@reported-display-style != 'boldface-italic'] or not(ancestor::*/@reported-display-style)))">
				<xsl:text>lbexSectionlevelItalicOLCBold</xsl:text>
			</xsl:when>
			<xsl:when
				test="@reported-display-style = '' and parent::*/@reported-display-style = 'boldface-italic' and not(parent::*/ancestor::*[@reported-display-style = 'boldface-italic']) and not(@changed = 'not-changed')">
				<xsl:text>lbexSectionlevelOLCBold</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::resolution-body/@reported-display-style = 'strikethrough'">
				<xsl:if test="not(child::section/@reported-display-style)">
					<xsl:text>lbexTextStrikethrough</xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:when
				test="
					(@deleted-display-style = 'strikethrough' or
					@reported-display-style = 'strikethrough') and not(ancestor::*[@reported-display-style = 'strikethrough']) and not(contains(child::*/@changed, 'not-changed')) and not(contains(child::*/child::*/@changed, 'not-changed'))">
				<xsl:text>lbexTextStrikethrough</xsl:text>
			</xsl:when>
			<xsl:when
				test="not(@reported-display-style) and ((child::*[@changed != 'not-changed']) or not(child::*/@changed)) and (@changed != 'not-changed' or not(@changed))  and (parent::*/@reported-display-style = 'strikethrough' or parent::*/@deleted-display-style = 'strikethrough') and not(parent::*/ancestor::*[@reported-display-style = 'strikethrough'])">
				<xsl:text>lbexTextStrikethrough</xsl:text>
			</xsl:when>
			<xsl:when
				test="
					@reported-display-style = 'italic' and (parent::*/@deleted-display-style != 'italic' or
					(parent::*/@reported-display-style != 'italic') and not(parent::*/ancestor::*[@reported-display-style = 'italic'])) and @changed != 'not-changed'">
				<xsl:text>lbexSimpleItalic</xsl:text>
			</xsl:when>
			<xsl:when
				test="
					(@reported-display-style = 'italic' and parent::*/ancestor::*[@reported-display-style != 'italic']) or (not(@reported-display-style) and not(parent::*/@reported-display-style) and parent::*/ancestor::*[@reported-display-style = 'italic'])
					or (not(@reported-display-style) and not(parent::*/@reported-display-style) and ancestor::*[@reported-display-style = 'italic']) or (not(@reported-display-style) and parent::*/@reported-display-style = 'italic')">
				<xsl:text>lbexSimpleItalic</xsl:text>
			</xsl:when>
			<xsl:when
				test="(@reported-display-style = 'italic' and ancestor::*/@reported-display-style = 'italic')">
				<xsl:text>lbexSimpleItalic</xsl:text>
			</xsl:when>
		<xsl:when test="@commented ='hidden'">
				<xsl:text>hidden</xsl:text>
			</xsl:when>
		<xsl:otherwise>
				<xsl:text/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="isNeutralizeSegment">
		<!-- should we make italic to be neutral -->
		<xsl:choose>
			<xsl:when
				test="contains(@reported-display-style, 'italic') and (parent::*/@reported-display-style != 'italic' or parent::quoted-block//@reported-display-style != 'italic') and ancestor::*[@reported-display-style = 'strikethrough']">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="(contains(@reported-display-style, 'strikethrough') and ancestor::*[@reported-display-style != 'strikethrough']) or (parent::quoted-block//@reported-display-style != 'strikethrough' and contains(@reported-display-style,'strikethrough')) ">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="contains(@reported-display-style, 'boldface-roman') and (not(contains(parent::*/@reported-display-style, 'boldface-roman')) or contains(parent::quoted-block//@reported-display-style, 'boldface-roman'))">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="contains(@reported-display-style, 'brackets')">
				<xsl:choose>
					<xsl:when test =" (not(parent::*/@reported-display-style) or contains(parent::*/@reported-display-style, 'brackets')) or (contains(parent::quoted-block//@reported-display-style, 'brackets'))">
						<xsl:text>no</xsl:text>
					</xsl:when>
					<xsl:when test =" not(contains(parent::*/@reported-display-style, 'brackets')) or not(contains(parent::quoted-block//@reported-display-style, 'brackets'))">
						<xsl:text>yes</xsl:text>	
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when
				test="(@changed = 'not-changed') and ancestor::*[@reported-display-style != ''] and not(parent::*/@reported-display-style)">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when test="(@changed = 'not-changed') and parent::*[@reported-display-style != '']">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="not(@changed) and parent::*/@changed = 'not-changed' and parent::*/ancestor::*[@reported-display-style != ''] and @display-inline = 'yes-display-inline'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>no</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="getNeutralBlockClassName">
		<!-- should we make styles to be neutral -->
		<xsl:choose>
			<xsl:when
				test="(contains(@reported-display-style, 'italic') or contains(@reported-display-style, 'boldface-roman')) and (not(contains(parent::*/@reported-display-style, 'italic')) or contains(parent::quoted-block//@reported-display-style, 'italic')) and ancestor::*[@reported-display-style = 'strikethrough']">
				<xsl:text>noneTextDecorationBlock</xsl:text>
			</xsl:when>
			<xsl:when
				test="(contains(@changed, 'not-changed')) and ancestor::*[@reported-display-style = 'strikethrough'] and not(parent::*/@reported-display-style)">
				<xsl:text>noneTextDecorationBlock</xsl:text>
			</xsl:when>
			<xsl:when
				test="(contains(@changed, 'not-changed')) and parent::*[@reported-display-style = 'strikethrough']">
				<xsl:text>noneTextDecorationBlock</xsl:text>
			</xsl:when>
			<xsl:when
				test="contains(@reported-display-style, 'italic') and (not(contains(parent::*/@reported-display-style, 'italic')) or not(contains(parent::quoted-block//@reported-display-style, 'italic')))">
				<xsl:text>normalFontStyleBlock</xsl:text>
			</xsl:when>
			<xsl:when
				test="contains(@reported-display-style, 'brackets') and (not(contains(parent::*/@reported-display-style, 'brackets')) or not(contains(parent::quoted-block//@reported-display-style, 'brackets')))">
				<xsl:text>normalFontStyleBlock</xsl:text>
			</xsl:when>
			<xsl:when
				test="contains(@reported-display-style, 'boldface-roman') and (not(contains(parent::*/@reported-display-style, 'boldface-roman')) or contains(parent::quoted-block//@reported-display-style, 'boldface-roman'))">
				<xsl:text>normalFontStyleBlock</xsl:text>
			</xsl:when>
		<xsl:when
				test="contains(@reported-display-style, 'strikethrough') and (not(contains(parent::*/@reported-display-style, 'strikethrough')) or contains(parent::quoted-block//@reported-display-style, 'strikethrough'))">
				<xsl:text>normalFontStyleBlock</xsl:text>
			</xsl:when>
			<xsl:when
				test="contains(@reported-display-style, 'brackets') and (contains(parent::*/@reported-display-style, 'strikethrough') or contains(parent::quoted-block//@reported-display-style, 'strikethrough'))">
				<xsl:text>noneTextDecorationBlock</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="getNeutralInlineClassName">
		<!-- should we make inlinestyles to be neutral -->
		<xsl:choose>
			<xsl:when
				test="(contains(@reported-display-style, 'italic') or contains(@reported-display-style, 'boldface-roman')) and (not(contains(parent::*/@reported-display-style, 'italic')) or contains(parent::quoted-block//@reported-display-style, 'italic')) and ancestor::*[@reported-display-style = 'strikethrough'] ">
				<xsl:text>noneTextDecorationInline</xsl:text>
			</xsl:when>
			<xsl:when
				test="(contains(@changed, 'not-changed')) and ancestor::*[@reported-display-style = 'strikethrough'] and not(parent::*/@reported-display-style)">
				<xsl:text>noneTextDecorationInline</xsl:text>
			</xsl:when>
			<xsl:when
				test="(contains(@changed, 'not-changed')) and parent::*[@reported-display-style = 'strikethrough']">
				<xsl:text>noneTextDecorationInline</xsl:text>
			</xsl:when>
			<xsl:when
				test="contains(@reported-display-style, 'italic') and (not(contains(parent::*/@reported-display-style, 'italic')) or contains(parent::quoted-block//@reported-display-style, 'italic'))">
				<xsl:text>normalFontStyleInline</xsl:text>
			</xsl:when>
			<xsl:when
				test="contains(@reported-display-style, 'brackets') and (not(contains(parent::*/@reported-display-style, 'brackets')) or contains(parent::quoted-block//@reported-display-style, 'brackets'))">
				<xsl:text>normalFontStyleInline</xsl:text>
			</xsl:when>
		<xsl:when
				test="contains(@reported-display-style, 'boldface-italic') and (not(contains(parent::*/@reported-display-style, 'boldface-italic')) or contains(parent::quoted-block//@reported-display-style, 'boldface-italic'))">
				<xsl:text>normalFontStyleInline</xsl:text>
			</xsl:when>
		<xsl:when
				test="contains(@reported-display-style, 'strikethrough') and (not(contains(parent::*/@reported-display-style, 'strikethrough')) or contains(parent::quoted-block//@reported-display-style, 'strikethrough'))">
				<xsl:text>normalFontStyleInline</xsl:text>
			</xsl:when>
			<xsl:when
				test="contains(@reported-display-style, 'brackets') and (contains(parent::*/@reported-display-style, 'strikethrough') or contains(parent::quoted-block//@reported-display-style, 'strikethrough'))">
				<xsl:text>noneTextDecorationInline</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="actualPrintSectionAndDownStructure">
		<xsl:param name="thePrintingTemplate"/>
		<xsl:choose>
			<xsl:when test="$thePrintingTemplate = 'displaySection'">
				<xsl:call-template name="displaySection"/>
			</xsl:when>
			<xsl:when test="$thePrintingTemplate = 'displaySubsection'">
				<xsl:call-template name="displaySubsection"/>
			</xsl:when>
			<xsl:when test="$thePrintingTemplate = 'displayParagraph'">
				<xsl:call-template name="displayParagraph"/>
			</xsl:when>
			<xsl:when test="$thePrintingTemplate = 'displaySubparagraph'">
				<xsl:call-template name="displaySubparagraph"/>
			</xsl:when>
			<xsl:when test="$thePrintingTemplate = 'displayClause'">
				<xsl:call-template name="displayClause"/>
			</xsl:when>
			<xsl:when test="$thePrintingTemplate = 'displaySubclause'">
				<xsl:call-template name="displaySubclause"/>
			</xsl:when>
			<xsl:when test="$thePrintingTemplate = 'displayItem'">
				<xsl:call-template name="displayItem"/>
			</xsl:when>
			<xsl:when test="$thePrintingTemplate = 'displaySubitem'">
				<xsl:call-template name="displaySubitem"/>
			</xsl:when>
			<xsl:when test="$thePrintingTemplate = 'displaySub'">
				<xsl:call-template name="displaySub"/>
			</xsl:when>
			<xsl:when test="$thePrintingTemplate = 'DisplayTitle'">
				<xsl:call-template name="DisplayTitle"/>
			</xsl:when>
			<xsl:when test="$thePrintingTemplate = 'displaySubtitle'">
				<xsl:call-template name="displaySubtitle"/>
			</xsl:when>
			<xsl:when test="$thePrintingTemplate = 'DisplayChapter'">
				<xsl:call-template name="DisplayChapter"/>
			</xsl:when>
			<xsl:when test="$thePrintingTemplate = 'DisplaySubchapter'">
				<xsl:call-template name="DisplaySubchapter"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="isBlockItalic">
		<xsl:choose>
			<xsl:when
				test="contains(@reported-display-style, 'italic') and not(ancestor::*[@reported-display-style = 'boldface-italic']) and not(ancestor::*[@reported-display-style = 'italic'])">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when test="contains(@added-display-style, 'italic')">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="contains(parent::quoted-block/@reported-display-style, 'italic') and not(parent::quoted-block/ancestor::*[@reported-display-style = 'boldface-italic']) and not(parent::quoted-block/ancestor::*[@reported-display-style = 'italic'])">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>no</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="printSectionAndDownStructure">
		<xsl:param name="thePrintingTemplate"/>

		<xsl:variable name="thePrintingClass">
			<xsl:call-template name="getOutputStyle"/>
		</xsl:variable>
		<xsl:variable name="isItalic">
			<xsl:call-template name="isBlockItalic"/>
		</xsl:variable>
		<xsl:variable name="makeSegmentNeutral">
			<!-- yes/no -->
			<xsl:call-template name="isNeutralizeSegment"/>
		</xsl:variable>
		<xsl:variable name="neutralBlockClassName">
			<xsl:call-template name="getNeutralBlockClassName"/>
		</xsl:variable>
		<xsl:variable name="neutralInlineClassName">
			<xsl:call-template name="getNeutralInlineClassName"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when
				test="$isItalic = 'yes' and $makeSegmentNeutral = 'yes' and $thePrintingClass != ''">
				<xsl:element name="div">
					<xsl:attribute name="class">
						<xsl:value-of select="$neutralBlockClassName"/>
					</xsl:attribute>
					<xsl:element name="div">
						<xsl:attribute name="class">
							<xsl:value-of select="$thePrintingClass"/>
						</xsl:attribute>
						<xsl:call-template name="actualPrintSectionAndDownStructure">
							<xsl:with-param name="thePrintingTemplate" select="$thePrintingTemplate"
							/>
						</xsl:call-template>
					</xsl:element>
				</xsl:element>
			</xsl:when>
			<xsl:when
				test="$isItalic = 'yes' and $makeSegmentNeutral = 'yes' and $thePrintingClass = ''">
				<xsl:element name="i">
					<xsl:attribute name="class">
						<xsl:value-of select="$neutralInlineClassName"/>
					</xsl:attribute>
					<xsl:call-template name="actualPrintSectionAndDownStructure">
						<xsl:with-param name="thePrintingTemplate" select="$thePrintingTemplate"/>
					</xsl:call-template>
				</xsl:element>
			</xsl:when>
			<xsl:when
				test="$isItalic = 'yes' and $makeSegmentNeutral = 'no' and $thePrintingClass != ''">
				<xsl:element name="div">
						<xsl:attribute name="class">
							<xsl:value-of select="$thePrintingClass"/>
						</xsl:attribute>
					<xsl:call-template name="actualPrintSectionAndDownStructure">
						<xsl:with-param name="thePrintingTemplate" select="$thePrintingTemplate"/>
					</xsl:call-template>
				</xsl:element>
			</xsl:when>
			<xsl:when test="$isItalic = 'yes' and $makeSegmentNeutral = 'no'">
				<xsl:element name="i">
						<xsl:attribute name="class">
							<xsl:value-of select="$neutralInlineClassName"/>
						</xsl:attribute>
					
					<i>
						<xsl:call-template name="actualPrintSectionAndDownStructure">
							<xsl:with-param name="thePrintingTemplate" select="$thePrintingTemplate"
							/>
						</xsl:call-template>
					</i>
				</xsl:element>
			</xsl:when>
			<xsl:when
				test="$isItalic = 'no' and $makeSegmentNeutral = 'no' and $thePrintingClass != ''">
				<xsl:if test="not(@display-inline) or @display-inline = 'no-display-inline'">
					<xsl:element name="div">
						<xsl:attribute name="class">
							<xsl:value-of select="$thePrintingClass"/>
						</xsl:attribute>
						
						<xsl:call-template name="actualPrintSectionAndDownStructure">
							<xsl:with-param name="thePrintingTemplate" select="$thePrintingTemplate"
							/>
						</xsl:call-template>
					</xsl:element>
				</xsl:if>
				<xsl:if test="@display-inline = 'yes-display-inline'">
					<xsl:element name="span">
						<xsl:attribute name="class">
							<xsl:value-of select="$thePrintingClass"/>
						</xsl:attribute>
						
						<xsl:call-template name="actualPrintSectionAndDownStructure">
							<xsl:with-param name="thePrintingTemplate" select="$thePrintingTemplate"
							/>
						</xsl:call-template>
					</xsl:element>
				</xsl:if>
			</xsl:when>
			<xsl:when
				test="$isItalic = 'no' and $makeSegmentNeutral = 'yes' and $thePrintingClass != '' ">
				<xsl:choose>
					<xsl:when test="contains(@display-inline, 'yes')">
						<xsl:element name="span">
							<xsl:attribute name="class">
								<xsl:value-of select="$neutralBlockClassName"/>
							</xsl:attribute>
							<xsl:element name="span">
								<xsl:attribute name="class">
									<xsl:value-of select="$thePrintingClass"/>
								</xsl:attribute>
								
								<xsl:call-template name="actualPrintSectionAndDownStructure">
									<xsl:with-param name="thePrintingTemplate" select="$thePrintingTemplate"
									/>
								</xsl:call-template>
							</xsl:element>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:element name="div">
							<xsl:attribute name="class">
								<xsl:value-of select="$neutralBlockClassName"/>
							</xsl:attribute>
						<xsl:element name="div">
								<xsl:attribute name="class">
									<xsl:value-of select="$thePrintingClass"/>
								</xsl:attribute>
								
								<xsl:call-template name="actualPrintSectionAndDownStructure">
									<xsl:with-param name="thePrintingTemplate" select="$thePrintingTemplate"
									/>
								</xsl:call-template>
							</xsl:element>
						</xsl:element>

						</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
            <xsl:when
				test="$isItalic = 'no' and $makeSegmentNeutral = 'yes' and $thePrintingClass != '' and contains(@display-inline, 'yes')">
				<xsl:choose>
					<xsl:when test ="contains(parent::resolution-body/section[1]/@display-inline, 'yes')">
						<xsl:element name="div">
							<xsl:attribute name="class">
								<xsl:value-of select="$neutralBlockClassName"/>
							</xsl:attribute>
							<xsl:element name="div">
								<xsl:attribute name="class">
									<xsl:value-of select="$thePrintingClass"/>
								</xsl:attribute>
								<xsl:call-template name="actualPrintSectionAndDownStructure">
									<xsl:with-param name="thePrintingTemplate" select="$thePrintingTemplate"/>
								</xsl:call-template>
							</xsl:element>
						</xsl:element>	
					</xsl:when>
					<xsl:otherwise>
						<xsl:element name="span">
							<xsl:attribute name="class">
								<xsl:value-of select="$neutralInlineClassName"/>
							</xsl:attribute>
							<xsl:element name="span">
								<xsl:attribute name="class">
									<xsl:value-of select="$thePrintingClass"/>
								</xsl:attribute>
								<xsl:call-template name="actualPrintSectionAndDownStructure">
									<xsl:with-param name="thePrintingTemplate" select="$thePrintingTemplate"/>
								</xsl:call-template>
							</xsl:element>
						</xsl:element>	
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when
				test="$isItalic = 'no' and $makeSegmentNeutral = 'yes' and $thePrintingClass = ''">
				<xsl:choose>
					<xsl:when test="contains(@display-inline, 'yes')">
						<xsl:attribute name="class">
							<xsl:value-of select="$neutralBlockClassName"/>
						</xsl:attribute>
						<xsl:call-template name="actualPrintSectionAndDownStructure">
							<xsl:with-param name="thePrintingTemplate" select="$thePrintingTemplate"/>
							</xsl:call-template>
					</xsl:when>
				<xsl:otherwise>
						<xsl:element name="div">
							<xsl:attribute name="class">
								<xsl:value-of select="$neutralInlineClassName"/>
							</xsl:attribute>
							<!--<xsl:attribute name="class">noneTextDecorationInline</xsl:attribute>-->
							<xsl:call-template name="actualPrintSectionAndDownStructure">
								<xsl:with-param name="thePrintingTemplate" select="$thePrintingTemplate"/>
							</xsl:call-template>
						</xsl:element>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="actualPrintSectionAndDownStructure">
					<xsl:with-param name="thePrintingTemplate" select="$thePrintingTemplate"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template match="section">
		<!-- TB Aug-2016 changed bug fixing #1434 -->

		<xsl:choose>
			<xsl:when test="$amendType = 'engrossed-amendment' and @section-type = 'resolved'">
				<!-- Nothing - already printed -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="printSectionAndDownStructure">
					<xsl:with-param name="thePrintingTemplate">displaySection</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
			<!--xsl:when test="@reported-display-style='boldface-roman'">
				<span class="lbexSectionlevelOLCBold">
					<xsl:call-template name="displaySection"/>
				</span>
			</xsl:when>
			<xsl:when
				test="@reported-display-style='boldface-italic' or
		ancestor::*[@reported-display-style='boldface-italic']">
				<i class="lbexTextNeutral">
					<span class="lbexSectionlevelOLCBold">
						<xsl:call-template name="displaySection"/>
					</span>
				</i>
			</xsl:when>
			<xsl:when
				test="@deleted-display-style='strikethrough' or
		@reported-display-style='strikethrough'">
				<span class="lbexTextStrikethrough">
					<xsl:call-template name="displaySection"/>
				</span>
			</xsl:when>
			<xsl:when test="@added-display-style='italic' or @reported-display-style='italic'">
				
					<i class="lbexTextNeutral">
						<xsl:call-template name="displaySection"/>
					</i>
				
			</xsl:when>
			<xsl:when test="(@changed='not-changed' or (ancestor::*/@changed='not-changed' and not (@changed)) ) and @display-inline='yes-display-inline'">
				<xsl:choose>
					<xsl:when test="ancestor-or-self::*[@changed='not-changed']/ancestor::*[@reported-display-style='stikethrough' or @reported-display-style='italic']">
						<span class="lbexTextNeutral">
							<xsl:call-template name="displaySection"/>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="displaySection"/>
					</xsl:otherwise>
				</xsl:choose>		
			</xsl:when>
			<xsl:when test="@changed='not-changed' or (ancestor::*/@changed='not-changed' and not (@changed))  ">
				<xsl:choose>
					<xsl:when test="ancestor-or-self::*[@changed='not-changed']/ancestor::*[@reported-display-style='stikethrough' or @reported-display-style='italic']">
						<div class="lbexTextNeutral">
							<xsl:call-template name="displaySection"/>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="displaySection"/>
					</xsl:otherwise>
				</xsl:choose>		
				
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="ancDisplayStyle">
					<xsl:call-template name="getAncDisplayStyle"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$ancDisplayStyle='italic'">						
							<i class="lbexTextNeutral">
								<xsl:call-template name="displaySection"/>
							</i>						
					</xsl:when>
					<xsl:when test="$ancDisplayStyle='strikethrough'">
						<span class="lbexTextStrikethrough">
							<xsl:call-template name="displaySection"/>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="displaySection"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise-->
		</xsl:choose>
	</xsl:template>

	<!--**************** Match Enum************************** -->
	<xsl:template match="enum">
		<xsl:choose>
			<xsl:when
				test="child::deleted-phrase and (parent::subsection or parent::paragraph or parent::subparagraph or parent::item or parent::subitem or parent::clause or parent::subclause)">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when
				test="child::added-phrase and (parent::subsection or parent::paragraph or parent::subparagraph or parent::item or parent::subitem or parent::clause or parent::subclause)">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="displayEnum"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- **************** Display Enum************************** -->
	<xsl:template name="displayEnum">
		<xsl:variable name="currElementStyle">
			<xsl:call-template name="getCurrentElementStyle"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when
				test="local-name(parent::*) = 'committee-report-part' or local-name(parent::*) = 'committee-report-title'">
				<!-- will be applied only in case if not header following. If yes it will be printed in the header template -->
				<xsl:if test="not(following-sibling::header)">
					<xsl:value-of select="translate(., $lower, $upper)"/>
				</xsl:if>
			</xsl:when>
			<!--***********************Display Enum Section****************************-->
			<xsl:when test="parent::section">
				<xsl:call-template name="displayEnumSection">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<!--************* Display Enum Title **********************************-->
			<xsl:when test="parent::title">
				<xsl:call-template name="displayEnumTitle">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<!-- ******************** Display Subtitle Enum ******************************** -->
			<xsl:when test="parent::subtitle">
				<xsl:call-template name="displayEnumSubtitle">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<!-- ********* Display Chapter Enum ************************ -->
			<xsl:when test="parent::chapter">
				<xsl:call-template name="displayEnumChapter">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<!--**************************** Display Subchapter Enum******************* -->
			<xsl:when test="parent::subchapter">
				<xsl:call-template name="displayEnumSubchapter">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<!-- ************************* Display Enum Part**************************** -->
			<xsl:when test="parent::part">
				<xsl:call-template name="displayEnumPart">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<!-- *********** Display Enum Subpart ******************************** -->
			<xsl:when test="parent::subpart">
				<xsl:call-template name="displayEnumSubpart">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>

			<!-- *********** Display Enum Division*********************************** -->
			<xsl:when test="parent::division">
				<!-- TB 31Aug2007 #685-->
				<xsl:call-template name="displayEnumDivision">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>

			<!-- ***********Display Subdivision ********************************* -->
			<xsl:when test="parent::subdivision">
				<xsl:call-template name="displayEnumSubdivision">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when
				test="ancestor::*[@reported-display-style = 'boldface-roman']/parent::quoted-block[@style = 'tax']">
				<span class="lbexSectionlevelOLCBold">
					<xsl:value-of select="."/>
					<xsl:text> </xsl:text>
				</span>
			</xsl:when>
			<xsl:when test="parent::amendment-instruction">
				<p/>
				<xsl:value-of select="."/>
				<xsl:text> </xsl:text>
			</xsl:when>
			<xsl:when test="parent::rule">
				<xsl:call-template name="displayEnumRule">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="contains(local-name(parent::*), 'rules')">
				<xsl:call-template name="displayEnumRules">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if
					test="not(preceding-sibling::*) and (contains(local-name(..), 'committee-report-'))">
					<br/>
				</xsl:if>
				<xsl:value-of select="."/>
				<xsl:if
					test="local-name(following-sibling::*[1]) = 'text' or local-name(following-sibling::*[1]) = 'header'">
					<xsl:text> </xsl:text>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="displayEnumRules">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:if
			test="ancestor::quoted-block and not(parent::*/@display-inline = 'yes-display-inline')">
			<xsl:call-template name="openQuotes"/>
		</xsl:if>
		<xsl:value-of select="."/>
		<xsl:if
			test="local-name(following-sibling::*[1]) = 'text' or local-name(following-sibling::*[1]) = 'header'">
			<xsl:text> </xsl:text>
		</xsl:if>
	</xsl:template>

	<!-- ***********Display Enum For Rule ********************** -->
	<xsl:template name="displayEnumRule">
		<xsl:param name="aCurrElementStyle"/>
		<div style="text-align:center" class="lbexTitleLevelTradEx">
			<xsl:if test="ancestor::quoted-block">
				<xsl:call-template name="openQuotes"/>
			</xsl:if>
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<!-- ***********Display Enum For Section ********************** -->
	<xsl:template name="displayEnumSection">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when
				test="(contains(ancestor::*/@reported-display-style, 'brackets')  ) or ancestor::*[@commented = 'yes']">
				<xsl:choose>
					<xsl:when test="$billType ='appropriations'" >
						<xsl:choose>
							<xsl:when test= "$aCurrElementStyle ='appropriations'">
								<xsl:call-template name="openBracketStyles"/>	
							</xsl:when>
							<xsl:otherwise>
								
							</xsl:otherwise>
							
						</xsl:choose>
						
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="openBracketStyles"/>	
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when
				test="contains(ancestor::*/@reported-display-style, 'parentheses')">
				<xsl:call-template name="openParenStyles"/>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when
				test="parent::section/parent::constitution-article/parent::quoted-block/@style = 'traditional' or parent::section/parent::constitution-article/parent::quoted-block/@style = 'traditional' or parent::section/parent::constitution-article/parent::quoted-block/@style = 'appropriations'">
				<!--xsl:text>“</xsl:text-->
				<!-- commented by TB 10Sep2007 #716 -->
				<!-- reopened by TB 9Jun2008 -->
				<xsl:call-template name="openQuotes"/>
				<span class="lbexInitialCapTrad">
					<!-- TB Aug-2016 Bug Fixing #1436 -->
					<xsl:call-template name="createAnchorParent"/>
					<!--span class="initialcap"-->
					<!--xsl:text>section </xsl:text-->
					<xsl:call-template name="ActualPrintIChangedTextWithParam">
						<xsl:with-param name="aTheTextToPrint">
							<xsl:text>section </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<!--/span-->
					<!-- <xsl:value-of select="."/> -->
					<xsl:apply-templates/>
					<xsl:text> </xsl:text>
				</span>
			</xsl:when>
			<xsl:when
				test="
					parent::section[@section-type = 'section-one']/parent::legis-body[@added-display-style = 'boldface-roman'] or
					parent::section[@section-type = 'section-one']/parent::legis-body[@reported-display-style = 'boldface-roman']">
				<!-- TB Aug-2016 Bug Fixing #1436 -->
				<xsl:call-template name="createAnchorParent"/>
				<span class="lbexSectionlevelOLCBold">
					<xsl:text>SECTION </xsl:text>
					<!-- TB 19May2008 -->
					<!--xsl:value-of select="."/-->
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="(string(parent::section/@section-type) = 'section-one')">
				<xsl:choose>
					<xsl:when
						test="
							ancestor::*[@reported-display-style = 'boldface-roman']
							or ancestor::*[@reported-display-style = 'boldface-italic']">
						<!-- TB Aug-2016 Bug Fixing #1436 -->
						<xsl:call-template name="createAnchorParent"/>
						<span class="lbexSectionlevelOLCBold">
							<xsl:text>SECTION </xsl:text>
							<!-- TB 19May2008 -->
							<!--xsl:value-of select="."/-->
							<xsl:apply-templates/>
						</span>
						<xsl:text> </xsl:text>
					</xsl:when>
					<!--xsl:when
						test="(not(ancestor::quoted-block) and $billType='traditional') or
						(parent::section and ancestor::resolution-body[@style='traditional'])"-->
					<xsl:when
						test="not(ancestor::quoted-block) and (contains($aCurrElementStyle, 'traditional') or $aCurrElementStyle = 'appropriations')">
						<span class="lbexInitialCapTrad">
							<xsl:call-template name="createAnchorParent"/>
							<xsl:text>section </xsl:text>
							<!-- TB 19May2008 -->
							<!--xsl:value-of select="."/-->
							<xsl:apply-templates/>
						</span>
					</xsl:when>
					<!--change 12/28/05-->
					<!-- TB 30Aug2007 #671 added stages Received-in-Senate and  Reported-in-House for resolutions to show SECTION 1 in case of relevant element and attr section - section-one is there -->
					<!-- TB added removing tax style -->
					<xsl:when
						test="
							($billStage = 'Introduced-in-House' or $billStage = 'Engrossed-in-House' or
							$billStage = 'Received-in-Senate' or $billStage = 'Received-in-House' or
							$billStage = 'Referred-in-Senate' or $billStage = 'Referred-in-House' or
							$billStage = 'Engrossed-in-Senate' or $billStage = 'Reported-in-House' or $billStage = 'Pre-Introduction'
							or $resolutionStage = 'Introduced-in-House' or $resolutionStage = 'Introduced-in-Senate'
							or $billStage = 'Reported-in-Senate' or $billStage = 'Enrolled-Bill' or $billStage = 'Introduced-in-Senate' or
							$resolutionStage = 'Received-in-Senate' or $resolutionStage = 'Reported-in-House'
							or $resolutionStage = 'Enrolled-Bill' or $resolutionStage = 'Engrossed-in-House') and
							not(parent::*[@reported-display-style = 'boldface-italic'])">
						<xsl:if
							test="not(contains($aCurrElementStyle, 'traditional') or $aCurrElementStyle = 'constitutional-amendment')">
							<!-- TB Aug-2016 Bug Fixing #1436 -->
							<xsl:call-template name="createAnchorParent"/>
							<span class="lbexSectionlevelOLC">
								<!-- NB 2/27/2007 - Added for when the quoted block does not include a header -->
								<xsl:if test="ancestor::quoted-block and not(header)">
									<xsl:call-template name="openQuotes"/>
								</xsl:if>
								<xsl:text>SECTION </xsl:text>
								<!-- TB 19May2008 -->
								<!--xsl:value-of select="."/-->
								<xsl:apply-templates/>
							</span>
						</xsl:if>
						<xsl:if
							test="(contains($aCurrElementStyle, 'traditional') or $aCurrElementStyle = 'appropriations') or $aCurrElementStyle = 'constitutional-amendment'">
							<xsl:call-template name="createAnchorParent"/>
							<span class="lbexInitialCapTrad">
								<!-- NB 2/27/2007 - Added for when the quoted block does not include a header -->
								<xsl:if test="ancestor::quoted-block and not(header)">
									<xsl:call-template name="openQuotes"/>
								</xsl:if>
								<xsl:text>section </xsl:text>
								<!-- TB 19May2008 -->
								<!--xsl:value-of select="."/-->
								<xsl:apply-templates/>
							</span>
						</xsl:if>
						<xsl:text> </xsl:text>
					</xsl:when>
					<xsl:when test="$billStage = 'Introduced-in-Senate'">
						<span class="lbexInitialCapTrad">
							<xsl:call-template name="createAnchorParent"/>
							<xsl:text>section </xsl:text>
							<!-- TB 19May2008 -->
							<!--xsl:value-of select="."/-->
							<xsl:apply-templates/>
						</span>
						<xsl:text> </xsl:text>
					</xsl:when>
					<!-- TB 8Jan2008 Amendments support -->
					<xsl:when test="$aCurrElementStyle = 'traditional-inline'">
						<span class="lbexInitialCapTradInd">
							<xsl:call-template name="createAnchorParent"/>
							<xsl:text>section </xsl:text>
							<!-- TB 19May2008 -->
							<!--xsl:value-of select="."/-->
							<xsl:apply-templates/>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<!-- TB Aug-2016 Bug Fixing #1436 -->
						<xsl:call-template name="createAnchorParent"/>
						<span class="lbexSectionlevelOLC">
							<!--xsl:text>SECTION </xsl:text-->
							<xsl:call-template name="ActualPrintIChangedTextWithParam">
								<xsl:with-param name="aTheTextToPrint">
									<xsl:text>SECTION </xsl:text>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="ActualPrintIChangedText"/>
						</span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when
				test="(contains($aCurrElementStyle, 'traditional') or $aCurrElementStyle = 'appropriations') and text() != ''">
				<span class="lbexInitialCapTrad">
					<xsl:call-template name="createAnchorParent"/>
					<xsl:if test="ancestor::quoted-block">
						<xsl:call-template name="openQuotes"/>
					</xsl:if>
					<xsl:call-template name="ActualPrintIChangedTextWithParam">
						<xsl:with-param name="aTheTextToPrint">
							<xsl:text>Sec. </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:apply-templates/>
					<xsl:text> </xsl:text>
				</span>
			</xsl:when>
			<xsl:when test="$aCurrElementStyle = 'USC' and (text() != '' or child::*)">
				<!-- TB Aug-2016 Bug Fixing #1436 -->
				<xsl:call-template name="createAnchorParent"/>
				<span class="lbexSectionlevelOLCBold">
					<xsl:if test="ancestor::quoted-block">
						<xsl:call-template name="openQuotes"/>
					</xsl:if>
					<span class="lbexEnumUcs">
						<xsl:text>§ </xsl:text>
					</span>
					<!-- TB 3Jan2008 Bug #767 -->
					<!--xsl:value-of select="."/-->
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="string(parent::section/@section-type) = 'subsequent-section'">
				<xsl:choose>
					<!--xsl:when
						test="((not(ancestor::quoted-block) and $billType='traditional') or
						(parent::section and ancestor::resolution-body[@style='traditional']) and not (ancestor::quoted-block/descendant::quoted-block = ancestor::quoted-block and ancestor::quoted-block/descendant::quoted-block/@style!= 'traditional'))"-->

					<xsl:when
						test="
							ancestor::*[@reported-display-style = 'boldface-roman'] or
							ancestor::*[@reported-display-style = 'boldface-italic'] or
							not(ancestor::quoted-block) and not($billType = 'traditional') and
							(parent::section[@section-type = 'subsequent-section']/parent::legis-body[@added-display-style = 'boldface-roman'] or
							parent::section[@section-type = 'subsequent-section']/parent::legis-body[@reported-display-style = 'boldface-roman'] or
							parent::*[@reported-display-style = 'boldface-roman'] or
							parent::*[@added-display-style = 'boldface-roman']
							)
							">
						<!-- TB Aug-2016 Bug Fixing #1436 -->
						<xsl:call-template name="createAnchorParent"/>
						<span class="lbexSectionlevelOLCBold">
							<xsl:if test="ancestor::quoted-block">
								<xsl:call-template name="openQuotes"/>
							</xsl:if>
							<!--xsl:text>SEC. </xsl:text-->
							<xsl:call-template name="ActualPrintIChangedTextWithParam">
								<xsl:with-param name="aTheTextToPrint">
									<xsl:text>SEC. </xsl:text>
								</xsl:with-param>
							</xsl:call-template>
							<!-- TB 19May2008 -->
							<!--xsl:value-of select="."/-->
							<xsl:apply-templates/>
						</span>
					</xsl:when>
					<!--xsl:when
						test="(parent::section/ancestor::quoted-block[@other-style='nuclear']) or
						(parent::section and ancestor::quoted-block[@other-style='traditional-inline'])"-->
					<xsl:when
						test="$aCurrElementStyle = 'nuclear' or $aCurrElementStyle = 'traditional-inline'">
						<!-- TB Aug-2016 Bug Fixing #1436 -->
						<xsl:call-template name="createAnchorParent"/>
						<span class="lbexSectionLevelOLCnuclear">
							<!--xsl:if test="not(($billType='olc' and not(/bill/descendant::*/@idref=./@id)) or ($resolutionType='olc' and not(/resolution/descendant::*/@idref=./@id)) or (ancestor::quoted-block[1]/@style='OLC' )) "-->
							<xsl:if test="ancestor::quoted-block">
								<xsl:call-template name="openQuotes"/>
							</xsl:if>
							<!--/xsl:if-->
							<!--xsl:text>Sec. </xsl:text-->
							<xsl:call-template name="ActualPrintIChangedTextWithParam">
								<xsl:with-param name="aTheTextToPrint">
									<xsl:text>Sec. </xsl:text>
								</xsl:with-param>
							</xsl:call-template>
							<!-- TB 28Dec2007 Bug #767 -->
							<!--xsl:value-of select="."/-->
							<xsl:apply-templates/>
						</span>
					</xsl:when>
					<xsl:when
						test="(not(ancestor::quoted-block) and not($billType = 'traditional') and not($billType = 'appropriations') and not($aCurrElementStyle = 'traditional') and not(contains($aCurrElementStyle, 'archaic'))) or (ancestor::quoted-block and $aCurrElementStyle = 'defense')">
						<!-- TB Aug-2016 Bug Fixing #1436 -->
						<xsl:call-template name="createAnchorParent"/>
						<span class="lbexSectionlevelOLC">
							<!-- TB TODO put anhcors above the span to keep bold on enums -->
							<xsl:if test="ancestor::quoted-block">
								<xsl:call-template name="openQuotes"/>
							</xsl:if>
							<xsl:call-template name="ActualPrintIChangedTextWithParam">
								<xsl:with-param name="aTheTextToPrint">
									<xsl:text>SEC. </xsl:text>
								</xsl:with-param>
							</xsl:call-template>
							<!-- <xsl:value-of select="."/> -->
							<!-- Attempting to correct Bug #766 -->
							<xsl:apply-templates/>
						</span>
					</xsl:when>
					<!--xsl:when test="ancestor::quoted-block/@style='USC'"-->
					<xsl:when
						test="
							ancestor::legis-body/@added-display-style = 'boldface-roman' and
							(ancestor::quoted-block/@style = 'OLC' or ancestor::quoted-block/@style = 'tax')">
						<!-- TB Aug-2016 Bug Fixing #1436 -->
						<xsl:call-template name="createAnchorParent"/>
						<span class="lbexSectionlevelOLCBold">
							<!--xsl:call-template name="openQuotes"/-->
							<xsl:text>SEC. </xsl:text>
							<!-- TB 19May2008 -->
							<!--xsl:value-of select="."/-->
							<xsl:apply-templates/>
						</span>
					</xsl:when>

					<!--xsl:when test="ancestor::quoted-block[1]/@style='tax'"-->
					<xsl:when test="$aCurrElementStyle = 'tax'">
						<!--xsl:if test="not(($billType='olc' and not(/bill/descendant::*/@idref=./@id)) or ($resolutionType='olc' and not(/resolution/descendant::*/@idref=./@id)) or (ancestor::quoted-block[1]/@style='OLC' ))"-->
						<!-- TB Aug-2016 Bug Fixing #1436 -->
						<xsl:call-template name="createAnchorParent"/>
						<span class="lbexSectionlevelOLC">
							<xsl:if test="ancestor::quoted-block">
								<xsl:call-template name="openQuotes"/>
							</xsl:if>
							<!--/xsl:if-->

							<!--xsl:text>SEC. </xsl:text-->
							<xsl:call-template name="ActualPrintIChangedTextWithParam">
								<xsl:with-param name="aTheTextToPrint">
									<xsl:text>SEC. </xsl:text>
								</xsl:with-param>
							</xsl:call-template>
							<!-- TB 28Dec2007 bug #767 -->
							<!--xsl:value-of select="."/-->
							<xsl:apply-templates/>
						</span>
					</xsl:when>
					<!-- TB 2Jan2008 bug #767 -->
					<xsl:when
						test="$aCurrElementStyle = 'traditional' or contains($aCurrElementStyle, 'archaic')">
						<!-- TB Aug-2016 Bug Fixing #1436 -->
						<xsl:call-template name="createAnchorParent"/>
						<span class="lbexSectionLevelOLCnuclear">
							<xsl:if test="ancestor::quoted-block">
								<xsl:call-template name="openQuotes"/>
							</xsl:if>
							<xsl:call-template name="ActualPrintIChangedTextWithParam">
								<xsl:with-param name="aTheTextToPrint">
									<xsl:text>Sec. </xsl:text>
								</xsl:with-param>
							</xsl:call-template>
						</span>
						<xsl:apply-templates/>
					</xsl:when>
					<!--xsl:when test="ancestor::quoted-block/@style='OLC'"-->
					<xsl:when test="$aCurrElementStyle = 'OLC'">
						<!--xsl:call-template name="openQuotes"/-->
						<!-- TB 18-Sep-2008 Fix no quoted block near section enum -->
						<!-- TB Aug-2016 Bug Fixing #1436 -->
						<xsl:call-template name="createAnchorParent"/>
						<span class="lbexSectionlevelOLC">
							<xsl:if test="ancestor::quoted-block">
								<xsl:call-template name="openQuotes"/>
							</xsl:if>
							<!--xsl:text>SEC. </xsl:text-->
							<xsl:call-template name="ActualPrintIChangedTextWithParam">
								<xsl:with-param name="aTheTextToPrint">
									<xsl:text>SEC. </xsl:text>
								</xsl:with-param>
							</xsl:call-template>
							<!-- <xsl:value-of select="."/> -->
							<!-- Attempting to correct Bug #766. nvargish 2007-11-07 -->
							<xsl:apply-templates/>
							<!-- TB Dec 2010 added space -->
							<xsl:if
								test="local-name(following-sibling::*[1]) = 'text' or local-name(following-sibling::*[1]) = 'header'">
								<xsl:text> </xsl:text>
							</xsl:if>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- TB 28Feb2008 Bug #864 covers all other cases of section in enum -->
			<xsl:when test="text() != ''">
				<!-- TB Aug-2016 Bug Fixing #1436 -->
				<xsl:call-template name="createAnchorParent"/>
				<span class="lbexSectionlevelOLC">
					<!-- TB 27-Jan-2012 Create Anchor in this case also - to cover all cases of section display-->
					<xsl:if test="ancestor::quoted-block">
						<xsl:call-template name="openQuotes"/>
					</xsl:if>
					<xsl:call-template name="ActualPrintIChangedTextWithParam">
						<xsl:with-param name="aTheTextToPrint">
							<xsl:text>SEC. </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:apply-templates/>
					<xsl:text> </xsl:text>
				</span>
			</xsl:when>
		</xsl:choose>

	</xsl:template>

	<!-- ****************** Display Enum Title ********************* -->
	<xsl:template name="displayEnumTitle">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when
				test="$billType = 'traditional' and parent::title[@reported-display-style = 'boldface-roman']">
				<span class="lbexTitleLevelTradBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>TITLE </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
				</span>
			</xsl:when>
			<!--xsl:when
				test="(($billType='traditional' or ancestor::quoted-block/@style='traditional') and parent::title) or
				(ancestor::quoted-block[@style='other' and @other-style='archaic'] and parent::title) or
				(ancestor::quoted-block[@style='other' and @other-style='traditional-inline'] and parent::title) or
				(ancestor::quoted-block[@style='other' and @other-style='archaic-paragraph'] and parent::title)
				"-->
			<xsl:when
				test="contains($aCurrElementStyle, 'traditional') or contains($aCurrElementStyle, 'archaic') or $aCurrElementStyle = 'appropriations'">
				<xsl:choose>
				<xsl:when test="contains(parent::title/@reported-display-style, 'brackets')">
					<span class="lbexBrakets">
						<xsl:text>[</xsl:text>
					</span>
						<span class="lbexTitleLevelTrad">
							<xsl:call-template name="ActualPrintHeadingOf">
								<xsl:with-param name="aTextToAdd">
									<xsl:text>TITLE </xsl:text>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="child::deleted-phrase or child::added-phrase">
								<xsl:apply-templates/>
							</xsl:if>
					</span>
				</xsl:when>
					<xsl:otherwise>
						<span class="lbexTitleLevelTrad">
							<xsl:call-template name="ActualPrintHeadingOf">
								<xsl:with-param name="aTextToAdd">
									<xsl:text>TITLE </xsl:text>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="child::deleted-phrase or child::added-phrase">
								<xsl:apply-templates/>
							</xsl:if>
						</span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when
				test="
					ancestor::legis-body/@style = 'USC' or
					ancestor::quoted-block[@style = 'USC']">
				<span class="lbexTitleLevelOLC">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>TITLE </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:when test="(parent::title/ancestor::quoted-block[@style = 'USC'])">
				<span class="lbexTitleLevelOLC">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>TITLE </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="(parent::title/ancestor::quoted-block[@style = 'tax'])">
				<span class="lbexTitleLevelIRCEx">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>TITLE </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="(parent::title/ancestor::quoted-block[@style = 'OLC']) and //committee-report">
				<xsl:if test="text() != ''">
					<span class="lbexTitleLevelOLC">
						<xsl:call-template name="ActualPrintHeadingOf">
							<xsl:with-param name="aTextToAdd">
								<xsl:text>TITLE </xsl:text>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="child::deleted-phrase or child::added-phrase">
							<xsl:apply-templates/>
						</xsl:if>
					</span>
				</xsl:if>
			</xsl:when>
			<xsl:when test="//committee-report">
				<xsl:if test="text() != ''">
					<span class="lbexPartlevelTrad">
						<xsl:call-template name="ActualPrintHeadingOf">
							<xsl:with-param name="aTextToAdd">
								<xsl:text>TITLE </xsl:text>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="child::deleted-phrase or child::added-phrase">
							<xsl:apply-templates/>
						</xsl:if>
					</span>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="text() != '' or child::*">
					<span class="lbexTitleLevelOLC">
						<xsl:call-template name="ActualPrintHeadingOf">
							<xsl:with-param name="aTextToAdd">
								<xsl:text>TITLE </xsl:text>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="child::deleted-phrase or child::added-phrase">
							<xsl:apply-templates/>
						</xsl:if>
					</span>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ********************Display Subtitle Enum*************** -->
	<xsl:template name="displayEnumSubtitle">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when
				test="contains($aCurrElementStyle, 'traditional') or contains($aCurrElementStyle, 'archaic') or $aCurrElementStyle = 'appropriations'">
				<span class="lbexSubTitleLevelTrad">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subtitle </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="$billType = 'traditional' and parent::subtitle[@reported-display-style = 'boldface-roman']">
				<span class="lbexSubTitleLevelTrad">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subtitle </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="parent::subtitle[@reported-display-style = 'boldface-roman']">
				<span class="lbexSubTitleLevelOLCBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subtitle </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="
					(parent::subtitle[@reported-display-style = 'boldface-italic']/ancestor::quoted-block[@style = 'tax']) or
					ancestor::*[@reported-display-style = 'boldface-italic'] and ancestor::quoted-block[@style = 'tax']">
				<span class="lbexSubTitleLevelIRCBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subtitle </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="ancestor::quoted-block/@style = 'tax'">
				<span class="lbexSubTitleLevelOLC">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subtitle </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexSubTitleLevelOLC">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subtitle </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ********************Display Part Enum*************** -->
	<xsl:template name="displayEnumPart">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when
				test="$billType = 'traditional' and parent::part[@reported-display-style = 'boldface-roman']">
				<span class="lbexTitleLevelTradBold">
					<xsl:if test="ancestor::quoted-block">
						<xsl:call-template name="openQuotes"/>
					</xsl:if>
					<xsl:value-of select="translate('part ', $lower, $upper)"/>
					<xsl:value-of select="translate(., $lower, $upper)"/>
				</span>
			</xsl:when>
			<!--xsl:when
				test="($billType='traditional' or ancestor::quoted-block/@style='traditional') or
				ancestor::quoted-block[@style='other' and @other-style='archaic']  or
				ancestor::quoted-block[@style='other' and @other-style='traditional-inline']  or
				ancestor::quoted-block[@style='other' and @other-style='archaic-paragraph'] "-->
			<xsl:when
				test="contains($aCurrElementStyle, 'traditional') or contains($aCurrElementStyle, 'archaic') or $aCurrElementStyle = 'appropriations'">
				<span class="lbexPartlevelTrad">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>Part </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="ancestor::legis-body/@style = 'USC'">
				<span class="lbexSectionlevelOLCBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>PART </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="
					(parent::part[@reported-display-style = 'boldface-roman'] and ancestor::quoted-block[@style = 'tax']) or
					parent::part/parent::quoted-block[@style = 'tax']/ancestor::*[@reported-display-style = 'boldface-roman']">
				<span class="lbexChapterLevelOLCBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>PART </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="parent::part[@reported-display-style = 'boldface-roman']">
				<span class="lbexChapterLevelOLCBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>PART </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="(parent::part/ancestor::quoted-block[@style = 'USC'])">
				<span class="lbexSectionlevelOLCBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>PART </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="
					(parent::part[@reported-display-style = 'boldface-italic']/ancestor::quoted-block[@style = 'tax']) or
					(parent::part and ancestor::*[@reported-display-style = 'boldface-italic'] and ancestor::quoted-block[@style = 'tax'])">
				<span class="lbexChapterLevelOLCBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>PART </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="(parent::part/ancestor::quoted-block[@style = 'tax'])">
				<span class="lbexSectionlevelOLCBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>PART </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexSectionlevelOLCBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>PART </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ********************Display SubPart Enum*************** -->
	<xsl:template name="displayEnumSubpart">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when
				test="$billType = 'traditional' and parent::subpart[@reported-display-style = 'boldface-roman']">
				<span class="lbexSubPartLevelTradBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subpart </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<!--xsl:when
				test="($billType='traditional' or ancestor::quoted-block/@style='traditional')  or
				ancestor::quoted-block[@style='other' and @other-style='archaic']  or
				ancestor::quoted-block[@style='other' and @other-style='traditional-inline']  or
				ancestor::quoted-block[@style='other' and @other-style='archaic-paragraph'] "-->
			<xsl:when
				test="contains($aCurrElementStyle, 'traditional') or contains($aCurrElementStyle, 'archaic') or $aCurrElementStyle = 'appropriations'">
				<span class="lbexSubTitleLevelTrad">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subpart </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="parent::subpart[@reported-display-style = 'boldface-roman']">
				<span class="lbexSubTitleLevelOLCBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subpart </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="
					ancestor::quoted-block[@style = 'tax']/ancestor::*[@reported-display-style = 'boldface-roman']
					or ancestor::*[@reported-display-style = 'boldface-italic'] and ancestor::quoted-block[@style = 'tax']">
				<span class="lbexSubTitleLevelOLCBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subpart </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="ancestor::quoted-block/@style = 'tax'">
				<span class="lbexSubpartLevelOLC">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subpart </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexSubpartLevelOLC">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subpart </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ********************Display Chapter Enum*************** -->
	<xsl:template name="displayEnumChapter">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when test="ancestor::*[@reported-display-style = 'boldface-italic']">
				<span class="lbexChapterLevelOLCBold">
					<xsl:call-template name="openQuotes"/>
					<xsl:value-of select="translate('chapter ', $lower, $upper)"/>
					<xsl:value-of select="translate(., $lower, $upper)"/>
				</span>
			</xsl:when>
			<xsl:when test="ancestor::quoted-block/@style = 'tax'">
				<span class="lbexChapterLevelOLC">
					<xsl:call-template name="openQuotes"/>
					<xsl:value-of select="translate('chapter ', $lower, $upper)"/>
					<xsl:value-of select="translate(., $lower, $upper)"/>
				</span>
			</xsl:when>
			<xsl:when
				test="($billType = 'traditional' and parent::chapter[@reported-display-style = 'boldface-roman'])">
				<span class="lbexSubChapterLevelOLC">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>chapter </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="$aCurrElementStyle = 'traditional'">
				<span class="lbexChapterLevelTrad">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>chapter </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="$aCurrElementStyle = 'traditional-inline' or $aCurrElementStyle = 'appropriations'">
				<span class="lbexTitleLevelTradEx">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>chapter </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="(parent::chapter/ancestor::quoted-block[@other-style = 'nuclear'])">
				<span class="lbexChapterLevelOLCNuclear">
					<xsl:call-template name="openQuotes"/>
					<xsl:text>CHAPTER </xsl:text>
					<xsl:value-of select="."/>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="ancestor::legis-body/@style = 'USC'">
				<span class="lbexSectionlevelOLCBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>CHAPTER </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="parent::chapter[@reported-display-style = 'boldface-roman']">
				<span class="lbexChapterLevelOLCBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>CHAPTER </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="(parent::chapter/ancestor::quoted-block[@style = 'USC'])">
				<span class="lbexSectionlevelOLCBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>CHAPTER </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexChapterLevelOLC">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>CHAPTER </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ********************Display Subchapter Enum*************** -->
	<xsl:template name="displayEnumSubchapter">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when
				test="($billType = 'traditional' and parent::subchapter[@reported-display-style = 'boldface-roman'])">
				<span class="lbexSubChapterLevelTradBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subchapter </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<!--xsl:when
				test="ancestor::quoted-block[@style='other' and @other-style='traditional-inline']  or
				ancestor::quoted-block[@style='other' and @other-style='archaic-paragraph'] "-->
			<xsl:when test="$aCurrElementStyle = 'archaic-paragraph'">
				<span class="lbexSubChapterLevelTradInline">
					<xsl:if test="ancestor::quoted-block">
						<xsl:call-template name="openQuotes"/>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="$aCurrElementStyle = 'archaic-paragraph'">
							<xsl:text>SUBCHAPTER </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>subchapter </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<!-- TB 19May2008 -->
					<!--xsl:value-of select="."/-->
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<!--xsl:when
				test="$billType='olc' and ancestor::quoted-block/@style='traditional' or
				$billType='traditional' or
				($billType='olc' and ancestor::quoted-block/@other-style='archaic') "-->
			<xsl:when
				test="
					ancestor::quoted-block/@style = 'traditional' or
					$documentType = 'traditional' or
					(ancestor::quoted-block/@other-style = 'archaic')">
				<span class="lbexSubChapterLevelTrad">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>SUBCHAPTER </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="($billType = 'traditional' and ancestor::quoted-block/@style = 'OLC')">
				<span class="lbexSubChapterLevelOLC">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subchapter </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="
					(parent::subchapter[@reported-display-style = 'boldface-roman'] and ancestor::quoted-block[@style = 'tax']) or
					parent::subchapter/parent::quoted-block[@style = 'tax']/ancestor::*[@reported-display-style = 'boldface-roman']
					or (parent::subchapter and ancestor::*[@reported-display-style = 'boldface-italic'])">
				<span class="lbexSubTitleLevelOLCBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subchapter </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="ancestor::quoted-block/@style = 'tax'">
				<span class="lbexSubChapterLevelOLC">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subchapter </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="parent::subchapter and ancestor::quoted-block/@other-style = 'nuclear'">
				<span class="lbexSubChapterLevelOLC">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subchapter </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="ancestor::legis-body/@style = 'USC'">
				<span class="lbexSectionLevelTradBold">
					<xsl:if test="ancestor::quoted-block">
						<xsl:call-template name="openQuotes"/>
					</xsl:if>
					<xsl:text>SUBCHAPTER </xsl:text>
					<!--xsl:value-of select="translate(.,$lower,$upper)"/-->
					<style type="text-transform:uppercase;">
						<xsl:apply-templates/>
					</style>
				</span>
			</xsl:when>
			<xsl:when test="parent::subchapter[@reported-display-style = 'boldface-roman']">
				<span class="lbexSubTitleLevelOLCBold">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subchapter </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="parent::subchapter/ancestor::quoted-block[@style = 'USC']">
				<span class="lbexSectionLevelTradBold">
					<xsl:if test="ancestor::quoted-block">
						<xsl:call-template name="openQuotes"/>
					</xsl:if>
					<xsl:text>SUBCHAPTER </xsl:text>
					<!--xsl:value-of select="translate(.,$lower,$upper)"/-->
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="$aCurrElementStyle = 'traditional'">
				<span class="lbexSubChapterLevelTradEx">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subchapter </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="$aCurrElementStyle = 'traditional-inline' or $aCurrElementStyle = 'appropriations'">
				<span class="lbexSubTitleLevelTrad">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subchapter </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexSubChapterLevelOLC">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>subchapter </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--******************* Display Enum Subdivision********************************** -->
	<xsl:template name="displayEnumSubdivision">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when
				test="$aCurrElementStyle = 'OLC' or $aCurrElementStyle = 'USC' or $aCurrElementStyle = 'tax'">
				<span class="lbexTitleLevelOLC">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>SUBDIVISION </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="$aCurrElementStyle = 'traditional-inline' or $aCurrElementStyle = 'appropriations'">
				<span class="lbexSubChapterLevelOLC">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>Subdivision </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="child::deleted-phrase or child::added-phrase">
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexInitialCapArchaic">
					<xsl:call-template name="ActualPrintHeadingOf">
						<xsl:with-param name="aTextToAdd">
							<xsl:text>Subdivision </xsl:text>
						</xsl:with-param>
					</xsl:call-template>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ************* Actual Print Heading with opening quotes if needed ********************-->
	<xsl:template name="ActualPrintHeadingOf">
		<xsl:param name="aTextToAdd"/>

		<xsl:variable name="theTextToPrint">
			<xsl:if test="ancestor::quoted-block">
				<xsl:call-template name="openQuotes"/>
			</xsl:if>
			<xsl:if test="contains(ancestor::quoted-block/@reported-display-style,'brackets')">
				<xsl:call-template name="openBracketStyles"/>
			</xsl:if>
			<xsl:value-of select="$aTextToAdd"/>
			<xsl:if test="not(child::deleted-phrase or child::added-phrase)">
				<xsl:value-of select="."/>
			</xsl:if>
		</xsl:variable>

		<xsl:call-template name="ActualPrintIChangedTextWithParam">
			<xsl:with-param name="aTheTextToPrint" select="$theTextToPrint"/>
		</xsl:call-template>
	</xsl:template>

	<!-- *************** Match Header ****************************** -->
	<xsl:template match="header">
		<xsl:param name="isSpecialPrinting"/>
		<xsl:choose>
			<xsl:when
				test="parent::toc and not(//committee-report) and following-sibling::multi-column-toc-entry">
				<!-- nothing -->
			</xsl:when>
			<xsl:when
				test="parent::appropriations-major or parent::appropriations-intermediate or parent::appropriations-small">
				<xsl:call-template name="displayHeader"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="displayHeader">
					<xsl:with-param name="isSpecialPrinting" select="$isSpecialPrinting"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ***********************Display Committee Report Header***************************** -->
	<xsl:template match="committee-report-header">
		<xsl:call-template name="displayCommitteeReportHeader"/>
	</xsl:template>
	<!-- *********************** Actual Display Committee Report Header*********************** -->
	<xsl:template name="displayCommitteeReportHeader">
		<xsl:variable name="currElementStyle">
			<xsl:call-template name="getCurrentElementStyle"/>
		</xsl:variable>

		<xsl:variable name="isMarginIndent">
			<xsl:value-of select="@margin-indent"/>
		</xsl:variable>
		<xsl:variable name="isDisplayInline">
			<xsl:choose>
				<xsl:when test="@display-inline">
					<xsl:value-of select="@display-inline"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no-display-inline</xsl:text>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:variable>

		<xsl:variable name="isFollowingDisplayinline">
			<xsl:choose>
				<xsl:when test="following-sibling::text and following-sibling::text/@display-inline">
					<xsl:value-of select="following-sibling::text/@display-inline"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no-display-inline</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when
				test="$isDisplayInline = 'yes-display-inline' and $isMarginIndent != 'yes' and $isFollowingDisplayinline = 'yes-display-inline'">
				<span style="text-align:left; text-indent: 1em;display:inline-block;">
					<xsl:call-template name="actualPrintCommitteeReportHeader"/>
				</span>
				<xsl:text>&#160;</xsl:text>
			</xsl:when>
			<xsl:when
				test="$isDisplayInline = 'yes-display-inline' and $isMarginIndent != 'yes' and $isFollowingDisplayinline = 'no-display-inline'">
				<span style="text-align:left;">
					<xsl:call-template name="actualPrintCommitteeReportHeader"/>
				</span>
			</xsl:when>
			<xsl:when
				test="$isDisplayInline = 'yes-display-inline' and $isMarginIndent = 'yes' and $isFollowingDisplayinline = 'no-display-inline'">
				<p class="lbexIndent" style="text-align:left">
					<xsl:call-template name="actualPrintCommitteeReportHeader"/>
				</p>
			</xsl:when>
			<xsl:when
				test="$isDisplayInline = 'yes-display-inline' and $isMarginIndent = 'yes' and $isFollowingDisplayinline = 'yes-display-inline'">
				<!-- add indent class to the parent paragraph -->
				<xsl:attribute name="class">
					<xsl:text>lbexIndent</xsl:text>
				</xsl:attribute>
				<xsl:call-template name="actualPrintCommitteeReportHeader"/>
			</xsl:when>
			<xsl:when test="$isDisplayInline != 'yes-display-inline' and $isMarginIndent = 'yes'">
				<span class="lbexIndent" style="text-align:left">
					<xsl:choose>
						<xsl:when test="$isFollowingDisplayinline = 'no-display-inline'">
							<div style="text-align:center">
								<xsl:call-template name="actualPrintCommitteeReportHeader"/>
							</div>
						</xsl:when>
						<xsl:otherwise>
							<span style="text-align:left" class="lbexIndent">
								<xsl:call-template name="actualPrintCommitteeReportHeader"/>
							</span>
						</xsl:otherwise>
					</xsl:choose>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<!-- TB Nov-2105 changing the rules - if com-rep-header is no-display-inline - must be centered -->
				<!-- does not matter if the following text is yes-display-inline -->
				<xsl:choose>
					<xsl:when test="$isDisplayInline = 'no-display-inline'">
						<div style="text-align:center">
							<xsl:call-template name="actualPrintCommitteeReportHeader"/>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<span style="text-align:left" class="lbexIndent">
							<xsl:call-template name="actualPrintCommitteeReportHeader"/>
						</span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="$isFollowingDisplayinline != 'yes-display-inline'">
			<p/>
		</xsl:if>

	</xsl:template>


	<xsl:template name="actualPrintCommitteeReportHeader">
		<xsl:variable name="isItalic">
			<xsl:choose>
				<xsl:when test="child::italic">
					<xsl:text>on</xsl:text>
				</xsl:when>
				<xsl:when test="@italic">
					<xsl:value-of select="@italic"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>off</xsl:text>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:variable>
		<xsl:variable name="isBold">
			<xsl:choose>
				<xsl:when test="child::bold">
					<xsl:text>on</xsl:text>
				</xsl:when>
				<xsl:when test="@bold">
					<xsl:value-of select="@bold"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>off</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$isItalic = 'on' and $isBold != 'on'">
				<i class="lbexTextNeutral">
					<xsl:call-template name="actualPrintCommitteeReportHeaderTextByStyle"/>
				</i>
			</xsl:when>
			<xsl:when test="$isItalic != 'on' and $isBold = 'on'">
				<b>
					<xsl:call-template name="actualPrintCommitteeReportHeaderTextByStyle"/>
				</b>
			</xsl:when>
			<xsl:when test="$isItalic = 'on' and $isBold = 'on'">
				<b>
					<i class="lbexTextNeutral">
						<xsl:call-template name="actualPrintCommitteeReportHeaderTextByStyle"/>
					</i>
				</b>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="actualPrintCommitteeReportHeaderTextByStyle"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="actualPrintCommitteeReportHeaderTextByStyle">
		<xsl:variable name="reportHeaderStyle">
			<xsl:choose>
				<xsl:when test="@header-style">
					<xsl:value-of select="translate(@header-style, $upper, $lower)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>all-small-caps</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- All-Caps | Caps-Small-Caps | All-Small-Caps | Caps-Lowercase -->
		<xsl:choose>
			<xsl:when test="$reportHeaderStyle = 'all-caps'">
				<span class="lbexSimplecapEx">
					<xsl:value-of select="translate(., $lower, $upper)"/>
				</span>
			</xsl:when>
			<xsl:when test="$reportHeaderStyle = 'caps-small-caps'">
				<span class="lbexSectionTitleTrad">
					<xsl:value-of select="."/>
				</span>
			</xsl:when>
			<xsl:when test="$reportHeaderStyle = 'all-small-caps'">
				<!--span style="font-variant: small-caps;" -->
				<span class="lbexSimplecap">
					<xsl:value-of select="translate(., $upper, $lower)"/>
				</span>
			</xsl:when>
			<xsl:when test="$reportHeaderStyle = 'caps-lowercase'">
				<span class="lbexInitialCapArchaic">
					<xsl:value-of select="."/>
				</span>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- ***************************Display Header******************************* -->
	<xsl:template name="displayHeader">
		<xsl:param name="isSpecialPrinting"/>
		<xsl:variable name="currElementStyle">
			<xsl:call-template name="getCurrentElementStyle"/>
		</xsl:variable>

		<xsl:variable name="IsGenerateEmDash">
			<xsl:call-template name="GenerateEmDash">
				<xsl:with-param name="IsForFollowingSibling">
					<xsl:text>false</xsl:text>
				</xsl:with-param>
				<xsl:with-param name="currentStyle" select="$currElementStyle"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<!-- ***********Section******************************************* -->
			<xsl:when test="parent::section">
				<xsl:call-template name="displayHeaderSection">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
					<xsl:with-param name="isSpecialPrinting" select="$isSpecialPrinting"/>
				</xsl:call-template>
			</xsl:when>
			<!-- ****************Title****************************************** -->
			<xsl:when test="parent::title">
				<xsl:call-template name="displayHeaderTitle">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<!-- *************** Subtitle***************************** -->
			<xsl:when test="parent::subtitle">
				<xsl:call-template name="displayHeaderSubtitle">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<!-- ***************Part************************************* -->
			<xsl:when test="parent::part">
				<xsl:call-template name="displayHeaderPart">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<!-- ************ Subpart ********************************* -->
			<xsl:when test="parent::subpart">
				<xsl:call-template name="displayHeaderSubpart">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<!-- ***************** Chapter****************************** -->
			<xsl:when test="parent::chapter">
				<xsl:call-template name="displayHeaderChapter">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<!-- *********************Subchapter**************************** -->
			<xsl:when test="parent::subchapter">
				<xsl:call-template name="displayHeaderSubchapter">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>

			<!-- ****************************************************************** -->
			<xsl:when
				test="parent::paragraph and ancestor::*[@reported-display-style = 'boldface-roman']">
				<span class="lbexSmallcap">
					<xsl:value-of select="."/>
				</span>
				<xsl:if test="name(.) = 'header'">
					<xsl:text>.—</xsl:text>
				</xsl:if>
				<xsl:if
					test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
					<xsl:text>”</xsl:text>
					<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
				</xsl:if>
			</xsl:when>
			<xsl:when
				test="
					$billType = 'olc' and ((parent::section and ancestor::legis-body/@added-display-style = 'boldface-roman') or
					parent::*[@reported-display-style = 'boldface-roman'] or
					parent::*[@added-display-style = 'boldface-roman'])">
				<span class="lbexSectionlevelOLCBold">
					<xsl:text> </xsl:text>
					<xsl:value-of select="translate(., $lower, $upper)"/>
					<xsl:text>.</xsl:text>
					<!-- if there is only an enum and a header within a quoted block display a ".	-->
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<!--xsl:text>”.</xsl:text-->
						<xsl:call-template name="closeQuotesByCondition"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="parent::subsection and ($currElementStyle = 'archaic' or $currElementStyle = 'archaic-paragraph')">
				<!-- Nothing TB 7Apr2008 Bug #898 -->
				<xsl:if test="$isSpecialPrinting = 'yes'">
					<!--xsl:apply-templates/-->
					<xsl:call-template name="printCompHeaderCapitalize"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="parent::paragraph and $currElementStyle = 'archaic-paragraph'">
				<!-- Nothing in common case TB 7Apr2008 Bug #898 -->
				<xsl:if test="$isSpecialPrinting = 'yes'">
					<xsl:apply-templates/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="parent::paragraph and $currElementStyle = 'archaic'">
				<span class="lbexSimplecap">
					<xsl:apply-templates/>
					<xsl:text>.—</xsl:text>
				</span>
			</xsl:when>
			<xsl:when
				test="parent::subsection or parent::paragraph or parent::subparagraph or parent::clause or parent::subclause or parent::item or parent::subitem">
				<xsl:call-template name="displayTitleByStyle">
					<xsl:with-param name="currElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
				<!--xsl:text>.—</xsl:text-->
				<!-- TB Dec-15-2015 bug fixing #1413 -->
				<xsl:if test="$IsGenerateEmDash = 'true'">
					<xsl:text>.—</xsl:text>
				</xsl:if>
				<xsl:if test="parent::*/@commented ='yes' and not(parent::*/text)">
					<xsl:call-template name="closedBracketStyles"/>	
				</xsl:if>
				<xsl:choose>
					<xsl:when
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<!--xsl:value-of
							select="translate(ancestor::quoted-block/child::after-quoted-block,$lower,$upper) "/-->
						<!-- change by TB 17Dec2008 bug # 989 -->
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>

					</xsl:when>

					<xsl:when
						test="parent::subsection/parent::section/ancestor::quoted-block[@other-style = 'archaic']">
						<xsl:text> </xsl:text>
					</xsl:when>
				</xsl:choose>
				<!-- TB 6Sep2007 #689  end of added section-->
			</xsl:when>
			<!--xsl:when test="(enum-in-header)"-->
			<!--TB exclude appropriations from printing em-dash bug fixing #1391-->
			<xsl:when
				test="(enum-in-header) and not(contains(local-name(parent::*), 'appropriations'))">
				<!--TB 20Sep removed smallCap class-->
				<xsl:text>.—</xsl:text>
				<xsl:call-template name="displayHeaderInStyle"/>
			</xsl:when>
			<!-- ************division*********** -->
			<xsl:when test="parent::division">
				<!--TB 31Aug2007 # 685-->
				<xsl:call-template name="displayDivisionBody">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<!-- ************subdivision*********** -->
			<xsl:when test="parent::subdivision">
				<!--TB 31Aug2007 # 685-->
				<xsl:call-template name="displaySubdivisionBody">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<!-- cases for Appropriations bills -->
			<xsl:when test="ancestor::appropriations-major">
				<xsl:call-template name="toPrintApprHeaderNoBreaks"/>
			</xsl:when>
			<xsl:when test="ancestor::appropriations-intermediate">
				<xsl:call-template name="toPrintApprHeaderNoBreaks"/>
			</xsl:when>
			<xsl:when test="ancestor::appropriations-small">
				<xsl:call-template name="toPrintApprHeaderNoBreaks"/>
			</xsl:when>
			<xsl:when test="//committee-report">
				<xsl:choose>
					<xsl:when test="$committeeID = 'CommitteeCustomization'">
						<!-- for future development. Possibility to display header according to committee ID if required-->
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="reportHeaderStyle">
							<xsl:choose>
								<xsl:when test="@header-style">
									<xsl:value-of select="@header-style"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$currElementStyle"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>


						<!--Default Header Print-->
						<xsl:call-template name="printReportHeaderByStyle">
							<xsl:with-param name="aReportHeaderStyle" select="$reportHeaderStyle"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- end of Appropriations formatting -->
			<xsl:when test="ancestor::rule">
				<xsl:call-template name="displayHeaderRule">
					<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="displayTitleByStyle">
					<xsl:with-param name="currElementStyle" select="$currElementStyle"/>
				</xsl:call-template>
				<xsl:choose>
					<xsl:when test="name(.) = 'header' and parent::committee-appointment-paragraph">
						<xsl:text> </xsl:text>
					</xsl:when>
					<xsl:when test="name(.) = 'header'">
						<xsl:text>.—</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:if
					test="not(following-sibling::*) and name(parent::quoted-block/child::*[2]) = 'after-quoted-block'">
					<xsl:text>”</xsl:text>
					<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="toPrintApprHeaderNoBreaks">
		<xsl:if test="local-name() = 'header'">
			<p style="text-align:center" class="lbexIndentZero">
				<xsl:call-template name="PrintHeaderForAppropriations"/>
			</p>
		</xsl:if>
		<xsl:if test="local-name() != 'header'">
			<xsl:call-template name="PrintHeaderForAppropriations"/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="displayHeaderRule">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when test="@display-inline = 'no-display-inline'">
				<p style="text-align:center" class="lbexInitialCapTrad">
					<xsl:if test="ancestor::quoted-block">
						<xsl:call-template name="openQuotes"/>
					</xsl:if>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexInitialCapTrad">
					<xsl:if test="ancestor::quoted-block">
						<xsl:call-template name="openQuotes"/>
					</xsl:if>
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ******** DisplayHeader Section************************************ -->
	<xsl:template name="displayHeaderSection">
		<xsl:param name="isSpecialPrinting"/>
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when test="ancestor::quoted-block/@style = 'USC'">
				<span class="lbexSectionlevelOLCBold">
					<xsl:text> </xsl:text>
					<!--xsl:value-of select="."/-->
					<xsl:apply-templates/>
					<!--xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2])='after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if-->
				</span>
				<!-- TB 23Apr2009 -->
				<xsl:if test="not(following-sibling::text/@display-inline = 'yes-display-inline')">
					<p/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="ancestor::quoted-block[1]/@style = 'traditional'">
				<!-- TB 24Sep2007 smallcap replaced by simplecap and b removed -->

				<xsl:choose>
					<xsl:when test="enum-in-header">
						<!-- TB 3Jan2008 bug#767 stabilization -->
						<xsl:call-template name="printQuotedText"/>
					</xsl:when>
					<xsl:otherwise>
						<span class="lbexAllcapnormal">
							<xsl:apply-templates/>
						</span>
					</xsl:otherwise>
				</xsl:choose>
				<p/>
			</xsl:when>
			<xsl:when
				test="($billType = 'traditional' and ancestor::*[@reported-display-style = 'boldface-roman'])">
				<span class="lbexSectionLevelTradBold">
					<xsl:text> </xsl:text>
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="$aCurrElementStyle = 'traditional' or $aCurrElementStyle = 'appropriations'">
				<!--  by TB Nov 2015 bug fixing #1406-->
				<xsl:choose>
					<xsl:when
						test="parent::section/@section-type = 'undesignated-section' and not(preceding-sibling::enum)">
						<p class="lbexTocSectionIRCBold" align="center">
							<xsl:text> </xsl:text>
							<xsl:call-template name="printCompHeader"/>
						</p>
					</xsl:when>
					<xsl:otherwise>
						<span class="lbexTocSectionIRCBold">
							<xsl:text> </xsl:text>
							<xsl:call-template name="printCompHeader"/>
						</span>
					</xsl:otherwise>
				</xsl:choose>

				<!--  commented by TB Nov 2015 bug fixing #1406-->
				<!--span class="lbexTocSectionIRCBold">
					<xsl:text> </xsl:text>					
					<xsl:call-template name="printCompHeader"/>
				</span-->
			</xsl:when>
			<xsl:when
				test="
					$billType = 'olc' and (parent::section/parent::legis-body[@added-display-style = 'boldface-roman'] or
					parent::section/parent::legis-body[@reported-display-style = 'boldface-roman'] or
					(parent::section and ancestor::*[@reported-display-style = 'boldface-roman']) or
					(parent::section and ancestor::*[@reported-display-style = 'boldface-italic']))
					">
				<span class="lbexSectionlevelOLCBold">
					<xsl:text> </xsl:text>
					<xsl:value-of select="translate(., $lower, $upper)"/>
					<xsl:text>.</xsl:text>
					<xsl:if test="parent::subsection">
						<xsl:text>—</xsl:text>
					</xsl:if>
					<!-- if there is only an enum and a header within a quoted block display a ".	-->
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<!--xsl:text>”.</xsl:text-->
						<xsl:call-template name="closeQuotesByCondition"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="ancestor::quoted-block[@style = 'tax']">
				<span class="lbexSectionLevelIRCEx">
					<xsl:text> </xsl:text>
					<!--xsl:value-of select="translate(.,$lower,$upper)"/-->
					<xsl:apply-templates/>
					<xsl:text>.</xsl:text>
					<!-- if there is only an enum and a header within a quoted block display a ".	-->
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<!--xsl:text>”.</xsl:text-->
						<xsl:call-template name="closeQuotesByCondition"/>
					</xsl:if>

				</span>
			</xsl:when>
			<!--xsl:when test="(parent::section and ancestor::quoted-block[@other-style='nuclear']) or (parent::section and ancestor::quoted-block[@other-style='traditional-inline']) "-->
			<xsl:when
				test="$aCurrElementStyle = 'nuclear' or $aCurrElementStyle = 'traditional-inline'">
				<span class="lbexSectionLevelOLCnuclear">
					<xsl:text> </xsl:text>
					<!--xsl:value-of select="translate(.,$upper,$lower)"/-->
					<xsl:apply-templates/>
					<xsl:text>.</xsl:text>
					<!--TB 28Dec2007 Bug #767 -->
					<xsl:if
						test="$aCurrElementStyle = 'traditional-inline' and following-sibling::*/@display-inline = 'yes-display-inline'">
						<span class="lbexSectionLevelOLCnuclear">
							<xsl:text>—</xsl:text>
							<xsl:apply-templates select="text"/>
							<xsl:if test="quoted-block[@display-inline = 'yes-display-inline']">
								<xsl:apply-templates select="quoted-block"/>
							</xsl:if>
						</span>
					</xsl:if>
					<!-- if there is only an enum and a header within a quoted block display a ".	-->
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<!--xsl:text>”.</xsl:text-->
						<xsl:call-template name="closeQuotesByCondition"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="contains($aCurrElementStyle, 'archaic') and $isSpecialPrinting = 'yes'">
				<span class="lbexSectionTitleTrad">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<!-- TB 20Sep2007 EnumInHeader fixing divided for two peaces with enum in header and without enum in header -->
			<xsl:when test="enum-in-header">
				<xsl:text> </xsl:text>
				<xsl:apply-templates/>
				<!--xsl:value-of select="translate(.,$lower,$upper)"/-->
				<xsl:text>.</xsl:text>
				<!-- if there is only an enum and a header within a quoted block display a ".	-->
				<xsl:if
					test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
					<!--xsl:text>”.</xsl:text-->
					<xsl:call-template name="closeQuotesByCondition"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="contains($aCurrElementStyle, 'archaic')">
				<span class="lbexSectionTitleTrad">
					<xsl:text> </xsl:text>
					<!-- <xsl:value-of select="translate(.,$lower,$upper)"/> -->
					<!-- Attempting to correct Bug #766.  nvargish 2007-11-07 -->
					<span class="lbexAllcap">
						<xsl:apply-templates/>
					</span>
					<!-- Oct-28-2008 TB commented dot -->
					<xsl:variable name="toCloseQuotes">
						<xsl:call-template name="isQuoteMustClose"/>
					</xsl:variable>
					<xsl:if
						test="(ancestor::quoted-block and $toCloseQuotes = 'false') or following-sibling::* or not(ancestor::quoted-block)">
						<xsl:text>.</xsl:text>
					</xsl:if>
					<!-- if there is only an enum and a header within a quoted block display a ".	-->
					<xsl:if
						test="(not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block') and not($aCurrElementStyle = 'OLC')">
						<!--xsl:text>”.</xsl:text-->
						<xsl:call-template name="closeQuotesByCondition"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="not(enum-in-header)">
				<span class="lbexSectionlevelOLC">
					<xsl:text> </xsl:text>
					<!-- <xsl:value-of select="translate(.,$lower,$upper)"/> -->
					<!-- Attempting to correct Bug #766.  nvargish 2007-11-07 -->
					<span class="lbexAllcap">
						<xsl:apply-templates/>
					</span>
					<!-- Oct-28-2008 TB commented dot -->
					<xsl:variable name="toCloseQuotes">
						<xsl:call-template name="isQuoteMustClose"/>
					</xsl:variable>
					<xsl:if
						test="(ancestor::quoted-block and $toCloseQuotes = 'false') or following-sibling::* or not(ancestor::quoted-block)">
						<xsl:text>.</xsl:text>
					</xsl:if>
					<!-- if there is only an enum and a header within a quoted block display a ".	-->
					<xsl:if
						test="(not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block') and not($aCurrElementStyle = 'OLC')">
						<!--xsl:text>”.</xsl:text-->
						<xsl:call-template name="closeQuotesByCondition"/>
					</xsl:if>
				</span>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="printCompHeader">
		<xsl:for-each select="node()">
			<xsl:choose>
				<xsl:when test="local-name() = '' and not(child::*)">
					<xsl:value-of select="translate(., $lower, $upper)"/>
				</xsl:when>
				<xsl:when test="local-name() = ''">
					<xsl:call-template name="printCompHeader"/>
				</xsl:when>
				<xsl:when test="local-name() = 'added-phrase' and not(child::*)">
					<i class="lbexTextNeutral">
						<xsl:value-of select="translate(., $lower, $upper)"/>
					</i>
				</xsl:when>
				<xsl:when test="local-name() = 'added-phrase'">
					<i class="lbexTextNeutral">
						<xsl:call-template name="printCompHeader"/>
					</i>
				</xsl:when>
				<xsl:when test="local-name() = 'deleted-phrase' and not(child::*)">
					<xsl:choose>
						<xsl:when test = "contains(@reported-display-style,'brackets')">
								<span class="lbexBrakets">
								<xsl:text>[</xsl:text>
							    </span>
							<xsl:value-of select="translate(., $lower, $upper)"/>
							<span class="lbexBrakets">
								<xsl:text>]</xsl:text>
							</span>
						</xsl:when>
					<xsl:otherwise>
							<span class="lbexTextStrikethrough">
								<xsl:value-of select="translate(., $lower, $upper)"/>
							</span>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="local-name() = 'deleted-phrase'">
					<span class="lbexTextStrikethrough">
						<xsl:call-template name="printCompHeader"/>
					</span>
				</xsl:when>
				<xsl:when test="local-name() = 'enum-in-header'">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:when test="local-name() = 'superscript'">
					<sup>
						<xsl:value-of select="."/>
					</sup>
				</xsl:when>
				<xsl:when test="local-name() = 'subscript'">
					<sub>
						<xsl:value-of select="."/>
					</sub>
				</xsl:when>
				<xsl:when test="local-name() = 'inline-comment' and @display = 'yes'">
					<span class="lbexBrakets">
						<xsl:text>[</xsl:text>
					</span>
					<xsl:call-template name="printCompHeader"/>
					<span class="lbexBrakets">
						<xsl:text>]</xsl:text>
					</span>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="printCompHeaderCapitalize">
		<xsl:for-each select="node()">
			<xsl:if test="local-name() = 'inline-comment'">
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="local-name() = '' and not(child::*)">
					<xsl:call-template name="capitalizeReplacement">
						<xsl:with-param name="aText" select="."/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="local-name() = ''">
					<xsl:call-template name="printCompHeaderCapitalize"/>
				</xsl:when>
				<xsl:when test="local-name() = 'added-phrase' and not(child::*)">
					<i class="lbexTextNeutral">
						<xsl:call-template name="capitalizeReplacement">
							<xsl:with-param name="aText" select="."/>
						</xsl:call-template>
					</i>
				</xsl:when>
				<xsl:when test="local-name() = 'added-phrase'">
					<i class="lbexTextNeutral">
						<xsl:call-template name="printCompHeaderCapitalize"/>
					</i>
				</xsl:when>
				<xsl:when test="local-name() = 'deleted-phrase' and not(child::*)">
					<span class="lbexTextStrikethrough">
						<xsl:call-template name="capitalizeReplacement">
							<xsl:with-param name="aText" select="."/>
						</xsl:call-template>
					</span>
				</xsl:when>
				<xsl:when test="local-name() = 'deleted-phrase'">
					<span class="lbexTextStrikethrough">
						<xsl:call-template name="printCompHeaderCapitalize"/>
					</span>
				</xsl:when>
				<xsl:when test="local-name() = 'enum-in-header'">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:when test="local-name() = 'superscript'">
					<sup>
						<xsl:value-of select="."/>
					</sup>
				</xsl:when>
				<xsl:when test="local-name() = 'subscript'">
					<sub>
						<xsl:value-of select="."/>
					</sub>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="local-name() = 'inline-comment'">
				<span class="lbexBrakets">
					<xsl:text>]</xsl:text>
				</span>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!-- ******** DisplayHeader Title************************************ -->
	<xsl:template name="displayHeaderTitle">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:variable name="isTitleHeaderDisplayInline">
			<xsl:choose>
				<xsl:when test="@display-inline = 'no-display-inline'">
					<xsl:text>no</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>yes</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when
				test="$billType = 'traditional' and parent::title[@reported-display-style = 'boldface-roman']">
				<span class="lbexTitleLevelTradBold">
					<xsl:if test="$isTitleHeaderDisplayInline = 'yes'">
						<span style="text-align:center">
							<xsl:text>—</xsl:text>
						</span>
					</xsl:if>
					<xsl:if test="$isTitleHeaderDisplayInline = 'no'">
						<br/>
					</xsl:if>
					<xsl:value-of select="translate(., $lower, $upper)"/>
					<xsl:call-template name="closeQuotesByCondition"/>
				</span>
			</xsl:when>
			<xsl:when test="parent::title[@reported-display-style = 'boldface-roman']">
				<span class="lbexTitleLevelOLC">

					<xsl:if test="$isTitleHeaderDisplayInline = 'yes'">
						<span style="text-align:center">
							<xsl:text>—</xsl:text>
						</span>
					</xsl:if>
					<xsl:if test="$isTitleHeaderDisplayInline = 'no'">
						<br/>
					</xsl:if>
					<xsl:value-of select="translate(., $lower, $upper)"/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="contains($aCurrElementStyle, 'traditional') or contains($aCurrElementStyle, 'archaic') or $aCurrElementStyle = 'appropriations'">
               <xsl:choose>
               	<xsl:when test="contains(parent::title/@reported-display-inline, 'brackets')">
               		<xsl:if test="$isTitleHeaderDisplayInline = 'yes'">
               			<span class="lbexChapterLevelOLCNuclear">
               				<span style="text-align:center">
               					<xsl:text>—</xsl:text>
               				</span>
               				<xsl:call-template name="printCompHeader"/>
               			</span>
               				<span class="lbexBrakets">
               					<xsl:text>]</xsl:text>
               				</span>
               			
               		</xsl:if>
               		<xsl:if test="$isTitleHeaderDisplayInline = 'no'">
               			<!-- TB Aug-13-2015 spacing -->
               			<div class="lbexChapterLevelOLCNuclearIn">
               				<xsl:call-template name="printCompHeader"/>
               			</div>
               				<span class="lbexBrakets">
               					<xsl:text>]</xsl:text>
               				</span>
               			
               		</xsl:if>
               	</xsl:when>
               	<xsl:otherwise>
               		<xsl:if test="$isTitleHeaderDisplayInline = 'yes'">
               			<span class="lbexChapterLevelOLCNuclear">
               				<span style="text-align:center">
               					<xsl:text>—</xsl:text>
               				</span>
               				<xsl:call-template name="printCompHeader"/>
               			</span>
               		</xsl:if>
               		<xsl:if test="$isTitleHeaderDisplayInline = 'no'">
               			<!-- TB Aug-13-2015 spacing -->
               			<div class="lbexChapterLevelOLCNuclearIn">
               				<xsl:call-template name="printCompHeader"/>
               			</div>
               		</xsl:if>
               	</xsl:otherwise>
               </xsl:choose>
				
               	<!--<xsl:if test="$isTitleHeaderDisplayInline = 'no' " >
					<!-\- $isTitleHeaderDisplayInline = 'no' -\->
					<span class="lbexChapterLevelOLCNuclear">
						<span style="text-align:center">
							<xsl:text>—</xsl:text>
						</span>
					   <xsl:call-template name="printCompHeader"/>
					</span>
				</xsl:if>-->
               
				<!--<xsl:call-template name="printCompHeader"/>-->
				<xsl:if
					test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
					<xsl:text>”</xsl:text>
					<xsl:value-of
						select="translate(ancestor::quoted-block/child::after-quoted-block, $lower, $upper)"
					/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$aCurrElementStyle = 'USC' or $aCurrElementStyle = 'tax'">
				<span class="lbexTitleLevelOLC">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<!--xsl:value-of select="translate(.,$lower,$upper)"/-->
					<!--xsl:apply-templates/-->
					<xsl:call-template name="printCompHeader"/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="(parent::title/ancestor::quoted-block[@style = 'OLC']) and //committee-report">
				<span class="lbexTitleLevelOLC">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:apply-templates/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if> 
				</span>
			</xsl:when>
			<xsl:when test="//committee-report">
				<span class="lbexTitleLevelTradEx">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<!-- <xsl:value-of select="translate(.,$lower,$upper)"/> -->
					<!-- replaced above line with subsequent line to fix bug #766. nvargish 2007-11-02 -->
					<xsl:apply-templates/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="ancestor::amendment-block and ../@level-type = 'undesignated' and not(following-sibling::enum or preceding-sibling::enum) and ../header">
				<span class="lbexTitleLevelOLC">
					<span class="lbexAllcap">  
						<xsl:apply-templates/>
					</span>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="text() != ''">
					<span class="lbexTitleLevelOLC">
						<span style="text-align:center">
							<xsl:text>—</xsl:text>
						</span>
						<span class="lbexAllcap">
							<xsl:apply-templates/>
						</span>
					</span>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ******** DisplayHeader Subtitle************************************ -->
	<xsl:template name="displayHeaderSubtitle">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when
				test="$billType = 'traditional' and parent::subtitle[@reported-display-style = 'boldface-roman']">
				<span class="lbexSubTitleLevelTrad">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:text>subtitle </xsl:text>
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="contains($aCurrElementStyle, 'traditional') or contains($aCurrElementStyle, 'archaic') or $aCurrElementStyle = 'appropriations'">
				<span class="lbexChapterLevelOLCNuclear">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:call-template name="printCompHeaderCapitalize"/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="
					(parent::subtitle[@reported-display-style = 'boldface-italic']/ancestor::quoted-block[@style = 'tax']) or
					(ancestor::*[@reported-display-style = 'boldface-italic'] and ancestor::quoted-block[@style = 'tax'])">
				<span class="lbexSubTitleLevelIRCBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:value-of select="."/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="ancestor::quoted-block and $aCurrElementStyle = 'tax'">
				<span class="lbexSubTitleLevelOLC">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:apply-templates/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="$aCurrElementStyle = 'traditional'">
				<span class="lbexSubTitleLevelTrad">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:apply-templates/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="ancestor::amendment-block and ../@level-type = 'undesignated' and not(following-sibling::enum or preceding-sibling::enum) and ../header">
				<span class="lbexSubTitleLevelOLC">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexSubTitleLevelOLC">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ******** DisplayHeader Part************************************ -->
	<xsl:template name="displayHeaderPart">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when
				test="$billType = 'traditional' and parent::part[@reported-display-style = 'boldface-roman']">
				<span class="lbexTitleLevelTradBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:value-of select="translate(., $lower, $upper)"/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of
							select="translate(ancestor::quoted-block/child::after-quoted-block, $lower, $upper)"
						/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="
					(parent::part[@reported-display-style = 'boldface-roman'] and ancestor::quoted-block[@style = 'tax']) or
					(parent::part/parent::quoted-block[@style = 'tax']/ancestor::*[@reported-display-style = 'boldface-roman'])">
				<span class="lbexChapterLevelOLCBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:value-of select="translate(., $lower, $upper)"/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of
							select="translate(ancestor::quoted-block/child::after-quoted-block, $lower, $upper)"
						/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="parent::part[@reported-display-style = 'boldface-roman']">
				<span class="lbexChapterLevelOLCBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:value-of select="translate(., $lower, $upper)"/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of
							select="translate(ancestor::quoted-block/child::after-quoted-block, $lower, $upper)"
						/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="$aCurrElementStyle = 'USC'">
				<span class="lbexSectionlevelOLCBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:call-template name="printCompHeader"/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of
							select="translate(ancestor::quoted-block/child::after-quoted-block, $lower, $upper)"
						/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="contains($aCurrElementStyle, 'traditional') or contains($aCurrElementStyle, 'archaic') or $aCurrElementStyle = 'appropriations'">
				<span class="lbexPartlevelTrad">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="
					(parent::part[@reported-display-style = 'boldface-italic']/ancestor::quoted-block[@style = 'tax']) or
					(ancestor::*[@reported-display-style = 'boldface-italic'] and ancestor::quoted-block[@style = 'tax'])">
				<span class="lbexChapterLevelOLCBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<!--xsl:value-of select="translate(.,$lower,$upper)"/-->
					<xsl:call-template name="printCompHeader"/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="ancestor::quoted-block and $aCurrElementStyle = 'tax'">
				<span class="lbexPartLevelIRCEx">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="ancestor::amendment-block and ../@level-type = 'undesignated' and not(following-sibling::enum or preceding-sibling::enum) and ../header">
				<span class="lbexSectionlevelOLCBold">
					<span class="lbexAllcap">
						<xsl:apply-templates/>
					</span>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexSectionlevelOLCBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<span class="lbexAllcap">
						<xsl:apply-templates/>
					</span>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ******** DisplayHeader Subpart************************************ -->
	<xsl:template name="displayHeaderSubpart">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when
				test="$billType = 'traditional' and parent::subpart[@reported-display-style = 'boldface-roman']">
				<span class="lbexSubPartLevelTradBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:value-of select="."/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="parent::subpart[@reported-display-style = 'boldface-roman']">
				<span class="lbexSubTitleLevelOLCBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:value-of select="."/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="ancestor::quoted-block[@style = 'tax']/ancestor::*[@reported-display-style = 'boldface-roman']">
				<span class="lbexSubTitleLevelOLCBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:value-of select="."/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="contains($aCurrElementStyle, 'traditional') or contains($aCurrElementStyle, 'archaic') or $aCurrElementStyle = 'appropriations'">
				<span class="lbexChapterLevelOLCNuclear">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:call-template name="printCompHeaderCapitalize"/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="(ancestor::*[@reported-display-style = 'boldface-italic'] and ancestor::quoted-block[@style = 'tax'])">
				<span class="lbexSubTitleLevelOLCBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:value-of select="."/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="ancestor::quoted-block and $aCurrElementStyle = 'tax'">
				<span class="lbexSubpartLevelOLC">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:apply-templates/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="ancestor::amendment-block and ../@level-type = 'undesignated' and not(following-sibling::enum or preceding-sibling::enum) and ../header">
				<span class="lbexSubpartLevelOLC">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexSubpartLevelOLC">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<!-- replaced above line with following line to fix Bug #766. nvargish 2007-11-02 -->
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ***************Display Header Chapter**************************************************** -->
	<xsl:template name="displayHeaderChapter">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when
				test="($billType = 'traditional' and parent::chapter[@reported-display-style = 'boldface-roman'])">
				<span class="lbexSubChapterLevelOLC">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:text>chapter </xsl:text>
					<!--xsl:value-of select="."/-->
					<xsl:apply-templates/>
					<xsl:call-template name="closeQuotesByCondition"/>
				</span>
			</xsl:when>
			<xsl:when test="parent::chapter[@reported-display-style = 'boldface-roman']">
				<span class="lbexChapterLevelOLCBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<!--xsl:value-of select="translate(.,$lower,$upper)"/-->
					<xsl:call-template name="printCompHeader"/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="ancestor::*[@reported-display-style = 'boldface-italic']">
				<span class="lbexChapterLevelOLCBold">
					<xsl:value-of select="translate('—', $lower, $upper)"/>
					<xsl:value-of select="translate(., $lower, $upper)"/>
				</span>
			</xsl:when>
			<xsl:when test="ancestor::quoted-block/@style = 'tax'">
				<span class="lbexChapterLevelIRCEx">
					<xsl:value-of select="translate('—', $lower, $upper)"/>
					<!--xsl:value-of select="translate(.,$lower,$upper)"/-->
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="$aCurrElementStyle = 'traditional'">
				<span class="lbexChapterLevelTrad">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<!--xsl:value-of select="."/-->
					<xsl:apply-templates/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="$aCurrElementStyle = 'USC'">
				<span class="lbexSectionlevelOLCBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:call-template name="printCompHeader"/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>

			<xsl:when test="(parent::chapter/ancestor::quoted-block[@other-style = 'nuclear'])">
				<span class="lbexTitleLevelTradEx">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<!-- TB 23Amy2008 -->
					<!--xsl:value-of select="translate(.,$lower,$upper)"/-->
					<xsl:apply-templates/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="$aCurrElementStyle = 'traditional-inline' or $aCurrElementStyle = 'appropriations'">
				<span class="lbexTitleLevelTradEx">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:apply-templates/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="ancestor::amendment-block and ../@level-type = 'undesignated' and not(following-sibling::enum or preceding-sibling::enum) and ../header">
				<span class="lbexChapterLevelOLC">
					<xsl:call-template name="printCompHeader"/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexChapterLevelOLC">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<!-- <xsl:value-of select="translate(.,$lower,$upper)"/> -->
					<xsl:call-template name="printCompHeader"/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ***************Display Header Subchapter**************************************************** -->
	<xsl:template name="displayHeaderSubchapter">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when
				test="($billType = 'traditional' and parent::subchapter[@reported-display-style = 'boldface-roman'])">
				<span class="lbexSubChapterLevelTradBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:value-of select="."/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="$billType = 'olc' and parent::subchapter[@reported-display-style = 'boldface-roman']">
				<span class="lbexSubTitleLevelOLCBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:value-of select="."/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="$aCurrElementStyle = 'archaic-paragraph'">
				<span class="lbexSubChapterLevelTradEx">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<!-- TB subchapter with Enum must apply templates -->
					<!--xsl:value-of select="translate(.,$upper,$lower)"/-->
					<xsl:apply-templates/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="
					(parent::subchapter[@reported-display-style = 'boldface-roman'] and ancestor::quoted-block[@style = 'tax']) or
					parent::subchapter/parent::quoted-block[@style = 'tax']/ancestor::*[@reported-display-style = 'boldface-roman']
					or (parent::subchapter and ancestor::*[@reported-display-style = 'boldface-italic'])">
				<span class="lbexSubTitleLevelOLCBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:value-of select="."/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when
				test="$aCurrElementStyle = 'traditional' or contains($aCurrElementStyle, 'archaic')">
				<span class="lbexChapterLevelOLCNuclear">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<!--xsl:value-of select="translate(.,$lower,$upper)"/-->
					<!--xsl:apply-templates/-->
					<xsl:call-template name="printCompHeader"/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:when test="($billType = 'traditional' and ancestor::quoted-block/@style = 'OLC')">
				<span class="lbexSubChapterLevelOLC">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<xsl:value-of select="."/>
					<xsl:if
						test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
						<xsl:text>”</xsl:text>
						<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</span>
			</xsl:when>
			<!--xsl:when test="ancestor::quoted-block/@style='tax'"-->
			<xsl:when test="ancestor::quoted-block and $aCurrElementStyle = 'tax'">
				<span class="lbexSubChapterLevelOLC">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<!--xsl:value-of select="."/-->
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="$aCurrElementStyle = 'USC'">
				<span class="lbexSectionLevelTradBold">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<!--xsl:value-of select="translate(.,$lower,$upper)"/-->
					<xsl:call-template name="printCompHeader"/>
				</span>
			</xsl:when>
			<xsl:when
				test="$aCurrElementStyle = 'traditional-inline' or $aCurrElementStyle = 'appropriations'">
				<span class="lbexSubTitleLevelTrad">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<!-- <xsl:value-of select="."/> -->
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="(parent::subchapter/ancestor::quoted-block[@other-style = 'nuclear'])">
				<span class="lbexSubChapterLevelOLC">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<!-- <xsl:value-of select="."/> -->
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="ancestor::amendment-block and ../@level-type = 'undesignated' and not(following-sibling::enum or preceding-sibling::enum) and ../header">
				<span class="lbexSubChapterLevelOLC">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexSubChapterLevelOLC">
					<span style="text-align:center">
						<xsl:text>—</xsl:text>
					</span>
					<!-- <xsl:value-of select="."/> -->
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name ="isOpenAlreadyExist">
		<xsl:choose>
			<xsl:when
				test="
					contains(@reported-display-style, 'brackets') or contains(@commented, 'yes') or
					contains(parent::appropriations-intermediate/@reported-display-style, 'brackets') or contains(parent::appropriations-small/@reported-display-style, 'brackets') or contains(parent::appropriations-major/@reported-display-style, 'brackets')
					or contains(ancestor-or-self::appropriations-intermediate/@commented, 'yes') or contains(ancestor-or-self::appropriations-small/@commented, 'yes') or contains(ancestor-or-self::appropriations-major/@commented, 'yes')">
				<xsl:text>First</xsl:text>
			</xsl:when>
		<xsl:when test="contains(ancestor::title/@reported-display-style, 'brackets')">
				<xsl:text>Second</xsl:text>
			</xsl:when>
		</xsl:choose>
		</xsl:template>
	<!-- ***************Print Header for Appropriations********************** -->
	<xsl:template name="PrintHeaderForAppropriations">
		<xsl:variable name="appropReportedStyle">
			<xsl:call-template name="getAppropriationReportingStyle"/>
		</xsl:variable>
		<xsl:variable name="isToCloseTheBrackets">
			<xsl:call-template name="toCloseTheBrakets"/>
		</xsl:variable>
		
		
		<xsl:choose>
			<xsl:when test="$appropReportedStyle = 'italic'">
				<xsl:if test="ancestor::appropriations-major">
					<span class="lbexHeaderAppropMajorItalic">
						<!-- TB Sep2001 MultBrowsers italic tag inserted -->
						<i class="lbexTextNeutral">
							<xsl:call-template name="ActualPrintAppropriationHeaderElement"/>
						</i>
					</span>
				</xsl:if>
				<xsl:if test="ancestor::appropriations-intermediate">
					<span class="lbexHeaderAppropIntermediateItalic">
						<!-- TB Sep2001 MultBrowsers italic tag inserted -->
						<i class="lbexTextNeutral">
							<xsl:call-template name="ActualPrintAppropriationHeaderElement"/>
						</i>
					</span>
				</xsl:if>
				<xsl:if test="ancestor::appropriations-small">
					<span class="lbexHeaderAppropSmallItalic">
						<!-- TB Sep2001 MultBrowsers italic tag inserted -->
						<i class="lbexTextNeutral">
							<xsl:call-template name="ActualPrintAppropriationHeaderElement"/>
						</i>
					</span>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$appropReportedStyle = 'strikethrough'">
				<xsl:if test="ancestor::appropriations-major">
					<span class="lbexHeaderAppropMajor">
						<span class="lbexTextStrikethrough">
							<xsl:call-template name="ActualPrintAppropriationHeaderElement"/>
						</span>
					</span>
				</xsl:if>
				<xsl:if test="ancestor::appropriations-intermediate">
					<span class="lbexHeaderAppropIntermediate">
						<span class="lbexTextStrikethrough">
							<xsl:call-template name="ActualPrintAppropriationHeaderElement"/>
						</span>
					</span>
				</xsl:if>
				<xsl:if test="ancestor::appropriations-small">
					<span class="lbexHeaderAppropSmall">
						<span class="lbexTextStrikethrough">
							<xsl:call-template name="ActualPrintAppropriationHeaderElement"/>
						</span>
					</span>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="ancestor::appropriations-major">
					<span class="lbexHeaderAppropMajor">
						<!--xsl:apply-templates/-->
						<xsl:call-template name="ActualPrintAppropriationHeaderElement"/>
					</span>
				</xsl:if>
				<xsl:if test="ancestor::appropriations-intermediate">
					<span class="lbexHeaderAppropIntermediate">
						<!--xsl:apply-templates/-->
						<xsl:call-template name="ActualPrintAppropriationHeaderElement"/>
					</span>
				</xsl:if>
				<xsl:if test="ancestor::appropriations-small">
					<span class="lbexHeaderAppropSmall">
						<!--xsl:apply-templates/-->
						<xsl:call-template name="ActualPrintAppropriationHeaderElement"/>
					</span>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- *********************Appropriation Element************************** -->
	<xsl:template name="ActualPrintAppropriationElement">
		<!-- print opening brackets or italic style-->
		<xsl:variable name="appropReportedStyle">
			<xsl:call-template name="getAppropriationReportingStyle"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$appropReportedStyle = 'bold-brackets'">
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
			</xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="$appropReportedStyle = 'strikethrough'">
				<span class="lbexTextStrikethrough">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<!--xsl:when test="not(child::*)">
				<xsl:value-of select="."/>
			</xsl:when-->
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>


		<xsl:variable name="isToCloseTheBrackets">
			<xsl:call-template name="toCloseTheBrakets"/>
		</xsl:variable>
		<xsl:choose>
			<!-- Check in aditional that this is the last element in deleted block -->
			<xsl:when
				test="$appropReportedStyle = 'bold-brackets' and $isToCloseTheBrackets = 'yes'">
				<xsl:choose>
					<xsl:when test ="child::list/@changed  = 'not-changed' or child::text">
						<span class="lbexBrakets">
							<xsl:text></xsl:text>
						</span>
					</xsl:when>
				<xsl:otherwise>
						<span class="lbexBrakets">
							<xsl:text>]</xsl:text>
						</span>
					</xsl:otherwise>
					
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="ActualPrintAppropriationHeaderElement">
		<!-- print opening brackets or italic style-->
		<xsl:variable name="appropReportedStyle">
			<xsl:call-template name="getAppropriationReportingStyle"/>
		</xsl:variable>
		<xsl:variable name="isToCloseTheBrackets">
			<xsl:call-template name="toCloseTheBrakets"/>
		</xsl:variable>
		
		<xsl:variable name="isToOpenTheBrackets">
			<xsl:call-template name="isOpenAlreadyExist"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when
				test="((contains($appropReportedStyle, 'brackets')) or (ancestor::appropriations-small/@commented = 'yes' or ancestor::appropriations-intermediate/@commented = 'yes' or ancestor::appropriations-major/@commented = 'yes'))">
				<xsl:choose>
					<xsl:when test="(child::added-phrase or child::deleted-phrase)">
						<span class="lbexBrakets">
							<xsl:text>[</xsl:text>
						</span>
						<xsl:apply-templates/>
						<xsl:if test ="$isToCloseTheBrackets = 'yes'">
							<span class="lbexBrakets">
								<xsl:text>]</xsl:text>
							</span>
						</xsl:if>
					</xsl:when>
				<xsl:when test="$isToOpenTheBrackets = 'First'">
						<span class="lbexBrakets">
							<xsl:text>[</xsl:text>
						</span>
						<xsl:call-template name="convertToNeededCase">
							<xsl:with-param name="localElementName">header</xsl:with-param>
						</xsl:call-template>
						<xsl:if test ="$isToCloseTheBrackets = 'yes'">
							<span class="lbexBrakets">
								<xsl:text>]</xsl:text>
							</span>
						</xsl:if>
						</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="convertToNeededCase">
									<xsl:with-param name="localElementName">header</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
				</xsl:choose>
				</xsl:when>
			<xsl:when test="$appropReportedStyle = 'strikethrough'">
				<span class="lbexTextStrikethrough">
					<!-- TB 20Feb2009 -->
					<!--xsl:apply-templates/-->
					<xsl:call-template name="convertToNeededCase">
						<xsl:with-param name="localElementName">header</xsl:with-param>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when
						test="child::added-phrase[@reported-display-style != ''] or child::deleted-phrase[@reported-display-style != '']">
						<xsl:apply-templates/>
					</xsl:when>
					<xsl:otherwise>
						<!-- TB 20Feb2009 -->
						<!--xsl:apply-templates/-->
						<xsl:call-template name="convertToNeededCase">
							<xsl:with-param name="localElementName">header</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
				</xsl:otherwise>
		</xsl:choose>
   </xsl:template>


	<!-- TB  20Feb2009 Appropriation header printing fixing. In IE the style for lower case are not printed correctly - CSS and IE problem-->
	<xsl:template name="convertToNeededCase">
		<xsl:param name="localElementName"/>
		<xsl:variable name="theActualTextToPrint">
			<xsl:choose>
				<xsl:when test="not(child::*)">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="ancestor::appropriations-major">
				<xsl:choose>
					<xsl:when test="$localElementName = 'header'">
						<xsl:value-of select="translate($theActualTextToPrint, $lower, $upper)"/>
					</xsl:when>
					<xsl:when test="$localElementName = 'subheader'">
						<xsl:value-of select="translate($theActualTextToPrint, $upper, $lower)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$theActualTextToPrint"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="ancestor::appropriations-intermediate">
				<xsl:choose>
					<xsl:when test="$localElementName = 'header'">
						<xsl:call-template name="capitalizeReplacement">
							<xsl:with-param name="aText" select="$theActualTextToPrint"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$localElementName = 'subheader'">
						<xsl:value-of select="translate($theActualTextToPrint, $upper, $lower)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$theActualTextToPrint"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="ancestor::appropriations-small">
				<xsl:value-of select="translate($theActualTextToPrint, $upper, $lower)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$theActualTextToPrint"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ***********Nearest Parent reported style********************** -->
	<xsl:template name="getAppropriationReportingStyle">
		<xsl:choose>
			<xsl:when test="@changed = 'not-changed'">
				<xsl:text/>
			</xsl:when>
			<xsl:when test="@reported-display-style != '' and not(ancestor::*[@reported-display-style])">
				<xsl:value-of select="@reported-display-style"/>
			</xsl:when>
			<xsl:when
				test="not(@reported-display-style) and not(@changed) and parent::*/@changed = 'not-changed'">
				<xsl:text/>
			</xsl:when>
			<xsl:when
				test="not(@changed) and not(parent::*/@changed) and ancestor::*[@changed = 'not-changed']">
				<xsl:choose>
					<xsl:when test ="contains(ancestor::*/@reported-display-style,'brackets')">
						<xsl:value-of select="ancestor::*[@reported-display-style != ''][1]/@reported-display-style"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="ancestor::appropriations-major/@reported-display-style">
				<xsl:value-of select="ancestor::appropriations-major/@reported-display-style"/>
			</xsl:when>
			<xsl:when test="ancestor::appropriations-intermediate/@reported-display-style">
				<xsl:value-of select="ancestor::appropriations-intermediate/@reported-display-style"
				/>
			</xsl:when>
			<xsl:when test="ancestor::appropriations-small/@reported-display-style">
				<xsl:value-of select="ancestor::appropriations-small/@reported-display-style"/>
			</xsl:when>
			<xsl:when test="local-name() = 'deleted-phrase'">
				<!-- default for appropriation deleted phrase reporting syle is bold brackets. works different on the translation - strike -->
				<!-- 17-Sep-2008 verified with Kirstein - default will be strikethrough TB -->
				<xsl:choose>
					<xsl:when test="not(@reported-display-style)">
						<xsl:text>strikethrough</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@reported-display-style"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="local-name() = 'added-phrase'">
				<xsl:value-of select="@reported-display-style"/>
			</xsl:when>
			<xsl:when
				test="ancestor-or-self::*[@reported-display-style != ''] ">
				<xsl:choose>
					<xsl:when test="not(ancestor-or-self::*[@reported-display-style != '']/descendant::*[@changed = 'not-changed'])">
						<xsl:value-of
							select="ancestor-or-self::*[@reported-display-style != ''][1]/@reported-display-style"
						/>
					</xsl:when>
					<xsl:when test="not(@reported-display-style) and (not(@changed))">
						<xsl:value-of
							select="ancestor-or-self::*[@reported-display-style != ''][1]/@reported-display-style"
						/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when
				test=" ancestor-or-self::*[@commented = 'yes'] ">
				<xsl:choose>
					<xsl:when test="not(ancestor-or-self::*[@commented = 'yes']/descendant::*[@changed = 'not-changed'])">
						<xsl:value-of
							select="ancestor-or-self::*[@commented = 'yes'][1]/@commented"
						/>
					</xsl:when>
					<xsl:when test="not(@commented) and (not(@changed))">
						<xsl:text>bold-brackets</xsl:text>
					</xsl:when>
					<xsl:when test="not(@commented) and (not(@changed))">
						<xsl:text>bold-brackets</xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<!-- TB Aug-2016 fixing nesed not changed insode of deleted -->
				<!--xsl:value-of select="ancestor-or-self::*[@reported-display-style != ''][1]/@reported-display-style"/-->
				<xsl:text/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--********** reporting style for the following sibling ****************-->

	<xsl:template name="getAppropriationReportingStyleFollowingSibling">
		<xsl:choose>
			<xsl:when
				test="ancestor-or-self::section[1]/following-sibling::section[1]/@reported-display-style">
				<xsl:value-of
					select="ancestor-or-self::section[1]/following-sibling::section[1]/@reported-display-style"
				/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of
					select="ancestor-or-self::section[1]/following-sibling::section[1]/ancestor-or-self::*/@reported-display-style"
				/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ********** I am last sibling************************ -->
	<xsl:template name="iAmALastSibling">
		<xsl:param name="source"/>
		<xsl:param name="ReportingDisplayStyle">
			<xsl:call-template name="getAppropriationReportingStyle"/>
		</xsl:param>
		<xsl:choose>
			<xsl:when test="ancestor::section[1]/child::*[position() = last()] = self::*">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="local-name() = 'section' and contains($ReportingDisplayStyle, 'brackets')">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="local-name() = 'text' and local-name(ancestor::*[1]) = 'section' and contains($ReportingDisplayStyle, 'brackets')">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="(following-sibling::* and not(local-name(following-sibling::*[1]) = 'after-quoted-block')) or following-sibling::*[2]">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when test="local-name(ancestor::*[1]) = 'quoted-block' and $source != 'toc'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="contains(local-name(ancestor::*[1]), 'appropriations') and $source != 'toc'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="(ancestor::*[1]/following-sibling::* and not(local-name(ancestor::*[1]/following-sibling::*[1]) = 'after-quoted-block') or (ancestor::*[1]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when test="local-name(ancestor::*[2]) = 'quoted-block' and $source != 'toc'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="(ancestor::*[2]/following-sibling::* and not(local-name(ancestor::*[2]/following-sibling::*[1]) = 'after-quoted-block') and not(local-name(ancestor::*[2]/following-sibling::*[1]) = 'endorsement') or (ancestor::*[2]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when test="local-name(ancestor::*[3]) = 'quoted-block' and $source != 'toc'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="(ancestor::*[3]/following-sibling::* and not(local-name(ancestor::*[3]/following-sibling::*[1]) = 'after-quoted-block') and not(local-name(ancestor::*[3]/following-sibling::*[1]) = 'endorsement') or (ancestor::*[3]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when test="local-name(ancestor::*[4]) = 'quoted-block' and $source != 'toc'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="(ancestor::*[4]/following-sibling::* and not(local-name(ancestor::*[4]/following-sibling::*[1]) = 'after-quoted-block') and not(local-name(ancestor::*[4]/following-sibling::*[1]) = 'endorsement') or (ancestor::*[4]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when test="local-name(ancestor::*[5]) = 'quoted-block' and $source != 'toc'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="(ancestor::*[5]/following-sibling::* and not(local-name(ancestor::*[5]/following-sibling::*[1]) = 'after-quoted-block') or (ancestor::*[5]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when test="local-name(ancestor::*[6]) = 'quoted-block' and $source != 'toc'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="(ancestor::*[6]/following-sibling::* and not(local-name(ancestor::*[6]/following-sibling::*[1]) = 'after-quoted-block') or (ancestor::*[6]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when test="local-name(ancestor::*[7]) = 'quoted-block' and $source != 'toc'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="(ancestor::*[7]/following-sibling::* and not(local-name(ancestor::*[7]/following-sibling::*[1]) = 'after-quoted-block') or (ancestor::*[7]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when test="local-name(ancestor::*[8]) = 'quoted-block' and $source != 'toc'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="(ancestor::*[8]/following-sibling::* and not(local-name(ancestor::*[8]/following-sibling::*[1]) = 'after-quoted-block') or (ancestor::*[8]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when test="local-name(ancestor::*[9]) = 'quoted-block' and $source != 'toc'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="(ancestor::*[9]/following-sibling::* and not(local-name(ancestor::*[9]/following-sibling::*[1]) = 'after-quoted-block') or (ancestor::*[9]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when test="local-name(ancestor::*[10]) = 'quoted-block' and $source != 'toc'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="(ancestor::*[10]/following-sibling::* and not(local-name(ancestor::*[10]/following-sibling::*[1]) = 'after-quoted-block') or (ancestor::*[10]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when test="local-name(ancestor::*[11]) = 'quoted-block' and $source != 'toc'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="(ancestor::*[11]/following-sibling::* and not(local-name(ancestor::*[11]/following-sibling::*[1]) = 'after-quoted-block') or (ancestor::*[11]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when test="local-name(ancestor::*[12]) = 'quoted-block' and $source != 'toc'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="(ancestor::*[12]/following-sibling::* and not(local-name(ancestor::*[12]/following-sibling::*[1]) = 'after-quoted-block') or (ancestor::*[12]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when test="local-name(ancestor::*[13]) = 'quoted-block' and $source != 'toc'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="(ancestor::*[13]/following-sibling::* and not(local-name(ancestor::*[13]/following-sibling::*[1]) = 'after-quoted-block') or (ancestor::*[13]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>true</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<!-- ********Close Sibling SectionLevel in Appropriation bills -->
	<xsl:template name="CloseSiblingSectionLevel">
		<xsl:variable name="selfOrParentDeleted">
			<xsl:choose>
				<xsl:when
					test="self::section/@changed = 'deleted' or ancestor::section[1]/@changed = 'deleted' or (ancestor::title/@changed = 'deleted' and not(ancestor::section[1]/@changed))">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="followingOrParentDeleted">
			<xsl:choose>
				<xsl:when
					test="self::section/following-sibling::section[1]/@changed = 'deleted' or ancestor::section[1]/following-sibling::section[1]/@changed = 'deleted' or (ancestor::title/@changed = 'deleted' and not(ancestor::sectioon[1]/following-sibling::section/@changed))">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="lastInSection">
			<xsl:call-template name="isLastInSection"/>
		</xsl:variable>
		<xsl:variable name="ReportedDisplayStyle">
			<xsl:call-template name="getAppropriationReportingStyle"/>
		</xsl:variable>
		<xsl:variable name="ReportedDisplayStyleFollowingSibling">
			<xsl:call-template name="getAppropriationReportingStyleFollowingSibling"/>
		</xsl:variable>
		<xsl:choose>
			<!-- condition has been changed by TB 20-Oct-2009 bug #1018 -->
			<xsl:when
				test="$selfOrParentDeleted = 'true' and $ReportedDisplayStyle = 'bold-brackets' and $followingOrParentDeleted = 'true' and $ReportedDisplayStyleFollowingSibling = 'bold-brackets' and (not(following-sibling::*) or local-name() = 'section') and ($lastInSection = 'true')">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="$selfOrParentDeleted = 'true' and $ReportedDisplayStyle = 'bold-brackets' and local-name() = 'section' and $lastInSection = 'true'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="$selfOrParentDeleted = 'true' and $ReportedDisplayStyle = 'bold-brackets' and $lastInSection = 'true'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--****************Last In Section*************************-->
	<!-- TB Apr2010 reported display style project -->
	<xsl:template name="isLastInSection">
		<xsl:choose>
			<!-- TB 10June2010 brackets fixing-->
			<xsl:when test="self::section">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="following-sibling::* and not(local-name(following-sibling::*[1]) = 'after-quoted-block' and not(following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="local-name(parent::*) = 'section' or (contains(local-name(parent::*), 'appropriations') and not(parent::*/following-sibling::continuation-text))">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="ancestor::*[1]/following-sibling::* and not(local-name(ancestor::*[1]/following-sibling::*[1]) = 'after-quoted-block' and not(ancestor::*[1]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="local-name(ancestor::*[2]) = 'section' or contains(local-name(ancestor::*[2]), 'appropriations')">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="ancestor::*[2]/following-sibling::* and not(local-name(ancestor::*[2]/following-sibling::*[1]) = 'after-quoted-block' and not(ancestor::*[2]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="local-name(ancestor::*[3]) = 'section' or contains(local-name(ancestor::*[3]), 'appropriations')">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="ancestor::*[3]/following-sibling::* and not(local-name(ancestor::*[3]/following-sibling::*[1]) = 'after-quoted-block' and not(ancestor::*[3]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="local-name(ancestor::*[4]) = 'section' or contains(local-name(ancestor::*[4]), 'appropriations')">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="ancestor::*[4]/following-sibling::* and not(local-name(ancestor::*[4]/following-sibling::*[1]) = 'after-quoted-block' and not(ancestor::*[4]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="local-name(ancestor::*[5]) = 'section' or contains(local-name(ancestor::*[5]), 'appropriations')">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="ancestor::*[5]/following-sibling::* and not(local-name(ancestor::*[5]/following-sibling::*[1]) = 'after-quoted-block' and not(ancestor::*[5]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="local-name(ancestor::*[6]) = 'section' or contains(local-name(ancestor::*[6]), 'appropriations')">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="ancestor::*[6]/following-sibling::* and not(local-name(ancestor::*[6]/following-sibling::*[1]) = 'after-quoted-block' and not(ancestor::*[6]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="local-name(ancestor::*[7]) = 'section' or contains(local-name(ancestor::*[7]), 'appropriations')">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="ancestor::*[7]/following-sibling::* and not(local-name(ancestor::*[7]/following-sibling::*[1]) = 'after-quoted-block' and not(ancestor::*[7]/following-sibling::*[2]))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="local-name(ancestor::*[8]) = 'section' or contains(local-name(ancestor::*[8]), 'appropriations')">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>false</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<!--*************checkSiblingsRule*******************************************************************************************************-->
	<!--*************Sibling for this case are: title to title, section to section and appropriations to appropriations all types***************-->
	<!-- *************If element is deleted and reported as bold brakets and following by sibling that also deleted then the braket must be closed  -->
	<xsl:template name="checkSiblingsRule">
		<xsl:variable name="toCloseTheSectionLevel">
			<xsl:call-template name="CloseSiblingSectionLevel"/>
		</xsl:variable>
		<xsl:choose>
			<!-- This rukle valid for appropriations bill type ONLY -->
			<xsl:when test="$billType != 'appropriations'">
				<xsl:text>no</xsl:text>
			</xsl:when>
			<!-- Section following by section -->
			<!-- if deleted section following by deleted section and I am the last element in this section -->
			<xsl:when test="$toCloseTheSectionLevel = 'yes'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<!-- Appropriations Major following by appropriations any type -->
			<xsl:when
				test="
					ancestor::appropriations-major[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets']
					and (ancestor::appropriations-major[1]/following-sibling::appropriations-major[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets']
					or ancestor::appropriations-major[1]/following-sibling::appropriations-intermediate[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets']
					or ancestor::appropriations-major[1]/following-sibling::appropriations-small[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets'])
					and not(following-sibling::*) and ((local-name(parent::*/following-sibling::*) = 'appropriations-major' or local-name(parent::*/following-sibling::*) = 'appropriations-intermediate' or local-name(parent::*/following-sibling::*) = 'appropriations-small') or not(parent::*/following-sibling::*))">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<!-- Appropriations intermediate following by appropriations any type -->
			<xsl:when
				test="
					ancestor::appropriations-intermediate[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets']
					and (ancestor::appropriations-intermediate[1]/following-sibling::appropriations-major[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets']
					or ancestor::appropriations-intermediate[1]/following-sibling::appropriations-intermediate[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets']
					or ancestor::appropriations-intermediate[1]/following-sibling::appropriations-small[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets'])
					and not(following-sibling::*) and ((local-name(parent::*/following-sibling::*) = 'appropriations-major' or local-name(parent::*/following-sibling::*) = 'appropriations-intermediate' or local-name(parent::*/following-sibling::*) = 'appropriations-small') or not(parent::*/following-sibling::*))">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<!-- Appropriations small following by appropriations any type -->
			<xsl:when
				test="
					ancestor::appropriations-small[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets']
					and (ancestor::appropriations-small[1]/following-sibling::appropriations-major[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets']
					or ancestor::appropriations-small[1]/following-sibling::appropriations-intermediate[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets']
					or ancestor::appropriations-small[1]/following-sibling::appropriations-small[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets'])
					and not(following-sibling::*) and ((local-name(parent::*/following-sibling::*) = 'appropriations-major' or local-name(parent::*/following-sibling::*) = 'appropriations-intermediate' or local-name(parent::*/following-sibling::*) = 'appropriations-small') or not(parent::*/following-sibling::*))">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<!-- appropriation small last in title -->
			<xsl:when
				test="
					ancestor::appropriations-small[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets']
					and ancestor::appropriations-small[1]/parent::title and not(ancestor::appropriations-small[1]/following-sibling::*) and not(following-sibling::*)">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<!-- appropriation intermediate last in title -->
			<xsl:when
				test="
					ancestor::appropriations-intermediate[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets']
					and ancestor::appropriations-intermediate[1]/parent::title and not(ancestor::appropriations-intermediate[1]/following-sibling::*) and not(following-sibling::*)">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<!-- appropriation major last in title -->
			<xsl:when
				test="
					ancestor::appropriations-major[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets']
					and ancestor::appropriations-major[1]/parent::title and not(ancestor::appropriations-major[1]/following-sibling::*) and not(following-sibling::*)">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<!-- Title following by title-->
			<xsl:when
				test="ancestor::title[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets'] and ancestor::title[1]/following-sibling::title[1][@changed = 'deleted' and @reported-display-style = 'bold-brackets'] and not(following-sibling::*) and (local-name(parent::*/following-sibling::*) = 'title' or contains(local-name(parent::*/following-sibling::*), 'appropriations') or not(parent::*/following-sibling::*))">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>


		</xsl:choose>
	</xsl:template>

	<!-- TB 13 Mar 2008 #888 -->
	<xsl:template name="toCloseTheBrakets">

		<xsl:variable name="isAncestorDeleted">
			<xsl:choose>
				<xsl:when
					test="contains(ancestor-or-self::*/@reported-display-style, 'brackets') or contains(ancestor-or-self::*/@reported-display-style, 'parentheses') or ancestor-or-self::*[@commented = 'yes']">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="isAncestorDeleted1">
			<xsl:choose>
				<!--xsl:when
					test="ancestor::*[1]/ancestor::*[@changed='deleted' and @reported-display-style='bold-brackets']"-->
				<xsl:when
					test="contains(ancestor::*[1]/ancestor::*/@reported-display-style, 'brackets') or contains(ancestor::*[1]/ancestor::*/@reported-display-style, 'parentheses') or ancestor::*[1]/ancestor::*[@commented = 'yes']">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="isAncestorDeleted2">
			<xsl:choose>
				<xsl:when
					test="contains(ancestor::*[2]/ancestor::*/@reported-display-style, 'brackets') or contains(ancestor::*[2]/ancestor::*/@reported-display-style, 'parentheses') or ancestor::*[2]/ancestor::*[@commented = 'yes']">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="isAncestorDeleted3">
			<xsl:choose>
				<xsl:when
					test="contains(ancestor::*[3]/ancestor::*/@reported-display-style, 'brackets') or contains(ancestor::*[3]/ancestor::*/@reported-display-style, 'parentheses') or ancestor::*[3]/ancestor::*[@commented = 'yes']">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="isAncestorDeleted4">
			<xsl:choose>
				<xsl:when
					test="contains(ancestor::*[4]/ancestor::*/@reported-display-style, 'brackets') or contains(ancestor::*[4]/ancestor::*/@reported-display-style, 'parentheses') or ancestor::*[4]/ancestor::*[@commented = 'yes']">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="isAncestorDeleted5">
			<xsl:choose>
				<xsl:when
					test="contains(ancestor::*[5]/ancestor::*/@reported-display-style, 'brackets') or contains(ancestor::*[5]/ancestor::*/@reported-display-style, 'parentheses') or ancestor::*[5]/ancestor::*[@commented = 'yes']">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="isAncestorDeleted6">
			<xsl:choose>
				<xsl:when
					test="contains(ancestor::*[6]/ancestor::*/@reported-display-style, 'brackets') or contains(ancestor::*[6]/ancestor::*/@reported-display-style, 'parentheses') or ancestor::*[6]/ancestor::*[@commented = 'yes']">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="isSiblingsRuleTrue">
			<xsl:call-template name="checkSiblingsRule"/>
		</xsl:variable>
		<xsl:variable name="isChildLast">
			<xsl:call-template name="iAmALastSibling"/>
		</xsl:variable>
		<xsl:variable name="isLastElementClosed">
			<xsl:call-template name="LastElementClosed"/>
		</xsl:variable>

		<xsl:variable name="ReportedDisplayStyle">
			<xsl:call-template name="getAppropriationReportingStyle"/>
		</xsl:variable>

		<xsl:variable name="lastInSection">
			<xsl:call-template name="isLastInSection"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$isLastElementClosed = 'yes'">
				<xsl:text>no</xsl:text>
			</xsl:when>
			<xsl:when
				test="(local-name() = 'added-phrase' or local-name() = 'deleted-phrase') and (contains(@reported-display-style, 'brackets') or contains(@reported-display-style, 'parentheses'))">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when test="$isSiblingsRuleTrue = 'yes' and $isChildLast = 'true'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when test="not(following::*)">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="(following-sibling::*[1]/text() or following-sibling::*[1]/text or following-sibling::*[1]/child::*/text()) and not(following-sibling::*[1][(@changed = 'deleted' or (not(@changed) and $isAncestorDeleted = 'true')) and (contains($ReportedDisplayStyle, 'brackets') or contains($ReportedDisplayStyle, 'parentheses'))]) and $isChildLast = 'true'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="not(following-sibling::*) and (ancestor::*[1]/following-sibling::*[1]/text != '' or ancestor::*[1]/following-sibling::*[1]/text() or ancestor::*[1]/following-sibling::*[1]/child::*/text()) and not(ancestor::*[1]/following-sibling::*[1][(@changed = 'deleted' or (not(@changed) and $isAncestorDeleted1 = 'true')) and (contains($ReportedDisplayStyle, 'brackets') or contains($ReportedDisplayStyle, 'parentheses'))]) and $isChildLast = 'true'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="not(ancestor::*[1]/following-sibling::*) and ancestor::*[2]/following-sibling::*[1]/text != '' and not(ancestor::*[2]/following-sibling::*[1][(@changed = 'deleted' or (not(@changed) and $isAncestorDeleted2 = 'true')) and (contains($ReportedDisplayStyle, 'brackets') or contains($ReportedDisplayStyle, 'parentheses'))]) and $isChildLast = 'true'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="(not(ancestor::*[2]/following-sibling::*) and not(local-name(ancestor::*[2]) = 'quoted-block')) and ancestor::*[3]/following-sibling::*[1]/text != '' and (ancestor::*[3]/following-sibling::*[1][(@changed = 'deleted' or (not(@changed) and $isAncestorDeleted3 = 'true')) and (contains($ReportedDisplayStyle, 'brackets') or contains($ReportedDisplayStyle, 'parentheses'))]) and $isChildLast = 'true' and $isSiblingsRuleTrue = 'no'">
				<xsl:text>no</xsl:text>
			</xsl:when>
			<xsl:when
				test="(not(ancestor::*[2]/following-sibling::*) and not(local-name(ancestor::*[2]) = 'quoted-block')) and ancestor::*[3]/following-sibling::*[1]/text != '' and (ancestor::*[3]/following-sibling::*[1][(@changed = 'deleted' or (not(@changed) and $isAncestorDeleted3 = 'true')) and (contains($ReportedDisplayStyle, 'brackets') or contains($ReportedDisplayStyle, 'parentheses'))]) and $isChildLast = 'true'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="not(ancestor::*[3]/following-sibling::*) and ancestor::*[4]/following-sibling::*[1]/text != '' and ancestor::*[4]/following-sibling::*[1][(@changed = 'deleted' or (not(@changed) and $isAncestorDeleted4 = 'true')) and ((contains($ReportedDisplayStyle, 'brackets') or (not(@reported-display-style) and $isAncestorDeleted4 = 'true')) or (contains($ReportedDisplayStyle, 'parentheses') or (not(@reported-display-style) and $isAncestorDeleted4 = 'true')))] and $isChildLast = 'true' and $isSiblingsRuleTrue = 'no'">
				<xsl:text>no</xsl:text>
			</xsl:when>
			<xsl:when
				test="not(ancestor::*[3]/following-sibling::*) and ancestor::*[4]/following-sibling::*[1]/text != '' and ancestor::*[4]/following-sibling::*[1][(@changed = 'deleted' or (not(@changed) and $isAncestorDeleted4 = 'true')) and ((contains($ReportedDisplayStyle, 'brackets') or (not(@reported-display-style) and $isAncestorDeleted4 = 'true')) or (contains($ReportedDisplayStyle, 'parentheses') or (not(@reported-display-style) and $isAncestorDeleted4 = 'true')))] and $isChildLast = 'true'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="not(ancestor::*[4]/following-sibling::*) and ancestor::*[5]/following-sibling::*[1]/text != '' and ancestor::*[5]/following-sibling::*[1][(@changed = 'deleted' or (not(@changed) and $isAncestorDeleted5 = 'true')) and ((contains($ReportedDisplayStyle, 'brackets')) or (contains($ReportedDisplayStyle, 'parentheses')))] and $isChildLast = 'true'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="not(ancestor::*[5]/following-sibling::*) and ancestor::*[6]/following-sibling::*[1]/text != '' and ancestor::*[6]/following-sibling::*[1][(@changed = 'deleted' or (not(@changed) and $isAncestorDeleted6 = 'true')) and ((contains($ReportedDisplayStyle, 'brackets')) or (contains($ReportedDisplayStyle, 'parentheses')))] and $isChildLast = 'true'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="(not(following::*) or local-name(following::*[1]) = 'endorsement') and $isChildLast = 'true' and not(local-name(child::*[position() = last()]) = 'subsection')">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="local-name(following-sibling::*[1]) = 'after-quoted-block' and not(following-sibling::*[1]/following::*) and $isChildLast = 'true'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<!--xsl:when
				test="not (following-sibling::*) and local-name(parent::*/following-sibling::*[1])='after-quoted-block'  and  not (parent::*/following-sibling::*[2][@changed='deleted'  or not(@changed) and ($ReportedDisplayStyle ='bold-brackets'  )]) "-->
			<xsl:when
				test="
					not(following-sibling::*)
					and local-name(parent::*/following-sibling::*[1]) = 'after-quoted-block'
					and (not(parent::*/following-sibling::*[2][@changed = 'deleted' or not(@changed) and (contains($ReportedDisplayStyle, 'brackets'))])
					and (not(parent::*/following-sibling::*[2]) and not(ancestor::*[2]/following-sibling::*[2][@changed = 'deleted' or not(@changed) and ((contains($ReportedDisplayStyle, 'brackets')) or (contains($ReportedDisplayStyle, 'parentheses')))])))">

				<xsl:variable name="quotedBlockParent">
					<!--xsl:if test="parent::*/following-sibling::*[1]/ancestor::*[2]"-->
					<xsl:value-of
						select="concat(concat(',', local-name(parent::*/following-sibling::*[1]/ancestor::*[2])), ',')"/>
					<!--/xsl:if-->
				</xsl:variable>
				<xsl:variable name="ToMachForNonClosingBrackets">
					<xsl:text>,subsection,paragraph,subparagraph,clause,subclause,item,subitem,</xsl:text>
				</xsl:variable>
				<xsl:choose>
					<xsl:when
						test="contains($ToMachForNonClosingBrackets, $quotedBlockParent) and parent::*/following-sibling::*[1]/ancestor::*[2]/following-sibling::*">
						<xsl:text>no</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>yes</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="local-name() = 'deleted-phrase'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="$billType = 'appropriations' and local-name() = 'list-item' and (parent::list[@changed = 'deleted'] and contains($ReportedDisplayStyle, 'brackets')) and not(following-sibling::*) and not(parent::list/following-sibling::*[1][@changed = 'deleted'] and contains($ReportedDisplayStyle, 'brackets'))">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="$lastInSection = 'true' and (contains($ReportedDisplayStyle, 'brackets') or parent::section/@commented = 'yes' or contains($ReportedDisplayStyle, 'parentheses'))">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="
					(following-sibling::*[1]/@changed and not(following-sibling::*[1]/@changed = 'deleted')
					and (not(contains(following-sibling::*[1]/@reported-display-style, 'brackets')) or not(contains(following-sibling::*[1]/@reported-display-style, 'parentheses')))) and (contains($ReportedDisplayStyle, 'brackets'))">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="not(following-sibling::*) and (not(child::*) or child::quote) and (contains(parent::*/@reported-display-style, 'brackets'))">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="not(following-sibling::*) and not(child::*) and (contains(parent::*/@reported-display-style, 'parentheses'))">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<!--<xsl:when
				test="((not(parent::*/following-sibling::*) and (not(ancestor::*/following-sibling::*) and  (contains(ancestor::*[current()]/@reported-display-style ,'brackets')))) or (parent::*/following-sibling::*/@changed = 'not-changed' and parent::*/following-sibling::*[position() = last()] = parent::*[current()])) and  (parent::*/@changed !='not-changed' or not(parent::*/@changed))  and not(following-sibling::*) and  (not(parent::*/@reported-display-style) and contains(ancestor::*/@reported-display-style, 'brackets')) ">
				<xsl:text>yes</xsl:text>
			</xsl:when>-->
			<xsl:when
				test="(not(parent::*/following-sibling::*) or (parent::*/following-sibling::*/@changed = 'not-changed' and parent::*/following-sibling::*[position() = last()] = parent::*[current()])) and (parent::*/@changed !='not-changed' or not(parent::*/@changed)) and not(following-sibling::*) and (not(parent::*/@reported-display-style) and contains(ancestor::*/@reported-display-style, 'brackets'))">
				<xsl:choose>
					<xsl:when test = "contains(ancestor::section/@reported-display-style,'brackets') and (ancestor::*/following-sibling::*) and $lastInSection = 'false'">
						<xsl:text>no</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>yes</xsl:text>	
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!--<xsl:when
				test="(not(parent::*/following-sibling::*) or (parent::*/following-sibling::*/@changed = 'not-changed' and parent::*/following-sibling::*[position() = last()] = parent::*[current()])) and  (parent::*/@changed !='not-changed' or not(parent::*/@changed))  and not(following-sibling::*) and  (not(parent::*/@reported-display-style) and contains(ancestor::*/@reported-display-style, 'brackets')) and not(ancestor::*/following-sibling::*)">
				<xsl:text>yes</xsl:text>
			</xsl:when>-->
			<!-- TB 24 Dec 2012 bug fixing -->
			<!--xsl:when test="contains($ReportedDisplayStyle,'brackets') and ((following-sibling::*[1]/@changed and following-sibling::*[1]/@changed != 'deleted' )
				or (not (following-sibling::*) and ancestor::*[1]/following-sibling::*[1]/@changed  and ancestor::*[1]/following-sibling::*[1]/@changed != 'deleted') )
				"-->
			<!--xsl:when test="contains($ReportedDisplayStyle,'brackets') and (following-sibling::*[1] and not (contains(following-sibling::*[1]/@reported-display-style, 'brackets' ))
				or (not (following-sibling::*) and ancestor::*[1]/following-sibling::*[1]  and not(contains(ancestor::*[1]/following-sibling::*[1]/@reported-display-style, 'brackets')) ))">
				<xsl:text>yes</xsl:text>
				</xsl:when-->
			<!--xsl:when test="contains(@reported-display-style,'brackets') and (following-sibling::*[1] and not (contains(following-sibling::*[1]/@reported-display-style, 'brackets' )) and not (contains(parent::*/@reported-display-style, 'brackets')) and not (following-sibling::*[1]/@changed='not-changed')
				or (not (following-sibling::*) and ancestor::*[1]/following-sibling::*[1]  and not(contains(ancestor::*[1]/following-sibling::*[1]/@reported-display-style, 'brackets')) ))"-->
			<xsl:when
				test="
					(contains(@reported-display-style, 'brackets') or contains(@reported-display-style, 'parentheses')) and (following-sibling::*[1] and (not(contains(following-sibling::*[1]/@reported-display-style, 'brackets')) or not(contains(following-sibling::*[1]/@reported-display-style, 'parentheses')))
					and (not(contains(parent::*/@reported-display-style, 'brackets')) or not(contains(parent::*/@reported-display-style, 'parentheses'))) and not(following-sibling::*[1]/@changed = 'not-changed') and
					(not(contains(ancestor::*[2]/@reported-display-style, 'brackets')) or not(contains(ancestor::*[2]/@reported-display-style, 'parentheses'))) and (not(contains(ancestor::*[3]/@reported-display-style, 'brackets')) or not(contains(ancestor::*[3]/@reported-display-style, 'parentheses'))) and
					(not(contains(ancestor::*[4]/@reported-display-style, 'brackets')) or not(contains(ancestor::*[4]/@reported-display-style, 'parentheses')))
					or (not(following-sibling::*) and ancestor::*[1]/following-sibling::*[1] and
					(not(contains(ancestor::*[1]/following-sibling::*[1]/@reported-display-style, 'brackets')) or not(contains(ancestor::*[1]/following-sibling::*[1]/@reported-display-style, 'parentheses')))))">

				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="LastElementClosed">
		<xsl:variable name="possibleElementName">
			<xsl:text>,section,subsection,paragraph,subparagraph,clause,subclause,item,subitem,continuation-text,appropriations-major,appropriations-intermediate,appropriations-small,toc,quoted-block-continuation-text,</xsl:text>
		</xsl:variable>
		<xsl:variable name="actualLastElementName">
			<xsl:choose>
				<xsl:when test="not(child::*)">
					<xsl:text>noChild</xsl:text>
				</xsl:when>
				<xsl:when test="local-name(child::*[position() = last()]) = 'after-quoted-block'">
					<xsl:value-of
						select="concat(concat(',', local-name(child::*[position() = last() - 1])), ',')"
					/>
				</xsl:when>
				<xsl:when test="local-name(child::*[position() = last()]) = 'quoted-block'">
					<xsl:choose>
						<xsl:when test="not((child::*[position() = last()]/child::*))">
							<xsl:text>noChild</xsl:text>
						</xsl:when>
						<xsl:when
							test="local-name((child::*[position() = last()]/child::*)[position() = last()]) = 'after-quoted-block'">
							<xsl:value-of
								select="concat(concat(',', local-name((child::*[position() = last()]/child::*)[position() = last() - 1])), ',')"
							/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of
								select="concat(concat(',', local-name((child::*[position() = last()]/child::*)[position() = last()])), ',')"
							/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of
						select="concat(concat(',', local-name(child::*[position() = last()])), ',')"
					/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="contains($possibleElementName, $actualLastElementName)">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>
		</xsl:choose>

		<!--xsl:choose>
			<xsl:when test="local-name(child::*[position()=last()]) = 'after-quoted-block' ">
				<xsl:choose>
					<xsl:when test=" local-name(child::*[position() = last() - 1]) = 'text' or not (child::*)">
						<xsl:text>no</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>yes</xsl:text>
					</xsl:otherwise>
				</xsl:choose>	
			</xsl:when>			
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test=" local-name(child::*[position() = last()]) = 'text' or not (child::*)">
						<xsl:text>no</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>yes</xsl:text>
					</xsl:otherwise>
				</xsl:choose>	
			</xsl:otherwise>
		</xsl:choose-->
	</xsl:template>

	<!-- subheader elements -->
	<xsl:template match="subheader" name="DisplaySubheader">
		<p style="text-align:center" class="lbexIndentZero">
			<xsl:call-template name="ActualDisplayApppropriationsSubheader"/>
		</p>
	</xsl:template>

	<xsl:template name="ActualDisplayApppropriationsSubheader">
		<xsl:variable name="appropReportedStyle">
			<xsl:call-template name="getAppropriationReportingStyle"/>
		</xsl:variable>
		<xsl:variable name="isToCloseTheBrackets">
			<xsl:call-template name="toCloseTheBrakets"/>
		</xsl:variable>
		
		<xsl:variable name="isToOpenTheBrackets">
			<xsl:call-template name="isOpenAlreadyExist"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when
				test="((contains($appropReportedStyle, 'brackets')) or (ancestor::appropriations-small/@commented = 'yes' or ancestor::appropriations-intermediate/@commented = 'yes' or ancestor::appropriations-major/@commented = 'yes'))">
				<xsl:choose>
				<xsl:when test="(child::added-phrase or child::deleted-phrase)">
					<span class="lbexBrakets">
							<xsl:text>[</xsl:text>
						</span>
				<xsl:apply-templates/>
						<xsl:if test ="$isToCloseTheBrackets = 'yes'">
							<span class="lbexBrakets">
								<xsl:text>]</xsl:text>
							</span>
						</xsl:if>
					</xsl:when>
				<xsl:when test="$isToOpenTheBrackets = 'First'">
						<span class="lbexBrakets">
							<xsl:text>[</xsl:text>
						</span>
						<span class="lbexHeaderAppropSmall">
							<xsl:call-template name="convertToNeededCase">
								<xsl:with-param name="localElementName">subheader</xsl:with-param>
							</xsl:call-template>
						</span>
						<xsl:if test ="$isToCloseTheBrackets = 'yes'">
							<span class="lbexBrakets">
								<xsl:text>]</xsl:text>
							</span>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when
								test="child::added-phrase[@reported-display-style != ''] or child::deleted-phrase[@reported-display-style != '']">
								<xsl:apply-templates/>
							</xsl:when>
						<xsl:otherwise>
								<span class="lbexHeaderAppropSmall">
									<xsl:call-template name="convertToNeededCase">
										<xsl:with-param name="localElementName">subheader</xsl:with-param>
									</xsl:call-template>
								</span>
							</xsl:otherwise>
						</xsl:choose>
					<!-- TB 20Feb2009 -->
						<!--xsl:apply-templates/-->
						<!--<xsl:call-template name="convertToNeededCase">
					<xsl:with-param name="localElementName">header</xsl:with-param>
				</xsl:call-template>-->
					</xsl:otherwise>
				</xsl:choose>
				</xsl:when>
			<!--<xsl:choose>
			<!-\-<xsl:when
				test="(child::added-phrase or child::deleted-phrase) and (contains($appropReportedStyle, 'brackets'))">
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
				<xsl:apply-templates/>
				<xsl:if test ="$isToCloseTheBrackets = 'yes'">
					<span class="lbexBrakets">
						<xsl:text>]</xsl:text>
					</span>
				</xsl:if>
			</xsl:when>-\->
			<xsl:when
				test="(child::added-phrase or child::deleted-phrase)">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when
				test="(contains($appropReportedStyle, 'brackets')) or (ancestor::appropriations-small/@commented='yes'or ancestor::appropriations-intermediate/@commented='yes' or ancestor::appropriations-major/@commented='yes')">
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
				<span class="lbexHeaderAppropSmall">
				<xsl:call-template name="convertToNeededCase">
					<xsl:with-param name="localElementName">subheader</xsl:with-param>
				</xsl:call-template>
				</span>
				<xsl:if test ="$isToCloseTheBrackets = 'yes'">
					<span class="lbexBrakets">
						<xsl:text>]</xsl:text>
					</span>
				</xsl:if>
			</xsl:when>-->
			<xsl:when test="$appropReportedStyle = 'italic'">
				<span class="lbexHeaderAppropSmallItalic">
					<!-- TB Sep2001 MultBrowsers italic tag inserted -->
					<i class="lbexTextNeutral">
						<!-- TB 20Feb2009 -->
						<!--xsl:apply-templates/-->
						<xsl:call-template name="convertToNeededCase">
							<xsl:with-param name="localElementName">subheader</xsl:with-param>
						</xsl:call-template>
					</i>
				</span>
			</xsl:when>
			<xsl:when test="$appropReportedStyle = 'strikethrough'">
				<span class="lbexTextStrikethrough">
					<span class="lbexHeaderAppropSmall">
						<!-- TB 20Feb2009 -->
						<!--xsl:apply-templates/-->
						<xsl:call-template name="convertToNeededCase">
							<xsl:with-param name="localElementName">subheader</xsl:with-param>
						</xsl:call-template>
					</span>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when
						test="child::added-phrase[@reported-display-style != ''] or child::deleted-phrase[@reported-display-style != '']">
						<xsl:apply-templates/>
					</xsl:when>
					<xsl:otherwise>
						<span class="lbexHeaderAppropSmall">
							<xsl:call-template name="convertToNeededCase">
								<xsl:with-param name="localElementName">subheader</xsl:with-param>
							</xsl:call-template>
						</span>
					</xsl:otherwise>
					</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Appropriations sections -->

	<xsl:template name="appropriations-section">
		<div style="text-align:left" class="lbexIndent">
			<xsl:apply-templates/>
		</div>
	</xsl:template>


	<xsl:template match="appropriations-major">
		<xsl:call-template name="appropriations-section"/>
	</xsl:template>
	<xsl:template match="appropriations-intermediate">
		<xsl:call-template name="appropriations-section"/>
	</xsl:template>
	<xsl:template match="appropriations-small">
		<xsl:call-template name="appropriations-section"/>
	</xsl:template>


	<xsl:template match="chapter">
		<!-- TB Aug 2016 bug fixing 1434 -->
		<xsl:call-template name="printSectionAndDownStructure">
			<xsl:with-param name="thePrintingTemplate">DisplayChapter</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="DisplayChapter">
		<xsl:call-template name="createAnchor"/>
		<p/>
		<xsl:call-template name="displaySub"/>
	</xsl:template>
	<xsl:template
		match="//quoted-block/chapter/subchapter[last()]/section[last()]/paragraph[last()]">
		<ul>
			<xsl:call-template name="printQuotedText"/>
			<xsl:if
				test="parent::section/parent::subchapter/parent::chapter/parent::quoted-block/child::after-quoted-block = ''">
				<xsl:text>”</xsl:text>
			</xsl:if>
		</ul>
	</xsl:template>
	<xsl:template match="subchapter">
		<!-- TB Aug 2016 bug fixing 1434 -->
		<xsl:call-template name="printSectionAndDownStructure">
			<xsl:with-param name="thePrintingTemplate">DisplaySubchapter</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="DisplaySubchapter">
		<xsl:call-template name="createAnchor"/>
		<xsl:call-template name="displaySub"/>
	</xsl:template>
	<xsl:template match="part | subpart | division | subdivision">
		<!-- TB Aug 2016 bug fixing 1434 -->
		<xsl:call-template name="printSectionAndDownStructure">
			<xsl:with-param name="thePrintingTemplate">displaySub</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="BigHeadsLinked">
		<p>
			<div style="text-align:center">
				<a>
					<xsl:attribute name="href">
						<xsl:text>#</xsl:text>
						<xsl:value-of select="@id"/>
					</xsl:attribute>
					<!-- TB Jan-2014  billres clean up obsolete attributes -->
					<!--xsl:attribute name="NAME"-->
					<xsl:attribute name="id">
						<xsl:text>toc-</xsl:text>
						<xsl:value-of select="@id"/>
					</xsl:attribute>
					<xsl:apply-templates select="enum"/>
					<xsl:apply-templates select="header"/>
					<xsl:if test="not(following-sibling::*)">
						<xsl:value-of select="parent::quoted-block/child::after-quoted-block"/>
					</xsl:if>
				</a>
			</div>
		</p>
	</xsl:template>
	<xsl:template name="BigHeads">
		<p>
			<div style="text-align:center;clear:both;">
				<xsl:apply-templates select="enum"/>
				<xsl:apply-templates select="header"/>
			</div>
			<xsl:for-each select="child::*">
				<xsl:choose>
					<xsl:when test="local-name() = 'enum' or local-name() = 'header'">
						<!-- Nothing -->
					</xsl:when>
					<xsl:when test="local-name() = 'subdivision'">
						<!-- Recursive call template -->
						<xsl:call-template name="BigHeads"/>
					</xsl:when>
					<xsl:when test="local-name() = 'title'">
						<!-- Recursive call template -->
						<xsl:call-template name="BigHeads"/>
					</xsl:when>
					<xsl:when test="local-name() = 'subtitle'">
						<!-- Recursive call template -->
						<xsl:call-template name="BigHeads"/>
					</xsl:when>
					<xsl:when test="local-name() = 'part'">
						<!-- Recursive call template -->
						<xsl:call-template name="BigHeads"/>
					</xsl:when>
					<xsl:when test="local-name() = 'subpart'">
						<!-- Recursive call template -->
						<xsl:call-template name="BigHeads"/>
					</xsl:when>
					<xsl:when test="local-name() = 'chapter'">
						<!-- Recursive call template -->
						<!--<xsl:call-template name="BigHeads"/>-->
						<xsl:variable name="ancDisplayStyle">
							<xsl:call-template name="getAncDisplayStyle"/>
						</xsl:variable>
						<xsl:choose>
							<xsl:when test="$ancDisplayStyle = 'italic'">
								<i class="lbexTextNeutral">
									<xsl:call-template name="DisplayChapter"/>
								</i>
							</xsl:when>
							<xsl:when test="$ancDisplayStyle = 'boldface-roman'">
								<b class="lbexTextNeutral">
									<xsl:call-template name="DisplayChapter"/>
								</b>
							</xsl:when>
							<xsl:when test="$ancDisplayStyle = 'boldface-italic'">
								<b>
								<i class="lbexTextNeutral">
									<xsl:call-template name="DisplayChapter"/>
								</i>
								</b>
							</xsl:when>
							<xsl:when test="$ancDisplayStyle = 'strikethrough'">
								<span class="lbexTextStrikethrough">
									<xsl:call-template name="DisplayChapter"/>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="DisplayChapter"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="local-name() = 'subchapter'">
						<!-- Recursive call template -->
						<xsl:call-template name="BigHeads"/>
					</xsl:when>
					<xsl:when test="local-name() = 'section'">
						<!-- TB 30Dec2008 Bug #884 -->
						<!--xsl:call-template name="displaySection"/-->
						<xsl:variable name="ancDisplayStyle">
							<xsl:call-template name="getAncDisplayStyle"/>
						</xsl:variable>
						<xsl:choose>
							<xsl:when test="$ancDisplayStyle = 'italic'">
								<i class="lbexTextNeutral">
									<xsl:call-template name="displaySection"/>
								</i>
							</xsl:when>
							<xsl:when test="$ancDisplayStyle = 'boldface-roman'">
								<b class="lbexTextNeutral">
									<xsl:call-template name="displaySection"/>
								</b>
							</xsl:when>
							<xsl:when test="$ancDisplayStyle = 'boldface-italic'">
								<b>
									<i class="lbexTextNeutral">
										<xsl:call-template name="displaySection"/>
									</i>
								</b>
							</xsl:when>
							<xsl:when test="$ancDisplayStyle = 'strikethrough'">
								<span class="lbexTextStrikethrough">
									<xsl:call-template name="displaySection"/>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="displaySection"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="local-name() = 'toc'">
						<xsl:apply-templates select="self::*"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>

		</p>
	</xsl:template>
	<xsl:template name="displaySub">
		<xsl:variable name="isIDReferenceExists">
			<xsl:call-template name="IdReferenceExists">
				<xsl:with-param name="currentID" select="./@id"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:call-template name="createAnchor"/>
		<xsl:choose>
			<!---xsl:when
				test="($billType='olc' and /bill/descendant::*/@idref=./@id) or
				($billType='traditional' and /bill/descendant::*/@idref=./@id)"-->

			<xsl:when test="$isIDReferenceExists = 'yes'">
				<xsl:call-template name="BigHeadsLinked"/>
				<xsl:choose>
					<xsl:when test="child::header">
						<xsl:apply-templates select="child::header/following-sibling::*"/>
					</xsl:when>
					<xsl:when test="child::enum">
						<xsl:apply-templates select="child::enum/following-sibling::*"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="BigHeads"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="createAnchor">
		<a>
			<!-- TB Jan-2014  billres clean up obsolete attributes -->
			<!--xsl:attribute name="NAME"-->
			<xsl:attribute name="id">
				<xsl:value-of select="@id"/>
			</xsl:attribute>
			<xsl:text> </xsl:text>
		</a>
	</xsl:template>
	<xsl:template name="createAnchorParent">
		<a>
			<!-- TB Jan-2014  billres clean up obsolete attributes -->
			<!--xsl:attribute name="NAME"-->
			<xsl:attribute name="id">
				<xsl:value-of select="parent::*/@id"/>
			</xsl:attribute>
			<xsl:text> </xsl:text>
		</a>
	</xsl:template>
	<xsl:template match="title">
		<!-- TB Aug 2016 bug fixing 1434 -->
		<xsl:call-template name="printSectionAndDownStructure">
			<xsl:with-param name="thePrintingTemplate">DisplayTitle</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="DisplayTitle">
		<xsl:call-template name="createAnchor"/>
		<xsl:variable name="isIDReferenceExists">
			<xsl:call-template name="IdReferenceExists">
				<xsl:with-param name="currentID" select="./@id"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<!--xsl:when
				test="($billType='olc' and /bill/descendant::*/@idref=./@id) or
				($billType='traditional' and /bill/descendant::*/@idref=./@id)"-->
			<xsl:when test="$isIDReferenceExists = 'yes'">
				<xsl:call-template name="BigHeadsLinked"/>
				<xsl:choose>
					<xsl:when test="child::header">
						<xsl:apply-templates select="child::header/following-sibling::*"/>
					</xsl:when>
					<xsl:when test="child::enum">
						<xsl:apply-templates select="child::enum/following-sibling::*"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="BigHeads"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="subtitle">
		<!-- TB Aug 2016 bug fixing 1434 -->
		<xsl:call-template name="printSectionAndDownStructure">
			<xsl:with-param name="thePrintingTemplate">displaySubtitle</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="displaySubtitle">
		<xsl:call-template name="createAnchor"/>
		<xsl:variable name="isIDReferenceExists">
			<xsl:call-template name="IdReferenceExists">
				<xsl:with-param name="currentID" select="./@id"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<!--xsl:when
				test="($billType='olc' and /bill/descendant::*/@idref=./@id) or
				($billType='traditional' and /bill/descendant::*/@idref=./@id)"-->
			<xsl:when test="$isIDReferenceExists = 'yes'">
				<xsl:call-template name="BigHeadsLinked"/>
				<xsl:choose>
					<xsl:when test="child::header">
						<xsl:apply-templates select="child::header/following-sibling::*"/>
					</xsl:when>
					<xsl:when test="child::enum">
						<xsl:apply-templates select="child::enum/following-sibling::*"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="BigHeads"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="toc/child::*//text()">
		<xsl:variable name="currElementStyle">
			<xsl:call-template name="getCurrentElementStyle"/>
		</xsl:variable>
		<xsl:variable name="parentOrLevel">
			<xsl:choose>
				<xsl:when test="ancestor::toc-entry and ancestor::toc-entry/@level">
					<xsl:value-of select="ancestor::toc-entry/@level"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>section</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when
				test="($parentOrLevel = 'part' or $parentOrLevel = 'subpart') and $currElementStyle = 'tax'">
				<span class="lbexInitialCapArchaic">
					<xsl:value-of select="."/>
				</span>
			</xsl:when>
			<xsl:when
				test="$parentOrLevel = 'division' or $parentOrLevel = 'title' or $parentOrLevel = 'part' or $parentOrLevel = 'subpart' or $parentOrLevel = 'chapter' or $parentOrLevel = 'subchapter'">
				<xsl:value-of select="translate(., $lower, $upper)"/>
			</xsl:when>
			<xsl:when test="$parentOrLevel = 'subtitle'">
				<xsl:value-of select="."/>
			</xsl:when>
			<xsl:when test="$parentOrLevel = 'subdivision'">
				<span class="lbexSectionTitleTrad">
					<xsl:value-of select="."/>
				</span>
			</xsl:when>
			<!-- TB May-20-2015 fixing tax toc-entry - extra closing quotes printing -->
			<!--xsl:when test="following::text()[1]=ancestor::quoted-block/after-quoted-block"-->
			<xsl:when
				test="following::text()[1] = ancestor::quoted-block/after-quoted-block and (local-name(parent::*) != 'toc-entry' or $currElementStyle != 'tax')">
				<xsl:value-of select="."/>
				<xsl:text>”</xsl:text>
				<xsl:value-of select="ancestor::quoted-block/after-quoted-block"/>
			</xsl:when>

			<!-- TB 12July2010 fixing error compilation wrong condition -->
			<!--xsl:when test="following::text()[1]=ancestor::quoted-block/after-quoted-block =''">
				<xsl:value-of select="."/>
				</xsl:when-->
			<xsl:when test="following::text()[1] and ancestor::quoted-block/after-quoted-block = ''">
				<xsl:value-of select="."/>
			</xsl:when>
			<xsl:when
				test="name(following::node()[1]) = 'after-quoted-block' and following::node()[1] = ''">
				<xsl:value-of select="."/>
				<xsl:if
					test="substring(normalize-space(.), string-length(normalize-space(.))) != '.'">
					<xsl:text>.”</xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:when test=". = 'TABLE OF CONTENTS' and $billType = 'traditional'">
				<xsl:value-of select="."/>
			</xsl:when>
			<xsl:when test="ancestor::toc-entry/parent::toc/parent::chapter">
				<xsl:choose>
					<xsl:when test="parent::toc-entry[@level = 'subchapter']">
						<span class="lbexInitialCapTrad">
							<xsl:text>subchapter </xsl:text>
						</span>
						<xsl:value-of select="substring-after(., 'Subchapter ')"/>
						<xsl:text>.</xsl:text>
					</xsl:when>
					<xsl:when test="$parentOrLevel = 'section'">
						<xsl:value-of select="."/>
						<xsl:if
							test="substring(normalize-space(.), string-length(normalize-space(.))) != '.'">
							<xsl:text>.</xsl:text>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$parentOrLevel = 'chapter'">
				<!-- TB this condition is weird - check it later -->
				<xsl:choose>
					<xsl:when test="$parentOrLevel = 'chapter'">
						<span class="lbexTocChapterTrad">
							<xsl:text>chapter </xsl:text>
						</span>
						<xsl:value-of select="substring-after(., 'Chapter ')"/>
						<xsl:text>.</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when
				test="
					$parentOrLevel = 'subtitle' or $parentOrLevel = 'subchapter'
					or $parentOrLevel = 'part' or $parentOrLevel = 'subpart'">
				<xsl:value-of select="."/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="toc/toc-entry/act-name/text()">
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template match="text()">
		<xsl:variable name="currentElementStyle">
			<xsl:call-template name="getCurrentElementStyle"/>
		</xsl:variable>
		<xsl:variable name="isToCloseTheBrackets">
			<xsl:call-template name="toCloseTheBrakets"/>
		</xsl:variable>
		<xsl:choose>
			<!-- TB MAy 2011 bug #1208 -->
			<xsl:when test="parent::after-quoted-block"/>
			<xsl:when test="following::text()[1] = ancestor::quoted-block/after-quoted-block">
				<xsl:choose>
					<xsl:when
						test="../parent::section and parent::header and $currentElementStyle = 'traditional'">
						<span class="lbexSimpleCapNormal">
							<xsl:value-of select="."/>
							<!-- TB 33Jan2008  Bug #767 -->
							<xsl:call-template name="closeQuotesByCondition"/>

						</span>
					</xsl:when>
					<xsl:otherwise>
						<!--TB Bug #860 -->
						<!--xsl:value-of select="."/-->
						<xsl:choose>
							<xsl:when
								test="
									name(..) != 'added-phrase' and name(..) != 'entry' and name(..) != 'act-name' and
									following::*[1] = ancestor::quoted-block/after-quoted-block and not(parent::quote)">
								<xsl:variable name="textToPrint">
									<xsl:call-template name="RemoveSpaces">
										<xsl:with-param name="origString">
											<xsl:value-of select="."/>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:variable>
								<xsl:call-template name="ActualPrintIChangedTextWithParam">
									<xsl:with-param name="aTheTextToPrint" select="$textToPrint"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="ActualPrintIChangedText"/>
							</xsl:otherwise>
						</xsl:choose>

						<xsl:if test="position() = last()">
							<xsl:choose>
								<xsl:when test="name(..) = 'list-item' and not(position() = last())">
									<xsl:value-of select="following::text()[1]"/>
									<xsl:call-template name="closeQuotes"/>
									<xsl:value-of select="following::text()[1]"/>
								</xsl:when>
								<xsl:when
									test="
										name(..) != 'added-phrase' and name(..) != 'entry' and name(..) != 'act-name' and
										following::*[1] = ancestor::quoted-block/after-quoted-block and not(parent::quote)">
									<xsl:if test="$isToCloseTheBrackets='yes' and contains(ancestor::quoted-block/@reported-display-style,'brackets') and (ancestor::quoted-block/title or ancestor::quoted-block/subtitle)">
										<xsl:call-template name="closedBracketStyles"/>
									</xsl:if>
									<xsl:call-template name="closeQuotes"/>
									<xsl:value-of select="following::text()[1]"/>
									<!-- TB May 2011 bug #1208 -->
									<xsl:variable name="isNextNonEmptyAfterQuotedBlock">
										<xsl:call-template name="NextNonEmptyAfterQuotedBlock">
											<xsl:with-param name="currentNode"
												select="ancestor::quoted-block[1]"/>
										</xsl:call-template>
									</xsl:variable>
									<xsl:if test="$isNextNonEmptyAfterQuotedBlock = 'true'">
										<xsl:call-template name="closeQuotes">
											<xsl:with-param name="currNode"
												select="following::after-quoted-block[2]"/>
										</xsl:call-template>
										<xsl:if test="following::after-quoted-block[2]/child::*">
											<xsl:for-each
												select="following::after-quoted-block[2]/child::*">
												<xsl:choose>
												<xsl:when
												test="local-name() = 'deleted-phrase' or local-name() = 'added-phrase'">
												<xsl:apply-templates/>
												</xsl:when>
												<xsl:otherwise>
												<xsl:value-of select="."/>
												</xsl:otherwise>
												</xsl:choose>
											</xsl:for-each>
										</xsl:if>
										<!-- TB 4Oct2011 double after quoted block printing check -->
										<xsl:if
											test="not(following::after-quoted-block[2]/child::*)">
											<xsl:text>&#8221;</xsl:text>
											<xsl:value-of select="following::after-quoted-block[2]"
											/>
										</xsl:if>
									</xsl:if>

								</xsl:when>
							</xsl:choose>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when
				test="name(following::node()[1]) = 'after-quoted-block' and following::node()[1] = ''">
				<xsl:value-of select="."/>
				<xsl:text>”</xsl:text>
			</xsl:when>
			<xsl:when test="parent::after-quoted-block"/>
			<xsl:when
				test="parent::header/child::added-phrase or parent::header/child::deleted-phrase">
				<!-- TB 17Mar08 bug #874 first line added, bcause the text before/after deleted or added phrase was not printed. -->
				<!--xsl:value-of select="."/-->
				<xsl:call-template name="displayHeader"/>
				<!-- TB 21Mar2008 the period was removed because it is not related to here. if for some reason it must appear there it must be by additional condition -->
				<!--xsl:text>.</xsl:text-->
			</xsl:when>
			<xsl:when test="parent::header/parent::section and parent::header/child::enum-in-header">

				<xsl:choose>
					<xsl:when test="$currentElementStyle = 'OLC'">
						<span class="lbexSectionlevelOLC">
							<xsl:if test="not(parent::enum-in-header)">
								<xsl:value-of select="translate(., $lower, $upper)"/>
							</xsl:if>
							<xsl:if test="parent::enum-in-header">
								<xsl:value-of select="."/>
							</xsl:if>
						</span>
					</xsl:when>
					<xsl:when test="$currentElementStyle = 'traditional'">
						<span class="lbexTocSectionIRCBold">
							<xsl:if test="not(parent::enum-in-header)">
								<xsl:value-of select="translate(., $lower, $upper)"/>
							</xsl:if>
							<xsl:if test="parent::enum-in-header">
								<xsl:value-of select="."/>
							</xsl:if>
						</span>
					</xsl:when>
					<xsl:when test="contains($currentElementStyle, 'archaic')">
						<span class="lbexTocSectionIRCBold">
							<xsl:if test="not(parent::enum-in-header)">
								<xsl:value-of select="translate(., $lower, $upper)"/>
							</xsl:if>
							<xsl:if test="parent::enum-in-header">
								<xsl:value-of select="."/>
							</xsl:if>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:when>
			<xsl:when
				test="../parent::subchapter and parent::header and ($currentElementStyle = 'archaic-paragraph')">
				<xsl:value-of select="translate(., $lower, $upper)"/>
			</xsl:when>
			<!--xsl:when test="$currentElementStyle='tax'">
				<span class="indentTax">
					<xsl:value-of select="."/>
				</span>
			</xsl:when-->
			<xsl:otherwise>
				<xsl:call-template name="ActualPrintIChangedText"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- TB 26Feb2008 Extracted to separate template - to allow call this function from several places -->
	<xsl:template name="ActualPrintIChangedText">
		<xsl:call-template name="ActualPrintIChangedTextWithParam">
			<xsl:with-param name="aTheTextToPrint" select="."/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="ActualPrintIChangedTextWithParam">
		<xsl:param name="aTheTextToPrint"/>
		<xsl:variable name="printItalicTextForReport">
			<xsl:call-template name="IsPrintItalicTextForReport"/>
		</xsl:variable>
		<xsl:variable name="toBeNeutralized">
			<xsl:call-template name="isNeutralizeSegment"/>
		</xsl:variable>
		<xsl:variable name="neutralBlockClassName">
			<xsl:call-template name="getNeutralBlockClassName"/>
		</xsl:variable>
		<xsl:variable name="neutralInlineClassName">
			<xsl:call-template name="getNeutralInlineClassName"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$printItalicTextForReport = 'yes' and @commented = 'yes'">
				<i>
					<xsl:if test="$toBeNeutralized = 'yes'">
						<xsl:attribute name="class">
							<xsl:value-of select="$neutralInlineClassName"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="$aTheTextToPrint"/>
				</i>
			</xsl:when>
			<xsl:when
				test="ancestor::amendment-block[@changed = 'added' and @reported-display-style = 'italic']">
				<i>
					<xsl:if test="$toBeNeutralized = 'yes'">
						<xsl:attribute name="class">
							<xsl:value-of select="$neutralInlineClassName"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="$aTheTextToPrint"/>
				</i>
			</xsl:when>
			<xsl:when
				test="ancestor::amendment-block[@changed = 'added' and @reported-display-style = 'boldface-italic']">
				<span class="lbexBldItalic">
					<xsl:value-of select="$aTheTextToPrint"/>
				</span>
			</xsl:when>
			<xsl:when
				test="ancestor::whereas[@changed = 'deleted' and @reported-display-style = 'strikethrough']">
				<span class="lbexTextStrikethrough">
					<xsl:value-of select="$aTheTextToPrint"/>
				</span>
			</xsl:when>
			<xsl:when
				test="ancestor::amendment-block[@changed = 'deleted' and @reported-display-style = 'strikethrough']">
				<span class="lbexTextStrikethrough">
					<xsl:value-of select="$aTheTextToPrint"/>
				</span>
			</xsl:when>
			<xsl:when
				test="ancestor::*[@changed = 'deleted' and @reported-display-style = 'strikethrough'] and ancestor::table">
				<span class="lbexTextStrikethrough">
					<xsl:value-of select="$aTheTextToPrint"/>
				</span>
			</xsl:when>
			<xsl:when
				test="ancestor::*[@changed = 'added' and @reported-display-style = 'italic'] and ancestor::table">
				<i>
					<xsl:if test="$toBeNeutralized = 'yes'">
						<xsl:attribute name="class">
							<xsl:value-of select="$neutralInlineClassName"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="$aTheTextToPrint"/>
				</i>
			</xsl:when>
			<xsl:when
				test="ancestor::whereas[@changed = 'added' and @reported-display-style = 'italic']">
				<i>
					<xsl:if test="$toBeNeutralized = 'yes'">
						<xsl:attribute name="class">
							<xsl:value-of select="$neutralInlineClassName"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="$aTheTextToPrint"/>
				</i>
			</xsl:when>
			<xsl:when
				test="ancestor::*[@changed = 'added' and @reported-display-style = 'boldface-italic']">
				<span>
					<xsl:if test="$toBeNeutralized = 'yes'">
						<xsl:attribute name="class">
							<xsl:value-of select="$neutralInlineClassName"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="$aTheTextToPrint"/>
				</span>
			</xsl:when>
			<xsl:when
				test="(ancestor::appropriations-major or ancestor::appropriations-intermediate or ancestor::appropriations-small) and (parent::header) and (preceding-sibling::deleted-phrase or following-sibling::deleted-phrase or preceding-sibling::added-phrase or following-sibling::added-phrase)">
				<xsl:call-template name="PrintHeaderForAppropriations"/>
			</xsl:when>
			<xsl:when
				test="(ancestor::appropriations-major or ancestor::appropriations-intermediate or ancestor::appropriations-small) and (parent::subheader) and (preceding-sibling::deleted-phrase or following-sibling::deleted-phrase or preceding-sibling::added-phrase or following-sibling::added-phrase)">
				<xsl:call-template name="ActualDisplayApppropriationsSubheader"/>
			</xsl:when>
			<xsl:when test="contains(local-name(..), 'rules-clause')">
				<!-- bug fixing #1202 - like in translation - exception for rules-clause -->
				<xsl:value-of select="normalize-space($aTheTextToPrint)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$aTheTextToPrint"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="conference-report-form/legis-type">
		<div style="text-align:center">
			<br/>
			<br/>
			<span class="lbexLargeCapTrad">
				<xsl:value-of select="."/>
			</span>
			<br/>
			<br/>

			<xsl:call-template name="printToAccompanyText"/>
		</div>
	</xsl:template>

	<xsl:template match="committee-report-form/legis-type">
		<div style="text-align:center">
			<br/>
			<br/>
			<xsl:choose>
				<xsl:when test="translate(., $lower, $upper) = 'REPORT'">
					<span class="lbexLargeCapTrad">
						<xsl:call-template name="insertSpaces">
							<xsl:with-param name="origString" select="translate(., $lower, $upper)"
							/>
						</xsl:call-template>
					</span>
				</xsl:when>
				<xsl:otherwise>
					<span class="lbexLargeCapTrad">
						<xsl:value-of select="translate(., $lower, $upper)"/>
					</span>
				</xsl:otherwise>
			</xsl:choose>


			<br/>
			<br/>

			<!--xsl:call-template name="printToAccompanyText"/-->
		</div>
	</xsl:template>
	<xsl:template match="short-title">
		<!--xsl:value-of select="."/-->
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="text">
		<xsl:if
			test="parent::section/@section-type = 'undesignated-section' and (not(parent::section/enum) or normalize-space(parent::section/enum) = '') and (not(parent::section/header) or normalize-space(parent::section/header) = '')">
			<xsl:call-template name="createAnchorParent"/>
		</xsl:if>
		<xsl:variable name="isLastElement">
			<xsl:call-template name="isLastElementInLoop"/>
		</xsl:variable>
		<xsl:variable name="currentElementStyle">
			<xsl:call-template name="getCurrentElementStyle"/>
		</xsl:variable>
		<xsl:variable name="isToCloseTheBrackets">
			<xsl:call-template name="toCloseTheBrakets"/>
		</xsl:variable>
		<xsl:choose>
			<!-- TB 31Aug2007 #685 ext. Not to print inline text when my parent is no-inline and I have no header or enum cild before text -->
			<xsl:when
				test="
					(@display-inline = 'yes-display-inline' or not(@display-inline)) and
					((parent::section/@display-inline = 'yes-display-inline' or parent::section/enum or parent::section/header) or
					(parent::subsection/@display-inline = 'yes-display-inline' or parent::subsection/enum or parent::subsection/header) or
					(parent::paragraph/@display-inline = 'yes-display-inline' or parent::paragraph/enum or parent::paragraph/header) or
					(parent::subparagraph/@display-inline = 'yes-display-inline' or parent::subparagraph/enum or parent::paragraph/header) or
					(parent::item/@display-inline = 'yes-display-inline' or parent::item/enum or parent::item/header) or
					(parent::subitem/@display-inline = 'yes-display-inline' or parent::subitem/enum or parent::subitem/header) or
					(parent::clause/@display-inline = 'yes-display-inline' or parent::clause/enum or parent::clause/header) or
					(parent::subclause/@display-inline = 'yes-display-inline' or parent::subclause/enum or parent::subclause/header)) or
					(parent::amendment-block/@display-inline = 'yes-display-inline')">
				<xsl:if test="parent::amendment-block">
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:apply-templates/>
			<xsl:choose>
					<xsl:when
						test="((contains(ancestor-or-self::*/@reported-display-style, 'brackets')) or ancestor-or-self::*/@reported-display-style= 'bold-brackets') and $isLastElement = 'yes' and $isToCloseTheBrackets = 'yes' and (parent::*[1]/@indent != 'up1' or not(parent::*[1]/@indent))">
					<xsl:call-template name="closedBracketStyles"/>
						</xsl:when>
				<xsl:when
						test="(contains(parent::section/@commented, 'yes')) and $isLastElement = 'yes'">
						<xsl:call-template name="closedBracketStyles"/>
					</xsl:when>
				<xsl:when
						test="(contains(parent::paragraph/@commented, 'yes')) and $isLastElement = 'yes' and (parent::*[1]/@indent != 'up1' or not(parent::*[1]/@indent))">
						<xsl:call-template name="closedBracketStyles"/>
					</xsl:when>
				<xsl:when
						test="(contains(parent::subsection/@commented, 'yes')) and $isLastElement = 'yes' and (parent::*[1]/@indent != 'up1' or not(parent::*[1]/@indent))">
						<xsl:call-template name="closedBracketStyles"/>
					</xsl:when>
				<xsl:when
						test="(contains(parent::subparagraph/@commented, 'yes')) and $isLastElement = 'yes' and (parent::*[1]/@indent != 'up1' or not(parent::*[1]/@indent))">
						<xsl:call-template name="closedBracketStyles"/>
					</xsl:when>
					<xsl:when
						test="(contains(parent::clause/@commented, 'yes')) and $isLastElement = 'yes' and (parent::*[1]/@indent != 'up1' or not(parent::*[1]/@indent))">
						<xsl:call-template name="closedBracketStyles"/>
					</xsl:when><xsl:when
						test="(contains(parent::subclause/@commented, 'yes')) and $isLastElement = 'yes' and (parent::*[1]/@indent != 'up1' or not(parent::*[1]/@indent))">
						<xsl:call-template name="closedBracketStyles"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<!-- TB 31Dec2007 optimize the condition -->
			<!--xsl:when test="parent::*/@display-inline='yes-display-inline' or parent::*/enum or  parent::*/header">
				<xsl:apply-templates/>
			</xsl:when-->
			<xsl:when
				test="parent::section/@display-inline = 'yes-display-inline' or parent::section/@section-type = 'resolved'">
				<xsl:if test="parent::section/ancestor::quoted-block">
					<xsl:call-template name="openQuotes"/>
				</xsl:if>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when
				test="parent::section/@display-inline = 'no-display-inline' and $billType = 'traditional'">
				<span class="lbexIndent">
					<xsl:call-template name="ActualPrintText"/>
				</span>
			</xsl:when>
			<!--<xsl:when
				test="
					parent::section/@display-inline = 'no-display-inline' and
					not(following-sibling::quoted-block[@display-inline = 'yes-display-inline']) and $billType = 'appropriations'">
				<!-\- TB  28Apr2009 -\->
				<xsl:call-template name="ActualPrintText"/>
			</xsl:when>-->
			<xsl:when
				test="
					parent::section/@display-inline = 'no-display-inline' and
					not(following-sibling::quoted-block[@display-inline = 'yes-display-inline'])">
				<!-- TB  in Tax style show titles smaller indentTax -->
				<p style="text-align:left" class="lbexIndent">
					<xsl:call-template name="ActualPrintText"/>
			    <xsl:choose>
						<xsl:when
							test="(contains(ancestor-or-self::*/@reported-display-style, 'brackets')) and $isLastElement = 'yes' and $isToCloseTheBrackets = 'yes' and following-sibling::list/@changed='not-changed' and $currentElementStyle='OLC'">
							<xsl:call-template name="closedBracketStyles"/>
						</xsl:when>
						<!--<xsl:when
							test="(contains(parent::section/@commented, 'yes')) and $isLastElement = 'yes'">
							<xsl:call-template name="closedBracketStyles"/>
						</xsl:when>-->
					</xsl:choose>
				</p>
			</xsl:when>
			<xsl:when test="parent::enum-in-header">
				<xsl:value-of select="."/>
			</xsl:when>
			<xsl:when
				test="parent::amendment-instruction or parent::committee-report-para or parent::committee-report-subpara or parent::committee-report-segment or parent::purpose-of-bill or parent::background-needs or parent::committee-recommendation or parent::legislative-history or parent::summary-of-provisions or parent::estimated-costs or parent::regulatory-impact or parent::directed-spending or parent::sec-by-sec-analysis">
				<xsl:choose>
					<xsl:when
						test="(local-name(preceding-sibling::*[1]) = 'committee-report-header' or local-name(preceding-sibling::*[1]) = 'enum') and @display-inline = 'no-display-inline'">
						<p style="text-align:left" class="lbexIndent">
							<xsl:call-template name="ActualPrintText"/>
						</p>
					</xsl:when>
					<xsl:when
						test="local-name(preceding-sibling::*[1]) = 'committee-report-header' and not(@display-inline = 'yes-display-inline')">
						<p style="text-align:left" class="lbexIndent">
							<xsl:call-template name="ActualPrintText"/>
						</p>
						<xsl:if test="not(following-sibling::*)">
							<p/>
						</xsl:if>
					</xsl:when>
					<xsl:when
						test="local-name(preceding-sibling::*[1]) = 'committee-report-header' or local-name(preceding-sibling::*[1]) = 'enum'">
						<span style="text-align:left" class="lbexIndent">
							<xsl:call-template name="ActualPrintText"/>
						</span>
						<xsl:if test="not(following-sibling::*)">
							<p/>
						</xsl:if>
					</xsl:when>
					<xsl:when
						test="(local-name(preceding-sibling::*[1]) = 'text' or local-name(preceding-sibling::*[1]) = 'committee-report-para')">
						<div style="text-align:left" class="lbexIndent">
							<xsl:call-template name="ActualPrintText"/>
						</div>
						<xsl:if test="not(following-sibling::*)">
							<p/>
						</xsl:if>
					</xsl:when>
					<xsl:when
						test="parent::committee-report-para and ancestor::committee-report-segment">
						<div style="text-align:left" class="lbexIndent">
							<xsl:call-template name="ActualPrintText"/>
						</div>
						<xsl:if test="not(parent::*/following-sibling::*)">
							<p/>
						</xsl:if>
					</xsl:when>
					<xsl:when test="parent::amendment-instruction">
						<div class="lbexIndent" style="text-align:left">
							<xsl:call-template name="ActualPrintText"/>
						</div>
						<xsl:call-template name="InsertBlankLines">
							<xsl:with-param name="aLinesNumber">
								<xsl:choose>
									<xsl:when
										test="parent::amendment-instruction/@blank-lines-after">
										<xsl:value-of
											select="parent::amendment-instruction/@blank-lines-after"
										/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>1</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>

						</xsl:call-template>
						<xsl:if
							test="not(parent::amendment-instruction/following-sibling::*) and not(parent::amendment-instruction/parent::amendment/following-sibling::*)">
							<p/>
						</xsl:if>
					</xsl:when>
					<xsl:when
						test="(parent::committee-report-para or parent::committee-report-segment) and //amendment-doc">
						<!-- TB 12Dec12 BugFixing #1287 -->
						<table style="width:80%" align="center" class="lbexSmallText">
							<tr>
								<td class="lbexIndent">
									<p style="text-align:left" class="lbexIndent">
										<xsl:call-template name="ActualPrintText"/>
									</p>
								</td>
							</tr>
						</table>
					</xsl:when>
					<xsl:otherwise>
						<p style="text-align:left" class="lbexIndent">
							<xsl:call-template name="ActualPrintText"/>
						</p>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:when>
			<xsl:when test="parent::whereas">
				<xsl:call-template name="ActualPrintText"/>
			</xsl:when>
			<xsl:when test="parent::quoted-block/@display-inline = 'yes-display-inline'">
				<xsl:call-template name="ActualPrintText"/>
			</xsl:when>
			<xsl:when
				test="@display-inline = 'yes-display-inline' and contains(local-name(parent::*), 'rules')">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="contains(local-name(parent::*), 'appropriations')">
				<p style="text-align:left" class="lbexIndent">
					<xsl:call-template name="ActualPrintText"/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p style="text-align:left">
					<xsl:call-template name="ActualPrintText"/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="following-sibling::table">
			<br/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="InsertBlankLines">
		<xsl:param name="aLinesNumber"/>
		<xsl:choose>
			<xsl:when test="$aLinesNumber = '0'"/>
			<xsl:when test="$aLinesNumber = '1'">
				<p/>
			</xsl:when>
			<xsl:when test="$aLinesNumber = '2'">
				<p/>
				<p/>
			</xsl:when>
			<xsl:when test="$aLinesNumber = '3'">
				<p/>
				<p/>
				<p/>
			</xsl:when>
			<xsl:when test="$aLinesNumber = '4'">
				<p/>
				<p/>
				<p/>
				<p/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="subsection">
		<!-- TB Aug 2016 bug fixing 1434 -->
		<xsl:call-template name="printSectionAndDownStructure">
			<xsl:with-param name="thePrintingTemplate">displaySubsection</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="displaySubsection">
		<xsl:call-template name="createAnchor"/>
		<xsl:choose>
			<xsl:when test="./@display-inline = 'yes-display-inline'">
				<!-- TB aug 2012 Bug fixing #1270 -->
				<xsl:if test="parent::quoted-block and not(preceding-sibling::*)">
					<xsl:call-template name="openQuotes"/>
				</xsl:if>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="./@indent = 'down1'">
				<p class="lbexIndentSubsection">
					<xsl:call-template name="ActualPrintSubsection"/>
				</p>
			</xsl:when>
			<xsl:when test="(ancestor::quoted-block/@style = 'traditional')">
				<xsl:choose>
					<xsl:when test="./@display-inline = 'yes-display-inline'">
						<xsl:apply-templates/>
						<p/>
					</xsl:when>
					<xsl:when
						test="./@display-inline = 'no-display-inline' or not(./@display-inline)">
						<p style="text-align:left" class="lbexIndentSubsection">
							<xsl:call-template name="printQuotedText"/>
						</p>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when
				test="(ancestor::quoted-block/@style = 'other' and ancestor::quoted-block/@other-style = 'archaic')">
				<!-- TB 17Aug2009 Added new condition about preceding-sebling::subsection -->
				<xsl:if
					test="header and (not(parent::section or parent::quoted-block/parent::section) or (preceding-sibling::subsection))">
					<p>
						<div style="text-align:center">
							<span class="lbexInitialCapArchaic">
								<xsl:call-template name="openQuotes"/>
								<!--xsl:value-of select="header"/-->
								<xsl:apply-templates select="header">
									<xsl:with-param name="isSpecialPrinting">
										<xsl:text>yes</xsl:text>
									</xsl:with-param>
								</xsl:apply-templates>
							</span>
						</div>
					</p>
				</xsl:if>
				<p style="text-align:left" class="lbexIndentSubsection">
					<xsl:call-template name="openQuotes"/>
					<xsl:apply-templates select="enum"/>
					<xsl:apply-templates select="text"/>
					<!--xsl:apply-templates select="paragraph"/-->
					<!-- TB 15-Dec-2008 continuation text missing in case if after paragraph archaic style -->
					<!--xsl:apply-templates select="continuation-text"/-->
					<xsl:for-each select="child::*">
						<xsl:choose>
							<xsl:when
								test="local-name() = 'enum' or local-name() = 'text' or local-name() = 'header'">
								<!-- nothing -->
							</xsl:when>
							<xsl:when test="local-name() = 'paragraph'">
								<xsl:apply-templates select="."/>
							</xsl:when>
							<xsl:when test="local-name() = 'continuation-text'">
								<xsl:apply-templates select="."/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates/>
							</xsl:otherwise>
						</xsl:choose>

					</xsl:for-each>
				</p>
			</xsl:when>
			<xsl:when
				test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::subparagraph">
				<p style="text-align:left" class="lbexIndentSubpar">
					<xsl:call-template name="printQuotedText"/>
				</p>
			</xsl:when>
			<xsl:when
				test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::clause">
				<p style="text-align:left" class="lbexIndentClause">
					<xsl:call-template name="printQuotedText"/>
				</p>
			</xsl:when>
			<xsl:when
				test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::subclause">
				<p style="text-align:left" class="lbexIndentSubclause">
					<xsl:call-template name="printQuotedText"/>
				</p>
			</xsl:when>
			<xsl:when
				test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::item">
				<p style="text-align:left" class="lbexIndentItem">
					<xsl:call-template name="printQuotedText"/>
				</p>
			</xsl:when>
			<xsl:when
				test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::subitem">
				<p style="text-align:left" class="lbexIndentSubItem">
					<xsl:call-template name="printQuotedText"/>
				</p>
			</xsl:when>
			<xsl:when
				test="ancestor::*[@reported-display-style = 'boldface-roman']/parent::quoted-block[@style = 'tax']">
				<span class="lbexSectionlevelOLCBold">
					<p style="text-align:left" class="lbexIndentSubsection">
						<xsl:call-template name="printQuotedText"/>
					</p>
				</span>
			</xsl:when>
			<xsl:when test="(ancestor::quoted-block/after-quoted-block = '.')">
				<p style="text-align:left" class="lbexIndentSubsection">
					<!-- TB 24Jan2011 test the case -->
					<!--xsl:call-template name="printQuotedText"/-->
					<xsl:call-template name="ActualPrintSubsection"/>
				</p>
			</xsl:when>
			<xsl:when
				test="parent::section/@section-type = 'undesignated-section' and $billType = 'traditional'">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="./@indent = 'down1'">
				<p style="text-align:left" class="lbexIndentSubsection">
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when
				test="
					(parent::section and child::enum = '' and child::text/@display-inline = 'yes-display-inline')
					or (parent::section and child::enum = not('') and child::text/@display-inline = 'yes-display-inline' and
					$billType = 'traditional' and position() = 1)">
				<xsl:call-template name="ActualPrintSubsection"/>
			</xsl:when>
			<xsl:when
				test="parent::section and child::enum = not('') and child::text/@display-inline = 'yes-display-inline'">
				<xsl:call-template name="ActualPrintSubsection"/>
			</xsl:when>
			<xsl:when test="parent::section and child::text/@display-inline = 'yes-display-inline'">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="ActualPrintSubsection"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ********************Actual Print Subsection Text******************* -->
	<xsl:template name="ActualPrintSubsection">
		<p style="text-align:left" class="lbexIndent">
			<xsl:variable name="appropReportedStyle">
				<xsl:call-template name="getAppropriationReportingStyle"/>
			</xsl:variable>
			<!--<xsl:if
				test="$appropReportedStyle = 'bold-brackets' and not(ancestor::appropriations-major or ancestor::appropriations-intermediate or ancestor::appropriations-small)">
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
			</xsl:if>-->
			<xsl:choose>
			 	<xsl:when test="$appropReportedStyle = 'strikethrough'">
					 <span class="lbexTextStrikethrough">
						<xsl:call-template name="ActualPrintText"/>
					</span>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="ActualPrintText"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:variable name="isToCloseTheBrackets">
				<xsl:call-template name="toCloseTheBrakets"/>
			</xsl:variable>
			<xsl:choose>
				<xsl:when
					test="$appropReportedStyle = 'bold-brackets' and $isToCloseTheBrackets = 'yes' and not(ancestor::appropriations-major or ancestor::appropriations-intermediate or ancestor::appropriations-small) and child::text">
					<span class="lbexBrakets">
						<xsl:text></xsl:text>
					</span>
				</xsl:when>
			<xsl:when
					test="$appropReportedStyle = 'bold-brackets' and $isToCloseTheBrackets = 'yes' and not(ancestor::appropriations-major or ancestor::appropriations-intermediate or ancestor::appropriations-small)">
					<span class="lbexBrakets">
						<xsl:text>]</xsl:text>
					</span>
				</xsl:when>
			</xsl:choose>
			<xsl:if
				test="contains($appropReportedStyle, 'parentheses') and $isToCloseTheBrackets = 'yes' and not(ancestor::appropriations-major or ancestor::appropriations-intermediate or ancestor::appropriations-small)">
				<span class="lbexBrakets">
					<xsl:text>)</xsl:text>
				</span>
			</xsl:if>
		</p>
	</xsl:template>

	<!-- TB to be reviewed  -->
	<xsl:template match="subsection/paragraph/subparagraph[@indent = 'up1']/quoted-block/subsection">
		<p style="text-align:left" class="lbexIndentSubsection">
			<xsl:if test="ancestor::quoted-block">
				<xsl:call-template name="openQuotes"/>
			</xsl:if>
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="paragraph">
		<!-- TB Aug 2016 bug fixing 1434 -->
		<xsl:call-template name="printSectionAndDownStructure">
			<xsl:with-param name="thePrintingTemplate">displayParagraph</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- **********Get Ancestor Dissplay Style Bug #955***************** -->
	<xsl:template name="getAncDisplayStyle">
		<!--check several levels up-->
		<xsl:choose>
			<xsl:when test="@reported-display-style and @reported-display-style != ''">
				<xsl:value-of select="@reported-display-style"/>
			</xsl:when>
			<xsl:when test="@deleted-display-style and @deleted-display-style != ''">
				<xsl:value-of select="@deleted-display-style"/>
			</xsl:when>
			<xsl:when test="@added-display-style and @added-display-style != ''">
				<xsl:value-of select="@added-display-style"/>
			</xsl:when>
			<xsl:when test="@changed = 'not-changed'">
				<!-- nothing -->
			</xsl:when>
			<!-- ******************************************************************************** -->
			<xsl:when
				test="parent::*/@reported-display-style and parent::*/@reported-display-style != ''">
				<xsl:value-of select="parent::*/@reported-display-style"/>
			</xsl:when>
			<xsl:when
				test="parent::*/@deleted-display-style and parent::*/@deleted-display-style != ''">
				<xsl:value-of select="parent::*/@deleted-display-style"/>
			</xsl:when>
			<xsl:when test="parent::*/@added-display-style and parent::*/@added-display-style != ''">
				<xsl:value-of select="parent::*/@added-display-style"/>
			</xsl:when>
			<xsl:when test="parent::*/@changed = 'not-changed'">
				<!-- nothing -->
			</xsl:when>
			<!-- ******************************************************************************** -->
			<xsl:when
				test="ancestor::*[2]/@reported-display-style and ancestor::*[2]/@reported-display-style != ''">
				<xsl:value-of select="ancestor::*[2]/@reported-display-style"/>
			</xsl:when>
			<xsl:when
				test="ancestor::*[2]/@deleted-display-style and ancestor::*[2]/@deleted-display-style != ''">
				<xsl:value-of select="ancestor::*[2]/@deleted-display-style"/>
			</xsl:when>
			<xsl:when
				test="ancestor::*[2]/@added-display-style and ancestor::*[2]/@added-display-style != ''">
				<xsl:value-of select="ancestor::*[2]/@added-display-style"/>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/@changed = 'not-changed'">
				<!-- nothing -->
			</xsl:when>
			<!-- ******************************************************************************** -->
			<xsl:when
				test="ancestor::*[3]/@reported-display-style and ancestor::*[3]/@reported-display-style != ''">
				<xsl:value-of select="ancestor::*[3]/@reported-display-style"/>
			</xsl:when>
			<xsl:when
				test="ancestor::*[3]/@deleted-display-style and ancestor::*[3]/@deleted-display-style != ''">
				<xsl:value-of select="ancestor::*[3]/@deleted-display-style"/>
			</xsl:when>
			<xsl:when
				test="ancestor::*[3]/@added-display-style and ancestor::*[3]/@added-display-style != ''">
				<xsl:value-of select="ancestor::*[3]/@added-display-style"/>
			</xsl:when>
			<xsl:when test="ancestor::*[3]/@changed = 'not-changed'">
				<!-- nothing -->
			</xsl:when>
			<!-- ******************************************************************************** -->
			<xsl:when
				test="ancestor::*[4]/@reported-display-style and ancestor::*[4]/@reported-display-style != ''">
				<xsl:value-of select="ancestor::*[4]/@reported-display-style"/>
			</xsl:when>
			<xsl:when
				test="ancestor::*[4]/@deleted-display-style and ancestor::*[4]/@deleted-display-style != ''">
				<xsl:value-of select="ancestor::*[4]/@deleted-display-style"/>
			</xsl:when>
			<xsl:when
				test="ancestor::*[4]/@added-display-style and ancestor::*[4]/@added-display-style != ''">
				<xsl:value-of select="ancestor::*[4]/@added-display-style"/>
			</xsl:when>
		</xsl:choose>

	</xsl:template>
	<!--*************End bug #955******************************************-->
	<!--**************TB Feb2012 - to make indentation to work in Firefox - trick with additional zero level bug #1247********************-->
	<xsl:template name="zeroindentlevel">
		<xsl:param name="aLevelToIndent"/>
		<xsl:choose>
			<xsl:when
				test="
					$aLevelToIndent = 'lbexIndentParagraph' or $aLevelToIndent = 'lbexIndentSubpar' or
					$aLevelToIndent = 'lbexIndentClause' or $aLevelToIndent = 'lbexIndentSubclause' or
					$aLevelToIndent = 'lbexIndentItem' or $aLevelToIndent = 'lbexIndentSubItem'">
				<xsl:text>margin-left: -2em;</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>margin-left: 0em;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--*****************************************************************-->
	<xsl:template name="displayParagraph">
		<xsl:call-template name="createAnchor"/>
		<xsl:variable name="appropReportedStyle">
			<xsl:call-template name="getAppropriationReportingStyle"/>
		</xsl:variable>
		<xsl:variable name="isLastElement">
			<xsl:call-template name="isLastElementInLoop"/>
		</xsl:variable>
		<xsl:variable name="isToCloseTheBrackets">
			<xsl:call-template name="toCloseTheBrakets"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="(@display-inline = 'yes-display-inline' and @commented='yes')">
				<!-- vonditions with the bold bracket - TB June 2012 Bug #1261 -->
				<!--<xsl:if test="@commented='yes'">-->
				<xsl:choose>
					<xsl:when test=" parent::*[current()]/@commented='yes'"></xsl:when>
				<xsl:otherwise>
						<span class="lbexBrakets">
							<xsl:text>[</xsl:text>
						</span>
					</xsl:otherwise>
				</xsl:choose>
				<!--</xsl:if>-->
				<!-- TB aug 2012 Bug fixing #1270 -->
				<xsl:if test="parent::quoted-block and not(preceding-sibling::*)">
					<xsl:call-template name="openQuotes"/>
				</xsl:if>
				<xsl:apply-templates/>
				<xsl:choose>
					<xsl:when test=" parent::*[current()]/@commented='yes'"></xsl:when>
					<xsl:otherwise>
						<span class="lbexBrakets">
							<xsl:text>]</xsl:text>
						</span>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:when>
			<xsl:otherwise>
				<!-- TB 1Feb2012 one more paragraph with back to zero indentation applied - to support 
					indentation in Firefox. transparent for other browsers -->
				<xsl:variable name="bringIndentToZeroAttr">
					<xsl:call-template name="zeroindentlevel">
						<xsl:with-param name="aLevelToIndent">lbexIndentSubsection</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="contains(@display-inline, 'yes-display-inline')">
						<xsl:choose>
						<xsl:when
								test="./@indent = 'up1' and parent::quoted-block/parent::paragraph">
							<p style="text-align:left" class="lbexIndentSubsection">
								<xsl:if
										test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:if test="contains($appropReportedStyle, 'parentheses')">
									<span class="lbexBrakets">
										<xsl:text>(</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="printQuotedText"/>
								<xsl:if
										test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when test="./@indent = 'up1'">
							<p style="text-align:left" class="lbexIndentSubsection">
								<xsl:if
										test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="ActualPrintText"/>
								<xsl:if
										test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when test="quoted-block/toc | quoted-block/subsection">
							<p class="lbexIndentParagraph" style="text-align:left">
								<span class="lbexIndent">
									<xsl:if
											test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
										<span class="lbexBrakets">
											<xsl:text>[</xsl:text>
										</span>
									</xsl:if>
									<xsl:apply-templates select="enum"/>
									<xsl:apply-templates select="header"/>
									<xsl:apply-templates select="text"/>
									<xsl:choose>
										<xsl:when
												test="quoted-block/@display-inline = 'yes-display-inline'">
											<xsl:apply-templates select="quoted-block"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates select="quoted-block"/>
										</xsl:otherwise>
									</xsl:choose>
								</span>
								<xsl:if
										test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
							<p class="lbexIndentParagraph" style="text-align:left">
								<xsl:apply-templates select="subparagraph"/>
							</p>
							<xsl:apply-templates select="continuation-text"/>
						</xsl:when>
						<xsl:when
								test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::paragraph">
							<p style="text-align:left" class="lbexIndentSubsection">
								<xsl:if
										test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="printQuotedText"/>
								<xsl:if
										test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when
								test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::subparagraph">
							<p class="lbexIndentSubpar" style="text-align:left">
								<xsl:if
										test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="printQuotedText"/>
								<xsl:if
										test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when
								test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::clause">
							<p class="lbexIndentClause" style="text-align:left">
								<xsl:if
										test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="printQuotedText"/>
								<xsl:if
										test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when
								test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::subclause">
							<p class="lbexIndentSubclause" style="text-align:left">
								<xsl:if
										test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="printQuotedText"/>
								<xsl:if
										test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when
								test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::item">
							<p class="lbexIndentItem" style="text-align:left">
								<xsl:if
										test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="printQuotedText"/>
								<xsl:if
										test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when
								test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::subitem">
							<p class="lbexIndentSubItem" style="text-align:left">
								<xsl:if
										test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="printQuotedText"/>
								<xsl:if
										test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when test="parent::subsection/@indent = 'down1'">
							<p style="text-align:left" class="lbexIndentSubsection">
								<xsl:if
										test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="ActualPrintText"/>
								<xsl:if
										test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when
								test="(ancestor::quoted-block) and (not(@display-inline) or contains(@display-inline, 'no-display-inline'))">
							<p style="text-align:left" class="lbexIndentParagraph">
							<xsl:if
										test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
								<span class="lbexBrakets">
									<xsl:text>[</xsl:text>
								</span>
							</xsl:if>
							
							<xsl:choose>
								<xsl:when test="$appropReportedStyle = 'strikethrough'">
									<span class="lbexTextStrikethrough">
										<xsl:call-template name="printQuotedText"/>
									</span>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="printQuotedText"/>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:if
										test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
								<span class="lbexBrakets">
									<xsl:text>]</xsl:text>
								</span>
							</xsl:if>
							</p>
						</xsl:when>
						<xsl:when
								test="(ancestor::quoted-block) and contains(@display-inline, 'yes-display-inline')">
							
								<xsl:if
									test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								
								<xsl:choose>
									<xsl:when test="$appropReportedStyle = 'strikethrough'">
										<span class="lbexTextStrikethrough">
											<xsl:call-template name="printQuotedText"/>
										</span>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="printQuotedText"/>
									</xsl:otherwise>
								</xsl:choose>
								
								<xsl:if
									test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							
						</xsl:when>
						<xsl:when
								test="(ancestor::subparagraph/quoted-block or parent::quoted-block[@style = 'OLC']/parent::paragraph)">
							<p style="text-align:left" class="lbexIndentSubsection">
								<xsl:if
										test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="printQuotedText"/>
								<xsl:if
										test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>

						<xsl:when test="parent::whereas">
							<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
						</xsl:when>
						<xsl:otherwise>
						<xsl:choose>
							<xsl:when
										test="contains(@display-inline, 'no-display-inline') or not(@display-inline)">
								<p style="text-align:left" class="lbexIndentParagraph">
									<xsl:if
												test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
										<span class="lbexBrakets">
											<xsl:text>[</xsl:text>
										</span>
									</xsl:if>
									<xsl:if
												test="($appropReportedStyle = 'parentheses' or $appropReportedStyle = 'parentheses-boldface-roman' or $appropReportedStyle = 'parentheses-boldface-italic')">
										<span class="lbexBrakets">
											<xsl:text>(</xsl:text>
										</span>
									</xsl:if>
									<xsl:choose>
										<xsl:when
												test="$appropReportedStyle = 'strikethrough'">
											<span class="lbexTextStrikethrough">
												<xsl:apply-templates/>
											</span>
										</xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates/>
										</xsl:otherwise>
									</xsl:choose>

									<xsl:if
												test="(contains($appropReportedStyle, 'brackets')) and $isToCloseTheBrackets = 'yes'">
										<span class="lbexBrakets">
											<xsl:text>]</xsl:text>
										</span>
									</xsl:if>
									<xsl:if
												test="(($appropReportedStyle = 'parentheses-boldface-roman' or $appropReportedStyle = 'parentheses-boldface-italic' or $appropReportedStyle = 'parentheses') and $isToCloseTheBrackets = 'yes')">
										<span class="lbexBrakets">
											<xsl:text>)</xsl:text>
										</span>
									</xsl:if>
								</p>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if
											test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text></xsl:text>
									</span>
								</xsl:if>
								<xsl:if
											test="($appropReportedStyle = 'parentheses' or $appropReportedStyle = 'parentheses-boldface-roman' or $appropReportedStyle = 'parentheses-boldface-italic')">
									<span class="lbexBrakets">
										<xsl:text>(</xsl:text>
									</span>
								</xsl:if>
								<xsl:choose>
									<xsl:when
												test="$appropReportedStyle = 'strikethrough' and @display-inline = 'yes-dispaly-inline'">
										<span class="lbexTextStrikethrough">
											<xsl:apply-templates/>
										</span>
									</xsl:when>
									<xsl:when
												test="$appropReportedStyle = 'strikethrough' and (not(@display-inline) or @display-inline = 'no-display-inline')">
										<div class="lbexIndentParagraph">
											<span class="lbexTextStrikethrough">
												<xsl:apply-templates/>
											</span>
										</div>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates/>
									</xsl:otherwise>
								</xsl:choose>

								<xsl:if
											test="(contains($appropReportedStyle, 'brackets')) and $isToCloseTheBrackets = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
								<xsl:if
											test="(($appropReportedStyle = 'parentheses-boldface-roman' or $appropReportedStyle = 'parentheses-boldface-italic' or $appropReportedStyle = 'parentheses') and $isToCloseTheBrackets = 'yes')">
									<span class="lbexBrakets">
										<xsl:text>)</xsl:text>
									</span>
								</xsl:if>

							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
					</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
							<p>
					<xsl:attribute name="style">
						<xsl:value-of select="$bringIndentToZeroAttr"/>
					</xsl:attribute>
					<xsl:choose>
						<xsl:when
									test="./@indent = 'up1' and parent::quoted-block/parent::paragraph">
							<p style="text-align:left" class="lbexIndentSubsection">
								<xsl:if
											test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:if test="contains($appropReportedStyle, 'parentheses')">
									<span class="lbexBrakets">
										<xsl:text>(</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="printQuotedText"/>
								<xsl:if
											test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when test="./@indent = 'up1'">
							<p style="text-align:left" class="lbexIndentSubsection">
								<xsl:if
											test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="ActualPrintText"/>
								<xsl:if
											test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or (@commented = 'yes' and not(child::text))">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when test="quoted-block/toc | quoted-block/subsection">
							<p class="lbexIndentParagraph" style="text-align:left">
								<span class="lbexIndent">
									<xsl:if
												test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
										<span class="lbexBrakets">
											<xsl:text>[</xsl:text>
										</span>
									</xsl:if>
									<xsl:apply-templates select="enum"/>
									<xsl:apply-templates select="header"/>
									<xsl:apply-templates select="text"/>
									<xsl:choose>
										<xsl:when
												test="quoted-block/@display-inline = 'yes-display-inline'">
											<xsl:apply-templates select="quoted-block"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates select="quoted-block"/>
										</xsl:otherwise>
									</xsl:choose>
								</span>
								<xsl:if
											test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
							<p class="lbexIndentParagraph" style="text-align:left">
								<xsl:apply-templates select="subparagraph"/>
							</p>
							<xsl:apply-templates select="continuation-text"/>
						</xsl:when>
						<xsl:when
									test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::paragraph">
							<p style="text-align:left" class="lbexIndentSubsection">
								<xsl:if
											test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="printQuotedText"/>
								<xsl:if
											test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when
									test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::subparagraph">
							<p class="lbexIndentSubpar" style="text-align:left">
								<xsl:if
											test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="printQuotedText"/>
								<xsl:if
											test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when
									test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::clause">
							<p class="lbexIndentClause" style="text-align:left">
								<xsl:if
											test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="printQuotedText"/>
								<xsl:if
											test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when
									test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::subclause">
							<p class="lbexIndentSubclause" style="text-align:left">
								<xsl:if
											test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="printQuotedText"/>
								<xsl:if
											test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when
									test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::item">
							<p class="lbexIndentItem" style="text-align:left">
								<xsl:if
											test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="printQuotedText"/>
								<xsl:if
											test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when
									test="parent::quoted-block[@display-inline = 'yes-display-inline']/parent::subitem">
							<p class="lbexIndentSubItem" style="text-align:left">
								<xsl:if
											test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="printQuotedText"/>
								<xsl:if
											test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when test="parent::subsection/@indent = 'down1'">
							<p style="text-align:left" class="lbexIndentSubsection">
								<xsl:if
											test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="ActualPrintText"/>
								<xsl:if
											test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>
						<xsl:when
									test="(ancestor::quoted-block) and (not(@display-inline) or contains(@display-inline, 'no-display-inline'))">
							<p style="text-align:left" class="lbexIndentParagraph">
							<xsl:if
											test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
								<span class="lbexBrakets">
									<xsl:text>[</xsl:text>
								</span>
							</xsl:if>
							
							<xsl:choose>
								<xsl:when test="$appropReportedStyle = 'strikethrough'">
									<span class="lbexTextStrikethrough">
										<xsl:call-template name="printQuotedText"/>
									</span>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="printQuotedText"/>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:if
											test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
								<xsl:choose>
									<xsl:when test = "child::text or child::*/@commented='yes'">
								    </xsl:when>
								     <xsl:otherwise>
											<span class="lbexBrakets">
													<xsl:text>]</xsl:text>
											</span>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
							</p>
						</xsl:when>
						<xsl:when
									test="(ancestor::quoted-block) and contains(@display-inline, 'yes-display-inline')">
							
								<xsl:if
										test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								
								<xsl:choose>
									<xsl:when test="$appropReportedStyle = 'strikethrough'">
										<span class="lbexTextStrikethrough">
											<xsl:call-template name="printQuotedText"/>
										</span>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="printQuotedText"/>
									</xsl:otherwise>
								</xsl:choose>
								
								<xsl:if
										test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							
						</xsl:when>
						<xsl:when
									test="(ancestor::subparagraph/quoted-block or parent::quoted-block[@style = 'OLC']/parent::paragraph)">
							<p style="text-align:left" class="lbexIndentSubsection">
								<xsl:if
											test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:call-template name="printQuotedText"/>
								<xsl:if
											test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
							</p>
						</xsl:when>

						<xsl:when test="parent::whereas">
							<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
						</xsl:when>
						<xsl:otherwise>
						<xsl:choose>
							<xsl:when
											test="contains(@display-inline, 'no-display-inline') or not(@display-inline)">
								<p style="text-align:left" class="lbexIndentParagraph">
									<xsl:if
												test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
										<span class="lbexBrakets">
											<xsl:text>[</xsl:text>
										</span>
									</xsl:if>
									<xsl:if
												test="($appropReportedStyle = 'parentheses' or $appropReportedStyle = 'parentheses-boldface-roman' or $appropReportedStyle = 'parentheses-boldface-italic')">
										<span class="lbexBrakets">
											<xsl:text>(</xsl:text>
										</span>
									</xsl:if>
									<xsl:choose>
										<xsl:when
												test="$appropReportedStyle = 'strikethrough'">
											<span class="lbexTextStrikethrough">
												<xsl:apply-templates/>
											</span>
										</xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates/>
										</xsl:otherwise>
									</xsl:choose>

									<xsl:if
													test="((contains($appropReportedStyle, 'brackets')) and $isToCloseTheBrackets = 'yes') or  @commented = 'yes'">
										<xsl:choose>
											<xsl:when test="$isLastElement = 'yes'">	
                                             <xsl:text/>	
											</xsl:when>
										<xsl:otherwise>
												<span class="lbexBrakets">
													<xsl:text>]</xsl:text>
												</span>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:if>
									<xsl:if
												test="(($appropReportedStyle = 'parentheses-boldface-roman' or $appropReportedStyle = 'parentheses-boldface-italic' or $appropReportedStyle = 'parentheses') and $isToCloseTheBrackets = 'yes')">
										<span class="lbexBrakets">
											<xsl:text>)</xsl:text>
										</span>
									</xsl:if>
								</p>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if
												test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-roman' or $appropReportedStyle = 'brackets-boldface-italic') or @commented = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:if>
								<xsl:if
												test="($appropReportedStyle = 'parentheses' or $appropReportedStyle = 'parentheses-boldface-roman' or $appropReportedStyle = 'parentheses-boldface-italic')">
									<span class="lbexBrakets">
										<xsl:text>(</xsl:text>
									</span>
								</xsl:if>
								<xsl:choose>
									<xsl:when
												test="$appropReportedStyle = 'strikethrough' and @display-inline = 'yes-dispaly-inline'">
										<span class="lbexTextStrikethrough">
											<xsl:apply-templates/>
										</span>
									</xsl:when>
									<xsl:when
												test="$appropReportedStyle = 'strikethrough' and (not(@display-inline) or @display-inline = 'no-display-inline')">
										<div class="lbexIndentParagraph">
											<span class="lbexTextStrikethrough">
												<xsl:apply-templates/>
											</span>
										</div>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates/>
									</xsl:otherwise>
								</xsl:choose>

								<xsl:if
												test="(contains($appropReportedStyle, 'brackets')) and $isToCloseTheBrackets = 'yes'">
									<span class="lbexBrakets">
										<xsl:text>]</xsl:text>
									</span>
								</xsl:if>
								<xsl:if
												test="(($appropReportedStyle = 'parentheses-boldface-roman' or $appropReportedStyle = 'parentheses-boldface-italic' or $appropReportedStyle = 'parentheses') and $isToCloseTheBrackets = 'yes')">
									<span class="lbexBrakets">
										<xsl:text>)</xsl:text>
									</span>
								</xsl:if>

							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
					</xsl:choose>
				</p>	
					</xsl:otherwise>
				</xsl:choose>
				
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="subparagraph">
		<!-- TB Aug 2016 bug fixing 1434 -->
		<xsl:call-template name="printSectionAndDownStructure">
			<xsl:with-param name="thePrintingTemplate">displaySubparagraph</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- ************************* Display Sub Paragraph********************************* -->
	<xsl:template name="displaySubparagraph">
		<xsl:call-template name="createAnchor"/>
		<xsl:choose>
			<xsl:when test="./@display-inline = 'yes-display-inline'">
				<xsl:if test="@commented = 'yes'">
					<span class="lbexBrakets">
						<xsl:text>[</xsl:text>
					</span>
				</xsl:if>
				<!-- TB aug 2012 Bug fixing #1270 -->
				<xsl:if test="parent::quoted-block and not(preceding-sibling::*)">
					<xsl:call-template name="openQuotes"/>
				</xsl:if>
				<xsl:apply-templates/>
				<xsl:if test="@commented = 'yes'">
					<span class="lbexBrakets">
						<xsl:text>]</xsl:text>
					</span>
				</xsl:if>
			</xsl:when>

			<xsl:otherwise>
				<xsl:variable name="indentLevel">
					<xsl:call-template name="defineIndentation">
						<xsl:with-param name="aLevelElement">subparagraph</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<!-- TB 1Feb2012 one more paragraph with back to zero indentation applied - to support 
					indentation in Firefox. transparent for other browsers -->
				<xsl:variable name="bringIndentToZeroAttr">
					<xsl:call-template name="zeroindentlevel">
						<xsl:with-param name="aLevelToIndent">
							<xsl:value-of select="$indentLevel"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<p>
					<xsl:attribute name="style">
						<xsl:value-of select="$bringIndentToZeroAttr"/>
					</xsl:attribute>
					<p>
						<xsl:attribute name="class">
							<xsl:value-of select="$indentLevel"/>
						</xsl:attribute>
						<!--xsl:call-template name="ActualPrintSubParagraphWithText"/-->
						<xsl:call-template name="ActualPrintSubParagraphWithTextNoClass"/>
					</p>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--***************************Indentation****************************************************************-->
	<xsl:template name="defineIndentation">
		<xsl:param name="aLevelElement"/>
		<xsl:param name="aUseParent"/>
		<xsl:choose>
			<!-- *****************************Paragraph********************************* -->
			<xsl:when test="$aLevelElement = 'paragraph' and $aUseParent = 'true'">
				<xsl:call-template name="defineIndentationParagraphByParent"/>
			</xsl:when>
			<xsl:when test="$aLevelElement = 'paragraph'">
				<xsl:call-template name="defineIndentationParagraph"/>
			</xsl:when>
			<!-- **************************Subparagraph********************************* -->
			<xsl:when test="$aLevelElement = 'subparagraph' and $aUseParent = 'true'">
				<xsl:call-template name="defineIndentationSubParagraphByParent"/>
			</xsl:when>
			<xsl:when test="$aLevelElement = 'subparagraph'">
				<xsl:call-template name="defineIndentationSubParagraph"/>
			</xsl:when>
			<!-- ****************************Clause************************************ -->
			<xsl:when test="$aLevelElement = 'clause' and $aUseParent = 'true'">
				<xsl:call-template name="defineIndentationClauseByParent"/>
			</xsl:when>
			<xsl:when test="$aLevelElement = 'clause'">
				<xsl:call-template name="defineIndentationClause"/>
			</xsl:when>
			<!-- **************************Subclause********************************** -->
			<xsl:when test="$aLevelElement = 'subclause' and $aUseParent = 'true'">
				<xsl:call-template name="defineIndentationSubclauseByParent"/>
			</xsl:when>
			<xsl:when test="$aLevelElement = 'subclause'">
				<xsl:call-template name="defineIndentationSubclause"/>
			</xsl:when>
			<!-- **************************Item********************************** -->
			<xsl:when test="$aLevelElement = 'item' and $aUseParent = 'true'">
				<xsl:call-template name="defineIndentationItemByParent"/>
			</xsl:when>
			<xsl:when test="$aLevelElement = 'item'">
				<xsl:call-template name="defineIndentationItem"/>
			</xsl:when>
			<!-- **************************Subitem********************************** -->

			<xsl:when test="$aLevelElement = 'subitem' and $aUseParent = 'true'">
				<xsl:call-template name="defineIndentationSubitemByParent"/>
			</xsl:when>
			<xsl:when test="$aLevelElement = 'subitem'">
				<xsl:call-template name="defineIndentationSubitem"/>
			</xsl:when>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="defineIndentationParagraph">
		<!--I am a paragraph element-->
		<xsl:choose>
			<xsl:when
				test="preceding-sibling::paragraph/@display-inline = 'yes-display-inline' and parent::subsection">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up1' or ./@indent = 'up1'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="defineIndentationParagraphByParent">
		<!--I am a paragraph element-->
		<xsl:choose>
			<xsl:when
				test="parent::*/preceding-sibling::paragraph/@display-inline = 'yes-display-inline' and ancestor::*[2]/subsection">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:when test="./@indent = 'up1' or ../@indent = 'up1'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="defineIndentationSubParagraph">
		<!--I am a subparagraph element-->
		<xsl:choose>
			<xsl:when
				test="(preceding-sibling::subparagraph[@display-inline = 'yes-display-inline']) and not(parent::paragraph/@display-inline = 'yes-display-inline') and not(parent::paragraph/@indent = 'up1')">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="(preceding-sibling::subparagraph[@display-inline = 'yes-display-inline']) and (parent::paragraph/@display-inline = 'yes-display-inline' or parent::paragraph/@indent = 'up1')">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!-- TB Mar-31-2015 Bug Fixing #1381 -->
			<!--xsl:when
				test="preceding-sibling::subparagraph[@indent='up1'] or @indent='up1' or ./@indent='up1'">
				<xsl:text>lbexIndentParagraph</xsl:text>
				</xsl:when-->
			<xsl:when test="@indent = 'up1' or ./@indent = 'up1'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<!--xsl:when
				test="preceding-sibling::subparagraph[@indent='up2'] or @indent='up2' or ./@indent='up2'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when-->
			<xsl:when test="@indent = 'up2' or ./@indent = 'up2'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:when test="parent::paragraph[@display-inline = 'yes-display-inline']">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="parent::paragraph/@indent = 'up1'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="parent::paragraph/@indent = 'up2'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:when
				test="local-name() = 'continuation-text' and local-name(ancestor::*[2]) = 'paragraph' and ancestor::*[2]/@indent = 'up1' and parent::*/preceding-sibling::subparagraph/@display-inline = 'yes-display-inline'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:when
				test="local-name() = 'continuation-text' and local-name(ancestor::*[2]) = 'paragraph' and ancestor::*[2]/@indent = 'up1'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="defineIndentationSubParagraphByParent">
		<!--I am a subparagraph element-->
		<xsl:choose>
			<xsl:when
				test="(parent::*/preceding-sibling::subparagraph[@display-inline = 'yes-display-inline']) and not(ancestor::*[2]/paragraph/@display-inline = 'yes-display-inline') and not(ancestor::*[2]/paragraph/@indent = 'up1')">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="(parent::*/preceding-sibling::subparagraph[@display-inline = 'yes-display-inline']) and (ancestor::*[2]/paragraph/@display-inline = 'yes-display-inline' or ancestor::*[2]/paragraph/@indent = 'up1')">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/preceding-sibling::subparagraph[@indent = 'up1'] or ./@indent = 'up1' or ../@indent = 'up1'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/preceding-sibling::subparagraph[@indent = 'up2'] or ./@indent = 'up2' or ../@indent = 'up2'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/paragraph[@display-inline = 'yes-display-inline']">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/paragraph/@indent = 'up1'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/paragraph/@indent = 'up2'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="defineIndentationClause">
		<!--I am a clause element-->
		<xsl:variable name="parentDisplayInLineCount">
			<xsl:call-template name="countParentDisplayInlineMax2"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when
				test="(preceding-sibling::clause[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '0'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="(preceding-sibling::clause[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '1'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="(preceding-sibling::clause[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '2'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!-- ************************************************** -->
			<xsl:when test="$parentDisplayInLineCount = '1'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '2'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<!-- TB Mar-31-2015 bug fixing #1381 -->
			<!--xsl:when
				test="preceding-sibling::clause[@indent='up1'] or @indent='up1' or ./@indent='up1'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::clause[@indent='up2'] or @indent='up2' or ./@indent='up2'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::clause[@indent='up3'] or @indent='up3' or ./@indent='up3'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when-->
			<xsl:when test="@indent = 'up1' or ./@indent = 'up1'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up2' or ./@indent = 'up2'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up3' or ./@indent = 'up3'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when test="parent::subparagraph/@indent = 'up1'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="parent::subparagraph/@indent = 'up2'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="parent::subparagraph/@indent = 'up3'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:when test="parent::paragraph/@indent = 'up1'">
				<!-- in this case my parent subparagraph does not have this attribute -->
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="parent::paragraph/@indent = 'up2'">
				<!-- in this case my parent subparagraph does not have this attribute -->
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="defineIndentationClauseByParent">
		<!--I am a clause element-->
		<xsl:variable name="parentDisplayInLineCount">
			<xsl:call-template name="countParentDisplayInlineMax2"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when
				test="(parent::*/preceding-sibling::clause[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '0'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="(parent::*/preceding-sibling::clause[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '1'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="(parent::*/preceding-sibling::clause[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '2'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!-- ************************************************** -->
			<xsl:when test="$parentDisplayInLineCount = '1'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '2'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when
				test="parent::*/preceding-sibling::clause[@indent = 'up1'] or ./@indent = 'up1' or ../@indent = 'up1'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/preceding-sibling::clause[@indent = 'up2'] or ./@indent = 'up2' or ../@indent = 'up2'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/preceding-sibling::clause[@indent = 'up3'] or ./@indent = 'up3' or ../@indent = 'up3'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when test="ancestor::*[2]/subparagraph/@indent = 'up1'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/subparagraph/@indent = 'up2'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/subparagraph/@indent = 'up3'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/paragraph/@indent = 'up1'">
				<!-- in this case my parent subparagraph does not have this attribute -->
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/paragraph/@indent = 'up2'">
				<!-- in this case my parent subparagraph does not have this attribute -->
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="defineIndentationSubclause">
		<!--I am a subclause element-->
		<xsl:variable name="parentDisplayInLineCount">
			<xsl:call-template name="countParentDisplayInlineMax3"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when
				test="(preceding-sibling::subclause[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '0'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when
				test="(preceding-sibling::subclause[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '1'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="(preceding-sibling::subclause[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '2'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="(preceding-sibling::subclause[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '3'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!-- ************************************************** -->
			<xsl:when test="$parentDisplayInLineCount = '1'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '2'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '3'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<!-- TB Mar-31-2015 Bug Fixing #1381 -->
			<!--xsl:when
				test="preceding-sibling::subclause[@indent='up1'] or @indent='up1' or ./@indent='up1'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::subclause[@indent='up2'] or @indent='up2' or ./@indent='up2'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::subclause[@indent='up3'] or @indent='up3' or ./@indent='up3'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::subclause[@indent='up4'] or @indent='up4' or ./@indent='up4'">
				<xsl:text>lbexIndentSubsection</xsl:text>
				</xsl:when-->

			<xsl:when test="@indent = 'up1' or ./@indent = 'up1'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up2' or ./@indent = 'up2'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up3' or ./@indent = 'up3'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up4' or ./@indent = 'up4'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when test="parent::clause/@indent = 'up1'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="parent::clause/@indent = 'up2'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="parent::clause/@indent = 'up3'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="parent::clause/@indent = 'up4'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<!-- in this case my parent clause does not have this attribute -->
			<xsl:when test="parent::subparagraph/@indent = 'up1'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="parent::subparagraph/@indent = 'up2'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="parent::subparagraph/@indent = 'up3'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<!-- ***************************************************** -->
			<xsl:when test="parent::paragraph/@indent = 'up1'">
				<!-- in this case my parent subparagraph does not have this attribute -->
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="parent::paragraph/@indent = 'up2'">
				<!-- in this case my parent subparagraph does not have this attribute -->
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="defineIndentationSubclauseByParent">
		<!--I am a subclause element-->
		<xsl:variable name="parentDisplayInLineCount">
			<xsl:call-template name="countParentDisplayInlineMax3"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when
				test="(parent::*/preceding-sibling::subclause[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '0'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when
				test="(parent::*/preceding-sibling::subclause[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '1'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="(parent::*/preceding-sibling::subclause[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '2'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="(parent::*/preceding-sibling::subclause[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '3'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!-- ************************************************** -->
			<xsl:when test="$parentDisplayInLineCount = '1'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '2'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '3'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when
				test="parent::*/preceding-sibling::subclause[@indent = 'up1'] or ./@indent = 'up1' or ../@indent = 'up1'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/preceding-sibling::subclause[@indent = 'up2'] or ./@indent = 'up2' or ../@indent = 'up2'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/preceding-sibling::subclause[@indent = 'up3'] or ./@indent = 'up3' or ../@indent = 'up3'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/preceding-sibling::subclause[@indent = 'up4'] or ./@indent = 'up4' or ../@indent = 'up4'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when test="ancestor::*[2]/clause/@indent = 'up1'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/clause/@indent = 'up2'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/clause/@indent = 'up3'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/clause/@indent = 'up4'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<!-- in this case my parent clause does not have this attribute -->
			<xsl:when test="ancestor::*[2]/subparagraph/@indent = 'up1'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/subparagraph/@indent = 'up2'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/subparagraph/@indent = 'up3'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<!-- ***************************************************** -->
			<xsl:when test="ancestor::*[2]/paragraph/@indent = 'up1'">
				<!-- in this case my parent subparagraph does not have this attribute -->
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/paragraph/@indent = 'up2'">
				<!-- in this case my parent subparagraph does not have this attribute -->
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="defineIndentationItem">
		<!--I am a item element-->
		<xsl:variable name="parentDisplayInLineCount">
			<xsl:call-template name="countParentDisplayInlineMax4"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when
				test="(preceding-sibling::item[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '0'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when
				test="(preceding-sibling::item[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '1'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when
				test="(preceding-sibling::item[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '2'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="(preceding-sibling::item[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '3'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="(preceding-sibling::item[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '4'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!-- ************************************************** -->
			<xsl:when test="$parentDisplayInLineCount = '1'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '2'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '3'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '4'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<!-- TB Mar-31-2015 Bug Fixing #1381 -->
			<!--xsl:when
				test="preceding-sibling::item[@indent='up1'] or @indent='up1' or ./@indent='up1'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::item[@indent='up2'] or @indent='up2' or ./@indent='up2'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::item[@indent='up3'] or @indent='up3' or ./@indent='up3'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::item[@indent='up4'] or @indent='up4' or ./@indent='up4'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::item[@indent='up5'] or @indent='up5' or ./@indent='up5'">
				<xsl:text>lbexIndentSubsection</xsl:text>
				</xsl:when-->
			<xsl:when test="@indent = 'up1' or ./@indent = 'up1'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up2' or ./@indent = 'up2'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up3' or ./@indent = 'up3'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up4' or ./@indent = 'up4'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up5' or ./@indent = 'up5'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when test="parent::subclause/@indent = 'up1'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="parent::subclause/@indent = 'up2'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="parent::subclause/@indent = 'up3'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="parent::subclause/@indent = 'up4'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="parent::subclause/@indent = 'up5'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when test="parent::clause/@indent = 'up1'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="parent::clause/@indent = 'up2'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="parent::clause/@indent = 'up3'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="parent::clause/@indent = 'up4'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<!-- in this case my parent clause does not have this attribute -->
			<xsl:when test="parent::subparagraph/@indent = 'up1'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="parent::subparagraph/@indent = 'up2'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="parent::subparagraph/@indent = 'up3'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<!-- ***************************************************** -->
			<xsl:when test="parent::paragraph/@indent = 'up1'">
				<!-- in this case my parent subparagraph does not have this attribute -->
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="parent::paragraph/@indent = 'up2'">
				<!-- in this case my parent subparagraph does not have this attribute -->
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="defineIndentationItemByParent">
		<!--I am a item element-->
		<xsl:variable name="parentDisplayInLineCount">
			<xsl:call-template name="countParentDisplayInlineMax4"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when
				test="(parent::*/preceding-sibling::item[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '0'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when
				test="(parent::*/preceding-sibling::item[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '1'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when
				test="(parent::*/preceding-sibling::item[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '2'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="(parent::*/preceding-sibling::item[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '3'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="(parent::*/preceding-sibling::item[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '4'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!-- ************************************************** -->
			<xsl:when test="$parentDisplayInLineCount = '1'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '2'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '3'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '4'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when
				test="parent::*/preceding-sibling::item[@indent = 'up1'] or ./@indent = 'up1' or ../@indent = 'up1'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/preceding-sibling::item[@indent = 'up2'] or ./@indent = 'up2' or ../@indent = 'up2'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/preceding-sibling::item[@indent = 'up3'] or ./@indent = 'up3' or ../@indent = 'up3'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/preceding-sibling::item[@indent = 'up4'] or ./@indent = 'up4' or ../@indent = 'up4'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/preceding-sibling::item[@indent = 'up5'] or ./@indent = 'up5' or ../@indent = 'up5'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when test="ancestor::*[2]/subclause/@indent = 'up1'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/subclause/@indent = 'up2'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/subclause/@indent = 'up3'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/subclause/@indent = 'up4'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/subclause/@indent = 'up5'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when test="ancestor::*[2]/clause/@indent = 'up1'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/clause/@indent = 'up2'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/clause/@indent = 'up3'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/clause/@indent = 'up4'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<!-- in this case my parent clause does not have this attribute -->
			<xsl:when test="ancestor::*[2]/subparagraph/@indent = 'up1'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/subparagraph/@indent = 'up2'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/subparagraph/@indent = 'up3'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<!-- ***************************************************** -->
			<xsl:when test="ancestor::*[2]/paragraph/@indent = 'up1'">
				<!-- in this case my parent subparagraph does not have this attribute -->
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/paragraph/@indent = 'up2'">
				<!-- in this case my parent subparagraph does not have this attribute -->
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="defineIndentationSubitem">
		<xsl:variable name="parentDisplayInLineCount">
			<xsl:call-template name="countParentDisplayInlineMax5"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when
				test="(preceding-sibling::subitem[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '0'">
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when
				test="(preceding-sibling::subitem[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '1'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when
				test="(preceding-sibling::subitem[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '2'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when
				test="(preceding-sibling::subitem[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '3'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="(preceding-sibling::subitem[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '4' and not(parent::item/@display-inline = 'yes-display-inline')">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="(preceding-sibling::subitem[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '4'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="(preceding-sibling::subitem[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '5'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!-- ************************************************** -->
			<xsl:when test="$parentDisplayInLineCount = '1'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '2'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '3'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '4'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '5'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<!-- TB Mar-31-2015 Bug Fixing #1381 -->
			<!--xsl:when
				test="preceding-sibling::subitem[@indent='up1'] or @indent='up1' or ./@indent='up1'">
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::subitem[@indent='up2'] or @indent='up2' or ./@indent='up2'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::subitem[@indent='up3'] or @indent='up3' or ./@indent='up3'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::subitem[@indent='up4'] or @indent='up4' or ./@indent='up4'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::subitem[@indent='up5'] or @indent='up5' or ./@indent='up5'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::subitem[@indent='up6'] or @indent='up6' or ./@indent='up6'">
				<xsl:text>lbexIndentSubsection</xsl:text>
				</xsl:when-->
			<xsl:when test="@indent = 'up1' or ./@indent = 'up1'">
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up2' or ./@indent = 'up2'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up3' or ./@indent = 'up3'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up4' or ./@indent = 'up4'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up5' or ./@indent = 'up5'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up6' or ./@indent = 'up6'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when test="parent::item/@indent = 'up1'">
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when test="parent::item/@indent = 'up2'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="parent::item/@indent = 'up3'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="parent::item/@indent = 'up4'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="parent::item/@indent = 'up5'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="parent::item/@indent = 'up6'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when test="parent::subclause/@indent = 'up1'">
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when test="parent::subclause/@indent = 'up2'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="parent::subclause/@indent = 'up3'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="parent::subclause/@indent = 'up4'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="parent::subclause/@indent = 'up5'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when test="parent::clause/@indent = 'up1'">
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when test="parent::clause/@indent = 'up2'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="parent::clause/@indent = 'up3'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="parent::clause/@indent = 'up4'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<!-- in this case my parent clause does not have this attribute -->
			<xsl:when test="parent::subparagraph/@indent = 'up1'">
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when test="parent::subparagraph/@indent = 'up2'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="parent::subparagraph/@indent = 'up3'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<!-- ***************************************************** -->
			<xsl:when test="parent::paragraph/@indent = 'up1'">
				<!-- in this case my parent subparagraph does not have this attribute -->
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when test="parent::paragraph/@indent = 'up2'">
				<!-- in this case my parent subparagraph does not have this attribute -->
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentSubItem</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="defineIndentationSubitemByParent">
		<xsl:variable name="parentDisplayInLineCount">
			<xsl:call-template name="countParentDisplayInlineMax5"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when
				test="(parent::*/preceding-sibling::subitem[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '0'">
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when
				test="(parent::*/preceding-sibling::subitem[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '1'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when
				test="(parent::*/preceding-sibling::subitem[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '2'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when
				test="(parent::*/preceding-sibling::subitem[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '3'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="(parent::*/preceding-sibling::subitem[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '4' and not(parent::item/@display-inline = 'yes-display-inline')">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="(parent::*/preceding-sibling::subitem[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '4'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="(parent::*/preceding-sibling::subitem[@display-inline = 'yes-display-inline']) and $parentDisplayInLineCount = '5'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!-- ************************************************** -->
			<xsl:when test="$parentDisplayInLineCount = '1'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '2'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '3'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '4'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="$parentDisplayInLineCount = '5'">
				<!--case with preceeding sibling = 'yes display-inline was covered in the first two cases ==> here the only case when preceding sibling is no display inline-->
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when
				test="parent::*/preceding-sibling::subitem[@indent = 'up1'] or @indent = 'up1' or ./@indent = 'up1'">
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/preceding-sibling::subitem[@indent = 'up2'] or @indent = 'up2' or ./@indent = 'up2'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/preceding-sibling::subitem[@indent = 'up3'] or @indent = 'up3' or ./@indent = 'up3'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/preceding-sibling::subitem[@indent = 'up4'] or @indent = 'up4' or ./@indent = 'up4'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/preceding-sibling::subitem[@indent = 'up5'] or @indent = 'up5' or ./@indent = 'up5'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/preceding-sibling::subitem[@indent = 'up6'] or @indent = 'up6' or ./@indent = 'up6'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when test="ancestor::*[2]/item/@indent = 'up1'">
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/item/@indent = 'up2'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/item/@indent = 'up3'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/item/@indent = 'up4'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/item/@indent = 'up5'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/item/@indent = 'up6'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when test="ancestor::*[2]/subclause/@indent = 'up1'">
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/subclause/@indent = 'up2'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/subclause/@indent = 'up3'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/subclause/@indent = 'up4'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/subclause/@indent = 'up5'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<xsl:when test="ancestor::*[2]/clause/@indent = 'up1'">
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/clause/@indent = 'up2'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/clause/@indent = 'up3'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/clause/@indent = 'up4'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<!--**************************************************-->
			<!-- in this case my parent clause does not have this attribute -->
			<xsl:when test="ancestor::*[2]/subparagraph/@indent = 'up1'">
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/subparagraph/@indent = 'up2'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/subparagraph/@indent = 'up3'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<!-- ***************************************************** -->
			<xsl:when test="ancestor::*[2]/paragraph/@indent = 'up1'">
				<!-- in this case my parent subparagraph does not have this attribute -->
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when test="ancestor::*[2]/paragraph/@indent = 'up2'">
				<!-- in this case my parent subparagraph does not have this attribute -->
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentSubItem</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>



	<xsl:template name="countParentDisplayInlineMax2">
		<xsl:variable name="anc1_up_level">
			<xsl:choose>
				<xsl:when
					test="ancestor::*[1]/@indent and not(ancestor::*[2]/@display-inline = 'yes-display-inline')">
					<xsl:value-of select="substring-after(ancestor::*[1]/@indent, 'up')"/>
				</xsl:when>
				<xsl:when
					test="ancestor::*[1]/@indent and ancestor::*[2]/@display-inline = 'yes-display-inline'">
					<xsl:value-of select="number(substring-after(ancestor::*[1]/@indent, 'up')) - 1"
					/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:variable>
		<xsl:variable name="anc2_up_level">
			<xsl:choose>
				<xsl:when
					test="ancestor::*[2]/@indent and not(ancestor::*[3]/@display-inline = 'yes-display-inline')">
					<xsl:value-of select="substring-after(ancestor::*[2]/@indent, 'up')"/>
				</xsl:when>
				<xsl:when
					test="ancestor::*[2]/@indent and ancestor::*[3]/@display-inline = 'yes-display-inline'">
					<xsl:value-of select="number(substring-after(ancestor::*[2]/@indent, 'up')) - 1"
					/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when
				test="
					((ancestor::*[1]/@display-inline = 'yes-display-inline' and not(local-name(ancestor::*[1]) = 'quoted-block')) or
					ancestor::*[1]/preceding-sibling::item/@display-inline = 'yes-display-inline' or
					ancestor::*[1]/preceding-sibling::subclause/@display-inline = 'yes-display-inline' or
					ancestor::*[1]/preceding-sibling::clause/@display-inline = 'yes-display-inline' or
					ancestor::*[1]/preceding-sibling::subparagraph/@display-inline = 'yes-display-inline' or
					ancestor::*[1]/preceding-sibling::paragraph/@display-inline = 'yes-display-inline')
					and (ancestor::*[2]/@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::item/@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::subclause/@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::clause/@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::subparagraph/@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::paragraph/@display-inline = 'yes-display-inline')">
				<!--TB 21Jun2010 - returned back-->
				<xsl:text>2</xsl:text>
				<!--xsl:text>1</xsl:text-->
			</xsl:when>
			<xsl:when
				test="
					((ancestor::*[1]/@display-inline = 'yes-display-inline' and not(local-name(ancestor::*[1]) = 'quoted-block')) or
					ancestor::*[1]/preceding-sibling::item/@display-inline = 'yes-display-inline' or
					ancestor::*[1]/preceding-sibling::subclause/@display-inline = 'yes-display-inline' or
					ancestor::*[1]/preceding-sibling::clause/@display-inline = 'yes-display-inline' or
					ancestor::*[1]/preceding-sibling::subparagraph/@display-inline = 'yes-display-inline' or
					ancestor::*[1]/preceding-sibling::paragraph/@display-inline = 'yes-display-inline')">
				<xsl:value-of select="1 + number($anc2_up_level)"/>
			</xsl:when>
			<xsl:when
				test="
					((ancestor::*[2]/@display-inline = 'yes-display-inline' and not(local-name(ancestor::*[2]) = 'quoted-block')) or
					ancestor::*[2]/preceding-sibling::item/@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::subclause/@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::clause/@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::subparagraph/@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::paragraph/@display-inline = 'yes-display-inline')">
				<xsl:value-of select="1 + number($anc1_up_level)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="number($anc1_up_level) + number($anc2_up_level)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="countParentDisplayInlineMax3">
		<xsl:variable name="countMax2">
			<xsl:call-template name="countParentDisplayInlineMax2"/>
		</xsl:variable>

		<xsl:variable name="anc3_up_level">
			<xsl:choose>
				<xsl:when
					test="ancestor::*[3]/@indent and not(ancestor::*[4]/@display-inline = 'yes-display-inline')">
					<xsl:value-of select="substring-after(ancestor::*[3]/@indent, 'up')"/>
				</xsl:when>
				<xsl:when
					test="ancestor::*[3]/@indent and ancestor::*[4]/@display-inline = 'yes-display-inline'">
					<xsl:value-of select="number(substring-after(ancestor::*[3]/@indent, 'up')) - 1"
					/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>


		<xsl:choose>
			<xsl:when
				test="
					(ancestor::*[3]/@display-inline = 'yes-display-inline' and not(local-name(ancestor::*[3]) = 'quoted-block')) or
					ancestor::*[3]/preceding-sibling::item/@display-inline = 'yes-display-inline' or
					ancestor::*[3]/preceding-sibling::subclause/@display-inline = 'yes-display-inline' or
					ancestor::*[3]/preceding-sibling::clause/@display-inline = 'yes-display-inline' or
					ancestor::*[3]/preceding-sibling::subparagraph/@display-inline = 'yes-display-inline' or
					ancestor::*[3]/preceding-sibling::paragraph/@display-inline = 'yes-display-inline'">
				<xsl:value-of select="1 + number($countMax2)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="number($anc3_up_level) + number($countMax2)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="countParentDisplayInlineMax4">
		<xsl:variable name="countMax3">
			<xsl:call-template name="countParentDisplayInlineMax3"/>
		</xsl:variable>

		<xsl:variable name="anc4_up_level">
			<xsl:choose>
				<xsl:when
					test="ancestor::*[4]/@indent and not(ancestor::*[5]/@display-inline = 'yes-display-inline')">
					<xsl:value-of select="substring-after(ancestor::*[4]/@indent, 'up')"/>
				</xsl:when>
				<xsl:when
					test="ancestor::*[4]/@indent and ancestor::*[5]/@display-inline = 'yes-display-inline'">
					<xsl:value-of select="number(substring-after(ancestor::*[4]/@indent, 'up')) - 1"
					/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when
				test="
					ancestor::*[4]/@display-inline = 'yes-display-inline' or
					ancestor::*[4]/preceding-sibling::item/@display-inline = 'yes-display-inline' or
					ancestor::*[4]/preceding-sibling::subclause/@display-inline = 'yes-display-inline' or
					ancestor::*[4]/preceding-sibling::clause/@display-inline = 'yes-display-inline' or
					ancestor::*[4]/preceding-sibling::subparagraph/@display-inline = 'yes-display-inline' or
					ancestor::*[4]/preceding-sibling::paragraph/@display-inline = 'yes-display-inline'">
				<xsl:value-of select="1 + number($countMax3)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="number($anc4_up_level) + number($countMax3)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="countParentDisplayInlineMax5">
		<xsl:variable name="countMax4">
			<xsl:call-template name="countParentDisplayInlineMax4"/>
		</xsl:variable>

		<xsl:variable name="anc5_up_level">
			<xsl:choose>
				<xsl:when
					test="ancestor::*[5]/@indent and not(ancestor::*[6]/@display-inline = 'yes-display-inline')">
					<xsl:value-of select="substring-after(ancestor::*[5]/@indent, 'up')"/>
				</xsl:when>
				<xsl:when
					test="ancestor::*[5]/@indent and ancestor::*[6]/@display-inline = 'yes-display-inline'">
					<xsl:value-of select="number(substring-after(ancestor::*[5]/@indent, 'up')) - 1"
					/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when
				test="
					ancestor::*[5]/@display-inline = 'yes-display-in' or
					ancestor::*[5]/preceding-sibling::item/@display-inline = 'yes-display-inline' or
					ancestor::*[5]/preceding-sibling::subclause/@display-inline = 'yes-display-inline' or
					ancestor::*[5]/preceding-sibling::clause/@display-inline = 'yes-display-inline' or
					ancestor::*[5]/preceding-sibling::subparagraph/@display-inline = 'yes-display-inline' or
					ancestor::*[5]/preceding-sibling::paragraph/@display-inline = 'yes-display-inline'">
				<xsl:value-of select="1 + number($countMax4)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="number($anc5_up_level) + number($countMax4)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>



	<!--**********************End  of Indentation****************************************************************-->

	<!-- ActualPrintSub Paragraph -->
	<xsl:template name="ActualPrintSubParagraph">
		<xsl:variable name="appropReportedStyle">
			<xsl:call-template name="getAppropriationReportingStyle"/>
		</xsl:variable>
		<xsl:if test="$appropReportedStyle = 'bold-brackets'">
			<span class="lbexBrakets">
				<xsl:text>[</xsl:text>
			</span>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="$appropReportedStyle = 'strikethrough'">
				<span class="lbexTextStrikethrough">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:variable name="isToCloseTheBrackets">
			<xsl:call-template name="toCloseTheBrakets"/>
		</xsl:variable>
		<xsl:if
			test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-italic' or $appropReportedStyle = 'brackets-boldface-roman') and $isToCloseTheBrackets = 'yes'">
			<span class="lbexBrakets">
				<xsl:text>]</xsl:text>
			</span>
		</xsl:if>
		<!--/p-->
	</xsl:template>

	<!-- ActualPrintSub Paragraph with Quoted Text -->
	<xsl:template name="ActualPrintSubParagraphQuotedText">
		<xsl:variable name="appropReportedStyle">
			<xsl:call-template name="getAppropriationReportingStyle"/>
		</xsl:variable>
		<xsl:if test="$appropReportedStyle = 'bold-brackets'">
			<span class="lbexBrakets">
				<xsl:text>[</xsl:text>
			</span>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="$appropReportedStyle = 'strikethrough'">
				<span class="lbexTextStrikethrough">
					<xsl:call-template name="printQuotedText"/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="printQuotedText"/>
			</xsl:otherwise>
		</xsl:choose>


		<xsl:variable name="isToCloseTheBrackets">
			<xsl:call-template name="toCloseTheBrakets"/>
		</xsl:variable>
		<xsl:if
			test="($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-italic' or $appropReportedStyle = 'brackets-boldface-roman') and $isToCloseTheBrackets = 'yes'">
			<span class="lbexBrakets">
				<xsl:text>]</xsl:text>
			</span>
		</xsl:if>
		<!--/p-->
	</xsl:template>

	<!-- ActualPrintSub Paragraph with Text -->
	<xsl:template name="ActualPrintSubParagraphWithText">
		<xsl:choose>
			<xsl:when
				test="local-name() = 'subparagraph' and @indent = 'up1' or parent::*/@indent = 'up1'">
				<p style="text-align:left" class="lbexIndentParagraph">
					<xsl:call-template name="ActualPrintSubParagraphWithTextNoClass"/>
				</p>
			</xsl:when>
			<xsl:when
				test="local-name() = 'subparagraph' and @indent = 'up2' or parent::*/@indent = 'up2'">
				<p style="text-align:left" class="lbexIndentSubsection">
					<xsl:call-template name="ActualPrintSubParagraphWithTextNoClass"/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p style="text-align:left" class="lbexIndent">
					<xsl:call-template name="ActualPrintSubParagraphWithTextNoClass"/>
				</p>
			</xsl:otherwise>
		</xsl:choose>


	</xsl:template>

	<xsl:template name="ActualPrintSubParagraphWithTextNoClass">
		<xsl:variable name="appropReportedStyle">
			<xsl:call-template name="getAppropriationReportingStyle"/>
		</xsl:variable>

		<xsl:if test="contains($appropReportedStyle, 'brackets') or @commented = 'yes'">
			<xsl:call-template name="openBracketStyles"/>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="$appropReportedStyle = 'strikethrough'">
				<span class="lbexTextStrikethrough">
					<xsl:if test="ancestor::quoted-block">
						<xsl:call-template name="printQuotedText"/>
					</xsl:if>
					<xsl:if test="not(ancestor::quoted-block)">
						<!--xsl:call-template name="ActualPrintText"/-->
						<xsl:apply-templates/>
					</xsl:if>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="ancestor::quoted-block">
					<xsl:call-template name="printQuotedText"/>
				</xsl:if>
				<xsl:if test="not(ancestor::quoted-block)">
					<!--xsl:call-template name="ActualPrintText"/-->
					<xsl:apply-templates/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:variable name="isToCloseTheBrackets">
			<xsl:call-template name="toCloseTheBrakets"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-italic' or $appropReportedStyle = 'brackets-boldface-roman') and $isToCloseTheBrackets = 'yes' and child::text)" >
				<xsl:text></xsl:text>
			</xsl:when>
		<xsl:when test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-italic' or $appropReportedStyle = 'brackets-boldface-roman') and $isToCloseTheBrackets = 'yes') " >
				<xsl:call-template name="closedBracketStyles"/>
			</xsl:when>
		</xsl:choose>
	<xsl:choose>
			<xsl:when test="@commented = 'yes' and local-name()='subparagraph' and (child::text or child::*/@commented='yes')">
				
			</xsl:when>
			<xsl:when test="@commented = 'yes' and not(child::text) ">
				<xsl:call-template name="closedBracketStyles"/>
			</xsl:when>
		</xsl:choose>
		
	</xsl:template>

	<!-- ActualPrintSub Paragraph Extended -->
	<xsl:template name="ActualPrintSubParagraphEx">
		<p style="text-align:left" class="lbexIndentSubpar">
			<xsl:variable name="appropReportedStyle">
				<xsl:call-template name="getAppropriationReportingStyle"/>
			</xsl:variable>
			<xsl:if test="contains($appropReportedStyle, 'brackets')">
				<xsl:call-template name="openBracketStyles"/>
			</xsl:if>

			<xsl:choose>
				<xsl:when test="$appropReportedStyle = 'strikethrough'">
					<span class="lbexTextStrikethrough">
						<xsl:call-template name="openQuotes"/>
						<xsl:apply-templates select="enum"/>
						<xsl:apply-templates select="header"/>
						<xsl:apply-templates select="text"/>
						<xsl:apply-templates select="clause"/>
						<xsl:apply-templates select="continuation-text"/>
						<xsl:apply-templates select="table"/>
					</span>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="openQuotes"/>
					<xsl:apply-templates select="enum"/>
					<xsl:apply-templates select="header"/>
					<xsl:apply-templates select="text"/>
					<xsl:apply-templates select="clause"/>
					<xsl:apply-templates select="continuation-text"/>
					<xsl:apply-templates select="table"/>
				</xsl:otherwise>
			</xsl:choose>



			<xsl:variable name="isToCloseTheBrackets">
				<xsl:call-template name="toCloseTheBrakets"/>
			</xsl:variable>
			<xsl:if
				test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-italic' or $appropReportedStyle = 'brackets-boldface-roman') and $isToCloseTheBrackets = 'yes')">
				<xsl:call-template name="closedBracketStyles"/>
			</xsl:if>
		</p>
	</xsl:template>
	<xsl:template match="internal-xref">
		<a>
			<xsl:attribute name="href">
				<xsl:text>#</xsl:text>
				<xsl:value-of select="@idref"/>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</a>
	</xsl:template>
	<xsl:template match="external-xref">
		<xsl:choose>
			<xsl:when test="./@legal-doc = 'usc-appendix'">
				<a>
					<xsl:attribute name="href">
						<xsl:text>http://uscode.house.gov/quicksearch/get.plx?app=1&amp;title=</xsl:text>
						<xsl:variable name="title"
							select="substring-before(substring-after(./@parsable-cite, '/'), '/')"/>
						<xsl:value-of select="$title"/>
						<!-- TB May-6-2015  adding  character a to a title number for appendix -->
						<xsl:text>a</xsl:text>
						<xsl:text>&amp;section=</xsl:text>
						<xsl:variable name="usctitle" select="concat('usc-appendix/', $title, '/')"/>
						<xsl:choose>
							<xsl:when test="contains(./@parsable-cite, '(')">
								<xsl:value-of
									select="substring-before(substring-after(./@parsable-cite, $usctitle), '(')"
								/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="substring-after(./@parsable-cite, $usctitle)"
								/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:apply-templates/>
				</a>
			</xsl:when>
			<!-- TB Dec-2015 bug fixing #1418 -->
			<!--xsl:when test="./@legal-doc='usc-chapter'">
				<a>
					<xsl:attribute name="href">
						<xsl:text>http://uscode.house.gov/quicksearch/get.plx?title=</xsl:text>
						<xsl:variable name="title"
							select="substring-before(substring-after(./@parsable-cite,'/'),'/')"/>
						<xsl:value-of select="$title"/>
						<xsl:text>&amp;chapter=</xsl:text>
						<xsl:variable name="usctitle" select="concat('usc-chapter/',$title,'/')"/>
						<xsl:choose>
							<xsl:when test="contains(./@parsable-cite,'(')">
								<xsl:value-of
									select="substring-before(substring-after(./@parsable-cite, $usctitle),'(')"
								/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="substring-after(./@parsable-cite, $usctitle)"
								/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:apply-templates/>
				</a>
			</xsl:when-->
			<xsl:when test="./@legal-doc = 'usc-chapter'">
				<a>
					<xsl:attribute name="href">
						<xsl:text>http://uscode.house.gov/view.xhtml?req=granuleid:USC-prelim-title</xsl:text>
						<xsl:variable name="title"
							select="substring-before(substring-after(./@parsable-cite, '/'), '/')"/>
						<xsl:value-of select="$title"/>

						<xsl:text>-chapter</xsl:text>
						<xsl:variable name="usctitle" select="concat('usc-chapter/', $title, '/')"/>
						<xsl:choose>
							<xsl:when test="contains(./@parsable-cite, '(')">
								<xsl:value-of
									select="substring-before(substring-after(./@parsable-cite, $usctitle), '(')"
								/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="substring-after(./@parsable-cite, $usctitle)"
								/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>-front&amp;num=0&amp;edition=prelim</xsl:text>
					</xsl:attribute>
					<xsl:apply-templates/>
				</a>
			</xsl:when>
			<xsl:when test="./@legal-doc = 'usc-act'">
				<a>
					<xsl:attribute name="href">
						<xsl:text>http://uscode.house.gov/quicksearch/get.plx?actname=</xsl:text>
						<xsl:variable name="actname"
							select="substring-before(substring-after(./@parsable-cite, '/'), '/')"/>
						<xsl:value-of select="$actname"/>
						<xsl:text>&amp;section=</xsl:text>
						<xsl:value-of
							select="substring-after(substring-after(./@parsable-cite, $actname), '/')"
						/>
					</xsl:attribute>
					<xsl:apply-templates/>
				</a>
			</xsl:when>
			<xsl:when test="./@legal-doc = 'usc'">
				<a>
					<xsl:attribute name="href">
						<xsl:text>http://uscode.house.gov/quicksearch/get.plx?title=</xsl:text>
						<xsl:variable name="title"
							select="substring-before(substring-after(./@parsable-cite, '/'), '/')"/>
						<xsl:value-of select="$title"/>
						<xsl:text>&amp;section=</xsl:text>
						<xsl:variable name="usctitle" select="concat('usc/', $title, '/')"/>
						<xsl:choose>
							<xsl:when test="contains(./@parsable-cite, '(')">
								<xsl:value-of
									select="substring-before(substring-after(./@parsable-cite, $usctitle), '(')"
								/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="substring-after(./@parsable-cite, $usctitle)"
								/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:apply-templates/>
				</a>
			</xsl:when>
			<xsl:when test="./@legal-doc = 'public-law'">
				<!--display only the public laws that are greater than 103-->
				<!--sl:choose>
					<xsl:when
						test="number(substring-before(substring-after(./@parsable-cite,'pl/'),'/')) &gt; 103">
						<a>
							<xsl:attribute name="href">
								<xsl:text>http://frwebgate.access.gpo.gov/cgi-bin/getdoc.cgi?dbname=</xsl:text>
								<xsl:value-of
									select="substring-before(substring-after(./@parsable-cite,'pl/'), '/')"/>
								<xsl:text>_cong_public_laws&amp;docid=f:publ</xsl:text>								
								<xsl:if
									test="number(substring-after(substring-after(./@parsable-cite,'pl/'),'/')) &lt; 10">
									<xsl:text>00</xsl:text>
								</xsl:if>
								<xsl:if
									test="number(substring-after(substring-after(./@parsable-cite,'pl/'),'/')) >9 and
				number(substring-after(substring-after(./@parsable-cite,'pl/'),'/')) &lt; 100">
									<xsl:text>0</xsl:text>
								</xsl:if>
								<xsl:value-of
									select="substring-after(substring-after(./@parsable-cite,'pl/'),'/')"/>
								<xsl:text>.</xsl:text>
								<xsl:value-of
									select="substring-before(substring-after(./@parsable-cite,'pl/'), '/')"/>
								<xsl:text>.pdf</xsl:text>
							</xsl:attribute>
							<xsl:apply-templates/>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates/>
					</xsl:otherwise>
				</xsl:choose-->
				<!-- the logic may be applied to the congresses 104 and newer -->
				<xsl:variable name="thePLCongress">
					<xsl:value-of
						select="substring-before(substring-after(@parsable-cite, '/'), '/')"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="number($thePLCongress) &gt; 103">
						<a>
							<xsl:attribute name="href">

								<xsl:variable name="thePLNumber">
									<xsl:value-of
										select="substring-after(substring-after(@parsable-cite, '/'), '/')"
									/>
								</xsl:variable>
								<xsl:text>https://www.gpo.gov/fdsys/pkg/PLAW-</xsl:text>
								<xsl:value-of select="$thePLCongress"/>
								<xsl:text>publ</xsl:text>
								<xsl:value-of select="$thePLNumber"/>
								<xsl:text>/pdf/PLAW-</xsl:text>
								<xsl:value-of select="$thePLCongress"/>
								<xsl:text>publ</xsl:text>
								<xsl:value-of select="$thePLNumber"/>
								<xsl:text>.pdf</xsl:text>
							</xsl:attribute>
							<xsl:apply-templates/>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- TB Oct-2016 Bug #1440 - house-rule handeling added -->
			<xsl:when test="./@legal-doc = 'house-rule'">
				<xsl:variable name="theRefCongressNum">
					<xsl:value-of select="substring-before(@parsable-cite, '/')"/>
				</xsl:variable>
				<xsl:variable name="ruleNum">
					<xsl:choose>
						<xsl:when test="contains(substring-after(@parsable-cite, '/'), '/')">
							<xsl:value-of
								select="substring-before(substring-after(@parsable-cite, '/'), '/')"
							/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring-after(@parsable-cite, '/')"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="theSuffix">
					<xsl:call-template name="getHouseRulesSuffix">
						<xsl:with-param name="theRefCongressNum" select="$theRefCongressNum"/>
						<xsl:with-param name="ruleNum" select="$ruleNum"/>
					</xsl:call-template>
				</xsl:variable>

				<xsl:variable name="linkFirstPart">
					<xsl:value-of
						select="concat('https://www.govinfo.gov/content/pkg/HMAN-', $theRefCongressNum)"
					/>
				</xsl:variable>
				<xsl:variable name="linkSecondPart">
					<xsl:value-of select="concat('/xml/HMAN-', $theRefCongressNum)"/>
				</xsl:variable>

				<xsl:variable name="linkThirdPart">
					<xsl:choose>
						<xsl:when test="$theSuffix != ''">
							<xsl:value-of select="concat('-pg', $theSuffix, '.xml')"/>
						</xsl:when>
						<xsl:otherwise>.xml</xsl:otherwise>
					</xsl:choose>

				</xsl:variable>

				<xsl:variable name="residualRuleSpec">
					<xsl:choose>
						<xsl:when test="$theSuffix != ''">
							<xsl:value-of
								select="translate(substring-after(@parsable-cite, $ruleNum), '/', '-')"
							/>
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>


				</xsl:variable>

				<xsl:variable name="theFourthPart">
					<xsl:choose>
						<xsl:when test="$theSuffix != ''">
							<xsl:value-of select="concat('#rule-', $ruleNum, $residualRuleSpec)"/>
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>
				</xsl:variable>

				<xsl:variable name="theLinkRef">
					<xsl:value-of
						select="concat($linkFirstPart, $linkSecondPart, $linkThirdPart, $theFourthPart)"
					/>
				</xsl:variable>

				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="$theLinkRef"/>
					</xsl:attribute>
					<xsl:apply-templates/>
				</a>

			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="getHouseRulesSuffix">
		<xsl:param name="ruleNum"/>
		<xsl:param name="theRefCongressNum"/>


		<xsl:choose>
			<xsl:when test="$ruleNum = 'I'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">333</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">335</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">335</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'II'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">355</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">358</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">358</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'III'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">374</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">377</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">378</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'IV'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">379</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">382</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">383</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'V'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">387</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">390</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">391</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'VI'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">389</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">392</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">393</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'VII'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">401</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">404</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">405</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'VIII'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">405</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">408</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">409</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'IX'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">409</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">412</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">413</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'X'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">429</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">432</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">434</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XI'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">541</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">544</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">546</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XII'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">608</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">612</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">615</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XIII'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">623</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">627</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">630</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XIV'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">657</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">662</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">665</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XV'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">668</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">672</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">676</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XVI'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">686</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">691</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">695</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XVII'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">741</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">746</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">750</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XVIII'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">770</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">775</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">780</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XIX'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">799</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">805</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">810</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XX'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">814</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">820</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">825</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XXI'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">844</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">850</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">855</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XXII'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">900</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">907</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">913</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XXIII'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">927</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">934</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">940</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XXIV'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">938</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">946</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">952</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XXV'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">943</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">951</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">957</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XXVI'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">972</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">980</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">986</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XXVII'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">996</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">1006</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">1012</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XXVIII'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">998</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">1008</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">1014</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$ruleNum = 'XXIX'">
				<xsl:choose>
					<xsl:when test="$theRefCongressNum = '112'">998-2</xsl:when>
					<xsl:when test="$theRefCongressNum = '113'">1008-2</xsl:when>
					<xsl:when test="$theRefCongressNum = '114'">1014-2</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>

	</xsl:template>
	<!-- ************************************************************************ -->
	<xsl:template match="toc">
		<!-- fixing the appearance of multi-toc for committee-report -->
		<xsl:choose>
			<xsl:when test="//committee-report/@front-matter-toc = 'yes'">
				<!-- nothing -->
			</xsl:when>
			<!-- TB June 2012 Bug fixing #1262 -->
			<xsl:when test="//committee-report and multi-column-toc-entry">
				<p/>
				<xsl:call-template name="printTocForCommitteeReports"/>
				<p/>
			</xsl:when>
			<xsl:when test="multi-column-toc-entry">
				<p class="lbexTocSectionOLC">
					<p class="lbexNoMargin">
						<ul class="leaders">
							<xsl:apply-templates/>
						</ul>
					</p>
				</p>
				<!-- TB Aug-2016 fixing weirs overlapping of following section -->
				<br/>
				<br/>
				<br/>

			</xsl:when>
			<xsl:otherwise>
				<p/>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ************************************************************************ -->
	<xsl:template name="createLink">
		<xsl:param name="val"/>
		<xsl:param name="aPrintBracket"/>
		<xsl:param name="aPrintParenth"/>
		<xsl:if test="not(ancestor::quoted-block[@style = 'tax'])">
			<!-- TB 12Sep2007  #717 -->
			<xsl:call-template name="displayTocVerticalSpace"/>
		</xsl:if>
		<xsl:variable name="isIdReferenceExists">
			<xsl:call-template name="IdReferenceExists">
				<xsl:with-param name="currentID" select="./@idref"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$isIdReferenceExists = 'yes'">
				<xsl:call-template name="ActualCreateLinkWithRef">
					<xsl:with-param name="aVal" select="$val"/>
					<xsl:with-param name="aPrintBracket">
						<xsl:value-of select="$aPrintBracket"/>
					</xsl:with-param>
					<xsl:with-param name="aPrintParenth">
						<xsl:value-of select="$aPrintParenth"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!--xsl:if test=" $isTocCentered='yes'">
					<xsl:attribute name="align">
						<xsl:text>center</xsl:text>
					</xsl:attribute>
				</xsl:if-->
				<xsl:call-template name="ActualCreateLinkNoRef">
					<xsl:with-param name="aVal" select="$val"/>
					<xsl:with-param name="aPrintBracket">
						<xsl:value-of select="$aPrintBracket"/>
					</xsl:with-param>
					<xsl:with-param name="aPrintParenth">
						<xsl:value-of select="$aPrintParenth"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="createLinkNoParam">
		<xsl:param name="aPrintBracket"/>
		<xsl:param name="aPrintParenth"/>

		<xsl:variable name="currElementStyle">
			<xsl:call-template name="getCurrentElementStyle"/>
		</xsl:variable>

		<xsl:variable name="isIdReferenceExists">
			<xsl:call-template name="IdReferenceExists">
				<xsl:with-param name="currentID" select="./@idref"/>
			</xsl:call-template>
		</xsl:variable>

		<!-- Will be applied only for Subdivision, subtitle in OLC and Nuclear. Part, subpart for tax  , Chapter for traditional inline and Archaic paragraph-->
		<!-- TB May-19-2015 Bug fixing #1386 added support for subsection and down levels in tax style-->

		<xsl:choose>
			<xsl:when
				test="not(ancestor::quoted-block[@style = 'tax']) or (ancestor::quoted-block[@style = 'tax'] and (@level = 'part' or @level = 'subpart' or @level = 'subchapter' or @level = 'section'))">
				<!-- TB 12Sep2007  #717 -->
				<xsl:call-template name="displayTocVerticalSpace"/>
				<xsl:choose>
					<xsl:when
						test="not(@level = 'section' or @level = 'subsection' or @level = 'paragraph' or @level = 'subparagraph' or @level = 'clause' or @level = 'subclause' or @level = 'item' or @level = 'subitem')">
						<div style="text-align:center">
							<xsl:call-template name="insideCreateLinkNoParam">
								<xsl:with-param name="currElementStyle" select="$currElementStyle"/>
								<xsl:with-param name="aPrintBracket" select="$aPrintBracket"/>
								<xsl:with-param name="aPrintParenth" select="$aPrintParenth"/>
								<xsl:with-param name="isIdReferenceExists"
									select="$isIdReferenceExists"/>
							</xsl:call-template>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="insideCreateLinkNoParam">
							<xsl:with-param name="currElementStyle" select="$currElementStyle"/>
							<xsl:with-param name="aPrintBracket" select="$aPrintBracket"/>
							<xsl:with-param name="aPrintParenth" select="$aPrintParenth"/>
							<xsl:with-param name="isIdReferenceExists" select="$isIdReferenceExists"
							/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when
						test="not(@level = 'section' or @level = 'subsection' or @level = 'paragraph' or @level = 'subparagraph' or @level = 'clause' or @level = 'subclause' or @level = 'item' or @level = 'subitem')">
						<div style="text-align:center">
							<xsl:call-template name="insideCreateLinkNoParam">
								<xsl:with-param name="currElementStyle" select="$currElementStyle"/>
								<xsl:with-param name="aPrintBracket" select="$aPrintBracket"/>
								<xsl:with-param name="aPrintParenth" select="$aPrintParenth"/>
								<xsl:with-param name="isIdReferenceExists"
									select="$isIdReferenceExists"/>
							</xsl:call-template>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="insideCreateLinkNoParam">
							<xsl:with-param name="currElementStyle" select="$currElementStyle"/>
							<xsl:with-param name="aPrintBracket" select="$aPrintBracket"/>
							<xsl:with-param name="aPrintParenth" select="$aPrintParenth"/>
							<xsl:with-param name="isIdReferenceExists" select="$isIdReferenceExists"
							/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>


	</xsl:template>

	<xsl:template name="insideCreateLinkNoParam">
		<xsl:param name="currElementStyle"/>
		<xsl:param name="aPrintBracket"/>
		<xsl:param name="aPrintParenth"/>
		<xsl:param name="isIdReferenceExists"/>
		<xsl:choose>
			<xsl:when test="$isIdReferenceExists = 'yes'">
				<a>
					<xsl:attribute name="href">
						<xsl:text>#toc-</xsl:text>
						<xsl:value-of select="@href | @idref"/>
					</xsl:attribute>
					<!-- TB Jan-2014  billres clean up obsolete attributes -->
					<!--xsl:attribute name="NAME"-->
					<xsl:attribute name="id">
						<xsl:value-of select="@href | @idref"/>
					</xsl:attribute>
					<xsl:if test="ancestor::quoted-block or ancestor::toc-quoted-entry">
						<xsl:call-template name="openQuotes"/>
					</xsl:if>
					<!--xsl:value-of select="$val"/-->
					<xsl:if test="$aPrintBracket = 'yes'">
						<span class="lbexBrakets">
							<xsl:text>[</xsl:text>
						</span>
					</xsl:if>
					<xsl:if test="$aPrintParenth = 'yes'">
						<span class="lbexBrakets">
							<xsl:text>(</xsl:text>
						</span>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="@level = 'subtitle' and $currElementStyle = 'OLC'">
							<span class="lbexTocSubTitleOLC">
								<xsl:apply-templates/>
							</span>
						</xsl:when>
						<xsl:when test="@level = 'subdivision' and $currElementStyle = 'OLC'">
							<span class="lbexTocSubTitleOLC">
								<xsl:apply-templates/>
							</span>
						</xsl:when>
						<xsl:when test="@level = 'subpart' and $currElementStyle = 'OLC'">
							<span class="lbexTocSubPartOLC">
								<xsl:apply-templates/>
							</span>
						</xsl:when>
						<xsl:when test="@level = 'chapter' and $currElementStyle = 'traditional'">
							<span class="lbexTocChapterTrad">
								<xsl:apply-templates/>
							</span>
						</xsl:when>
						<xsl:when test="@level = 'part' and $currElementStyle = 'traditional'">
							<span class="lbexTocPartTrad">
								<xsl:apply-templates/>
							</span>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates/>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:if test="not(ancestor::quoted-block and following-sibling::toc-entry)">
						<xsl:call-template name="closeQuotesByCondition"/>
					</xsl:if>
					<!-- TB 12Sep2007  #717 -->
					<xsl:if
						test="not(ancestor::quoted-block[@style = 'tax']) and (ancestor-or-self::toc-entry[1]/following-sibling::*)">
						<xsl:call-template name="displayTocVerticalSpace"/>
					</xsl:if>

				</a>
			</xsl:when>
			<xsl:when test="not($isIdReferenceExists = 'yes')">
				<xsl:if test="ancestor::quoted-block or ancestor::toc-quoted-entry">
					<xsl:call-template name="openQuotes"/>
				</xsl:if>
				<xsl:if test="$aPrintBracket = 'yes'">
					<span class="lbexBrakets">
						<xsl:text>[</xsl:text>
					</span>
				</xsl:if>
				<xsl:if test="$aPrintParenth = 'yes'">
					<span class="lbexBrakets">
						<xsl:text>(</xsl:text>
					</span>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="@level = 'section'">
						<xsl:apply-templates/>
					</xsl:when>
					<xsl:otherwise>
						<!--xsl:value-of select="$val"/-->
						<xsl:apply-templates/>
						<xsl:if test="parent::toc/following-sibling::after-quoted-block">
							<!--xsl:text>”.</xsl:text-->
							<xsl:call-template name="closeQuotesByCondition"/>
						</xsl:if>
						<!-- TB checking - removing extra space -->
						<!--p/-->
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="ActualCreateLinkWithRef">
		<xsl:param name="aVal"/>
		<xsl:param name="aPrintBracket"/>
		<xsl:param name="aPrintParenth"/>

		<a>
			<xsl:attribute name="href">
				<xsl:text>#toc-</xsl:text>
				<xsl:value-of select="@href | @idref"/>
			</xsl:attribute>
			<!-- TB Jan-2014  billres clean up obsolete attributes -->
			<!--xsl:attribute name="NAME"-->
			<xsl:attribute name="id">
				<xsl:value-of select="@href | @idref"/>
			</xsl:attribute>
			<xsl:if test="ancestor::quoted-block or ancestor::toc-quoted-entry">
				<xsl:call-template name="openQuotes"/>
			</xsl:if>
			<xsl:if test="$aPrintBracket = 'yes'">
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
			</xsl:if>
			<xsl:if test="$aPrintParenth = 'yes'">
				<span class="lbexBrakets">
					<xsl:text>(</xsl:text>
				</span>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="ancestor::quoted-block and following-sibling::toc-entry">
					<!-- TB 1Sep2009 -->
					<xsl:if test="$aVal = 'toccompoundedWithChild'">
						<xsl:apply-templates/>
					</xsl:if>
					<xsl:if test="$aVal != 'toccompoundedWithChild'">
						<!-- TB 24Dec2012 bug fixing 1288 subscript and superscript  -->
						<xsl:apply-templates/>
						<!--xsl:value-of select="$aVal"/-->
					</xsl:if>
					<!-- TB 12Sep2007  #717 -->
					<xsl:if
						test="not(ancestor::quoted-block[@style = 'tax']) and (ancestor-or-self::toc-entry[1]/following-sibling::*)">
						<xsl:call-template name="displayTocVerticalSpace"/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<!-- TB 1Sep2009 -->
					<xsl:if test="$aVal = 'toccompoundedWithChild'">
						<xsl:apply-templates/>
					</xsl:if>
					<xsl:if test="$aVal != 'toccompoundedWithChild'">
						<!-- TB 24Dec2012 bug fixing 1288 subscript and superscript  -->
						<xsl:apply-templates/>
						<!--xsl:value-of select="$aVal"/-->
					</xsl:if>
					<!-- TB 25Sep2007 Replaced by general template calling -->
					<xsl:if
						test="local-name(node()[position() = last()]) != '' or (local-name(node()[position() = last()]) = '' and (node()[position() = last()] = '' or node()[position() = last()] = '.' or node()[position() = last()] = ';'))">
						<xsl:call-template name="closeQuotesByCondition"/>
					</xsl:if>
					<!-- TB 12Sep2007  #717 -->
					<xsl:if
						test="not(ancestor::quoted-block[@style = 'tax']) and (ancestor-or-self::toc-entry[1]/following-sibling::*)">
						<xsl:call-template name="displayTocVerticalSpace"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</a>
		<!--xsl:variable name="isToCloseTheBrackets">
			<xsl:call-template name="toCloseTheBrakets"/>
		</xsl:variable>
		<xsl:variable name="appropReportedStyle">
			<xsl:call-template name="getAppropriationReportingStyle"/>
		</xsl:variable>
		<xsl:if test="($appropReportedStyle='bold-brackets' and $isToCloseTheBrackets='yes' ) or @commented='yes'">
			<span class="brakets">
				<xsl:text>]</xsl:text>
			</span>
		</xsl:if-->
	</xsl:template>

	<xsl:template name="ActualCreateLinkNoRef">
		<xsl:param name="aPrintBracket"/>
		<xsl:param name="aPrintParenth"/>
		<xsl:param name="aVal"/>

		<xsl:if test="ancestor::quoted-block or ancestor::toc-quoted-entry">
			<xsl:call-template name="openQuotes"/>
		</xsl:if>
		<xsl:if test="$aPrintBracket = 'yes'">
			<span class="lbexBrakets">
				<xsl:text>[</xsl:text>
			</span>
		</xsl:if>
		<xsl:if test="$aPrintParenth = 'yes'">
			<span class="lbexBrakets">
				<xsl:text>(</xsl:text>
			</span>
		</xsl:if>
		<xsl:variable name="isToCloseTheBrackets">
			<xsl:call-template name="toCloseTheBrakets"/>
		</xsl:variable>
		<xsl:variable name="appropReportedStyle">
			<xsl:call-template name="getAppropriationReportingStyle"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="@level = 'section'">
				<xsl:apply-templates/>
				<xsl:if
					test="((($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-italic' or $appropReportedStyle = 'brackets-boldface-roman') and $isToCloseTheBrackets = 'yes') or @commented = 'yes') and not(local-name() = 'toc-entry')">
					<span class="lbexBrakets">
						<xsl:text>]</xsl:text>
					</span>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$aVal = 'toccompoundedWithChild'">
				<xsl:apply-templates/>
				<xsl:if
					test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-italic' or $appropReportedStyle = 'brackets-boldface-roman') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
					<span class="lbexBrakets">
						<xsl:text>]</xsl:text>
					</span>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$aVal"/>
				<xsl:choose>
					<xsl:when test="local-name() = 'toc-entry' and following-sibling::toc-entry">
						<!-- nothing -->
					</xsl:when>
					<xsl:when test="parent::toc/following-sibling::after-quoted-block">
						<xsl:text>”.</xsl:text>
					</xsl:when>
				</xsl:choose>

				<xsl:if
					test="(($appropReportedStyle = 'bold-brackets' or $appropReportedStyle = 'brackets-boldface-italic' or $appropReportedStyle = 'brackets-boldface-roman') and $isToCloseTheBrackets = 'yes') or @commented = 'yes'">
					<span class="lbexBrakets">
						<xsl:text>]</xsl:text>
					</span>
				</xsl:if>
				<xsl:if test="following-sibling::toc-entry[1]/@level != 'section'">
					<br/>	
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="toc-entry">
		<xsl:variable name="currElementStyle">
			<xsl:call-template name="getCurrentElementStyle"/>
		</xsl:variable>

		<xsl:variable name="isPrintItalic">
			<xsl:variable name="tempPrint">
				<xsl:call-template name="IsPrintItalicTextForReport"/>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="$tempPrint = 'yes'">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when test="contains(@reported-display-style, 'italic')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains(parent::toc/@reported-display-style, 'italic') and not(@changed = 'not-changed')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains(ancestor::amendment-block/@reported-display-style, 'italic') and not(parent::toc/@chabged = 'not-changed') and not(@changed = 'not-changed')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains(ancestor::legis-body/@reported-display-style, 'italic') and not(parent::toc/@chabged = 'not-changed') and not(@changed = 'not-changed')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="isPrintIBold">
			<xsl:choose>
				<xsl:when
					test="contains(@reported-display-style, 'bold') and not(@reported-display-style = 'bold-brackets')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains(parent::toc/@reported-display-style, 'bold') and not(parent::toc/@reported-display-style = 'bold-brackets') and not(@changed = 'not-changed')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains(ancestor::amendment-block/@reported-display-style, 'bold') and not(ancestor::amendment-block/@reported-display-style = 'bold-brackets') and not(parent::toc/@chabged = 'not-changed') and not(@changed = 'not-changed')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="isPrintStrikethrough">
			<xsl:variable name="tempPrint">
				<xsl:call-template name="IsPrintItalicTextForReport"/>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="$tempPrint = 'yes'">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when test="contains(@reported-display-style, 'strikethrough')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains(parent::toc/@reported-display-style, 'strikethrough') and not(@changed = 'not-changed')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains(ancestor::amendment-block/@reported-display-style, 'strikethrough') and not(parent::toc/@chabged = 'not-changed') and not(@changed = 'not-changed')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>


		<xsl:choose>
			<xsl:when
				test="$isPrintItalic = 'yes' and (parent::toc/parent::subparagraph/parent::paragraph)">
				<i class="lbexBlockNeutral">
					<xsl:if test="$isPrintIBold = 'yes'">
						<xsl:attribute name="style">
							<xsl:text>font-weight: bold;</xsl:text>
						</xsl:attribute>
					</xsl:if>
					<ul>
						<ul>
							<xsl:call-template name="TocEntryMainChoose">
								<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"
								/>
							</xsl:call-template>
						</ul>
					</ul>
				</i>
			</xsl:when>
			<xsl:when test="$isPrintItalic = 'yes'">
				<i class="lbexBlockNeutral">
					<xsl:if test="$isPrintIBold = 'yes'">
						<xsl:attribute name="style">
							<xsl:text>font-weight: bold;</xsl:text>
						</xsl:attribute>
					</xsl:if>
					<xsl:call-template name="TocEntryMainChoose">
						<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
					</xsl:call-template>
				</i>
			</xsl:when>
			<xsl:when
				test="$isPrintStrikethrough = 'yes' and (parent::toc/parent::subparagraph/parent::paragraph)">
				<span class="lbexTextStrikethrough">
					<xsl:if test="$isPrintIBold = 'yes'">
						<xsl:attribute name="style">
							<xsl:text>font-weight: bold;</xsl:text>
						</xsl:attribute>
					</xsl:if>
					<ul>
						<ul>
							<xsl:call-template name="TocEntryMainChoose">
								<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"
								/>
							</xsl:call-template>
						</ul>
					</ul>
				</span>
			</xsl:when>
			<xsl:when test="$isPrintStrikethrough = 'yes'">
				<span class="lbexTextStrikethrough">
					<xsl:if test="$isPrintIBold = 'yes'">
						<xsl:attribute name="style">
							<xsl:text>font-weight: bold;</xsl:text>
						</xsl:attribute>
					</xsl:if>
					<xsl:call-template name="TocEntryMainChoose">
						<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:when test="(parent::toc/parent::subparagraph/parent::paragraph)">
				<ul>
					<xsl:if test="$isPrintIBold = 'yes'">
						<xsl:attribute name="style">
							<xsl:text>font-weight: bold;</xsl:text>
						</xsl:attribute>
					</xsl:if>
					<ul>
						<xsl:call-template name="TocEntryMainChoose">
							<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
						</xsl:call-template>
					</ul>
				</ul>
			</xsl:when>
			<xsl:otherwise>
				<span>
					<xsl:if test="$isPrintIBold = 'yes'">
						<xsl:attribute name="style">
							<xsl:text>font-weight: bold;</xsl:text>
						</xsl:attribute>
					</xsl:if>
					<xsl:call-template name="TocEntryMainChoose">
						<xsl:with-param name="aCurrElementStyle" select="$currElementStyle"/>
					</xsl:call-template>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="printLineBreakInToc">
		<xsl:param name="currStyle"/>
		<xsl:choose>
			<xsl:when test="$currStyle = 'OLC' or $currStyle = ''">
				<xsl:choose>
					<xsl:when test="@level = 'division'">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:when
						test="@level = 'subdivision' and not(enum-in-header) and not(preceding-sibling::*[1]/@level = 'division')">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:when
						test="@level = 'subdivision' and enum-in-header and not(preceding-sibling::*[1]/@level = 'division')">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:when
						test="./@level = 'title' and not(preceding-sibling::*[1]/@level = 'division' or preceding-sibling::*[1]/@level = 'subdivision')">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:when
						test="./@level = 'subtitle' and not(enum-in-header) and not(preceding-sibling::*[1]/@level = 'title' or preceding-sibling::*[1]/@level = 'division' or preceding-sibling::*[1]/@level = 'subdivision')">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:when
						test="./@level = 'subtitle' and enum-in-header and (not(preceding-sibling::*[1]/@level = 'title' or preceding-sibling::*[1]/@level = 'division' or preceding-sibling::*[1]/@level = 'subdivision'))">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:when
						test="@level = 'chapter' and not(preceding-sibling::*[1]/@level = 'title' or preceding-sibling::*[1]/@level = 'subtitle' or preceding-sibling::*[1]/@level = 'part' or preceding-sibling::*[1]/@level = 'subpart' or preceding-sibling::*[1]/@level = 'division' or preceding-sibling::*[1]/@level = 'subdivision')">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:when
						test="@level = 'subchapter' and not(preceding-sibling::*[1]/@level = 'title' or preceding-sibling::*[1]/@level = 'subtitle' or preceding-sibling::*[1]/@level = 'part' or preceding-sibling::*[1]/@level = 'subpart' or preceding-sibling::*[1]/@level = 'chapter' or preceding-sibling::*[1]/@level = 'division' or preceding-sibling::*[1]/@level = 'subdivision')">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:when
						test="@level = 'part' and not(preceding-sibling::*[1]/@level = 'title' or preceding-sibling::*[1]/@level = 'subtitle' or preceding-sibling::*[1]/@level = 'chapter' or preceding-sibling::*[1]/@level = 'subchapter' or preceding-sibling::*[1]/@level = 'division' or preceding-sibling::*[1]/@level = 'subdivision')">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:when
						test="@level = 'subpart' and not(enum-in-header) and not(preceding-sibling::*[1]/@level = 'title' or preceding-sibling::*[1]/@level = 'subtitle' or preceding-sibling::*[1]/@level = 'part' or preceding-sibling::*[1]/@level = 'division' or preceding-sibling::*[1]/@level = 'subdivision')">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:when
						test="@level = 'subpart' and enum-in-header and not(preceding-sibling::*[1]/@level = 'title' or preceding-sibling::*[1]/@level = 'subtitle' or preceding-sibling::*[1]/@level = 'part' or preceding-sibling::*[1]/@level = 'division' or preceding-sibling::*[1]/@level = 'subdivision')">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:when test="@level = 'section'">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>no</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="contains($currStyle, 'traditional') or contains($currStyle, 'archaic') or  contains($currStyle, 'appropriations')">
				<xsl:choose>
					<xsl:when test="@level = 'section'">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:otherwise>no</xsl:otherwise>
				</xsl:choose>

			</xsl:when>
			<xsl:when test="$currStyle = 'tax'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when test="$currStyle = 'USC' and @level = 'section'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="actualCreateLinkWrapper">
		<xsl:param name="toPrintLineBreakInToc"/>
		<xsl:param name="applyTemplates"/>
		<xsl:param name="styleToPrint"/>
		<xsl:param name="additionalParam"/>
		<xsl:param name="turnToLowerOrUpper"/>

		<xsl:variable name="isPrintBracket">
			<xsl:choose>
				<xsl:when test="contains(@reported-display-style, 'bracket')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains(parent::toc/@reported-display-style, 'bracket') and not(@changed = 'not-changed')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains(ancestor::amendment-block/@reported-display-style, 'bracket') and not(parent::toc/@chabged = 'not-changed') and not(@changed = 'not-changed')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when test="contains(ancestor::*/@reported-display-style, 'bracket')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="isPrintParentheses">
			<xsl:choose>
				<xsl:when test="contains(@reported-display-style, 'parentheses')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains(parent::toc/@reported-display-style, 'parentheses') and not(@changed = 'not-changed')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains(ancestor::amendment-block/@reported-display-style, 'parentheses') and not(parent::toc/@chabged = 'not-changed') and not(@changed = 'not-changed')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="isTocCentered">
			<xsl:choose>
				<xsl:when
					test="not(@level = 'section' or @level = 'subsection' or @level = 'paragraph' or @level = 'subparagraph' or @level = 'clause' or @level = 'subclause' or @level = 'item' or @level = 'subitem')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="toPrintLineBreakInToc1">
			<xsl:choose>
				<xsl:when test="$toPrintLineBreakInToc = 'yes' and $isTocCentered = 'no'">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="$isTocCentered = 'yes'">
			<div style="text-align:center">
				<xsl:call-template name="actualCreateLinkWrapperContent">
					<xsl:with-param name="toPrintLineBreakInToc" select="$toPrintLineBreakInToc1"/>
					<xsl:with-param name="styleToPrint" select="$styleToPrint"/>
					<xsl:with-param name="additionalParam" select="$additionalParam"/>
					<xsl:with-param name="isPrintBracket" select="$isPrintBracket"/>
					<xsl:with-param name="isPrintParentheses" select="$isPrintParentheses"/>
					<xsl:with-param name="applyTemplates" select="$applyTemplates"/>
					<xsl:with-param name="turnToLowerOrUpper" select="$turnToLowerOrUpper"/>
				</xsl:call-template>
			</div>
		</xsl:if>
		<xsl:if test="$isTocCentered = 'no'">
			<span>
				<xsl:call-template name="actualCreateLinkWrapperContent">
					<xsl:with-param name="toPrintLineBreakInToc" select="$toPrintLineBreakInToc"/>
					<xsl:with-param name="styleToPrint" select="$styleToPrint"/>
					<xsl:with-param name="additionalParam" select="$additionalParam"/>
					<xsl:with-param name="isPrintBracket" select="$isPrintBracket"/>
					<xsl:with-param name="isPrintParentheses" select="$isPrintParentheses"/>
					<xsl:with-param name="applyTemplates" select="$applyTemplates"/>
					<xsl:with-param name="turnToLowerOrUpper" select="$turnToLowerOrUpper"/>
				</xsl:call-template>
			</span>
		</xsl:if>

	</xsl:template>

	<xsl:template name="actualCreateLinkWrapperContent">
		<xsl:param name="toPrintLineBreakInToc"/>
		<xsl:param name="styleToPrint"/>
		<xsl:param name="additionalParam"/>
		<xsl:param name="isPrintBracket"/>
		<xsl:param name="isPrintParentheses"/>
		<xsl:param name="applyTemplates"/>
		<xsl:param name="turnToLowerOrUpper"/>

		<xsl:if test="$styleToPrint != ''">
			<xsl:attribute name="class">
				<xsl:value-of select="$styleToPrint"/>
			</xsl:attribute>
		</xsl:if>


		<xsl:if test="$toPrintLineBreakInToc = 'yes'">
			<br/>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="$additionalParam = 'noParam'">
				<xsl:call-template name="createLinkNoParam">
					<xsl:with-param name="aPrintBracket">
						<xsl:value-of select="$isPrintBracket"/>
					</xsl:with-param>
					<xsl:with-param name="aPrintParenth">
						<xsl:value-of select="$isPrintParentheses"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="createLink">
					<xsl:with-param name="aPrintBracket">
						<xsl:value-of select="$isPrintBracket"/>
					</xsl:with-param>
					<xsl:with-param name="aPrintParenth">
						<xsl:value-of select="$isPrintParentheses"/>
					</xsl:with-param>
					<xsl:with-param name="val">
						<xsl:choose>
							<xsl:when test="$additionalParam = 'yes' and child::*">
								<xsl:text>toccompoundedWithChild</xsl:text>
							</xsl:when>
							<xsl:when test="$applyTemplates = 'yes'">
								<xsl:apply-templates/>
							</xsl:when>
							<xsl:when test="$turnToLowerOrUpper = 'lower'">
								<xsl:value-of select="translate(., $upper, $lower)"/>
							</xsl:when>
							<xsl:when test="$turnToLowerOrUpper = 'upper'">
								<xsl:value-of select="translate(., $lower, $upper)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="."/>
							</xsl:otherwise>
						</xsl:choose>

					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:variable name="isToCloseTheBrackets">
			<xsl:call-template name="toCloseTheBrakets"/>
		</xsl:variable>

		<xsl:if
			test="$isToCloseTheBrackets = 'yes' and $isPrintBracket = 'yes' and ((following-sibling::toc-entry and not(contains(following-sibling::toc-entry/@reported-display-style, 'bracket')) and not(contains(parent::toc/@reported-display-style, 'bracket'))) or (local-name() = 'toc-entry' and not(following-sibling::*)))">
			<span class="lbexBrakets">
				<xsl:text>]</xsl:text>
			</span>
		</xsl:if>

		<xsl:if
			test="$isPrintParentheses = 'yes' and (following-sibling::toc-entry and not(contains(following-sibling::toc-entry/@reported-display-style, 'parentheses')) and not(contains(parent::toc/@reported-display-style, 'parentheses')) or (local-name() = 'toc-entry' and not(following-sibling::*)))">
			<span class="lbexBrakets">
				<xsl:text>)</xsl:text>
			</span>
		</xsl:if>
	</xsl:template>

	<xsl:template name="createLinkWrapper">
		<xsl:param name="toPrintLineBreakInToc"/>
		<xsl:param name="applyTemplates"/>
		<xsl:param name="styleToPrint"/>
		<xsl:param name="additionalParam"/>
		<xsl:param name="turnToLowerOrUpper"/>

		<xsl:if test="parent::toc-quoted-entry">
			<span class="lbexIndent">
				<xsl:call-template name="actualCreateLinkWrapper">
					<xsl:with-param name="toPrintLineBreakInToc" select="$toPrintLineBreakInToc"/>
					<xsl:with-param name="applyTemplates" select="$applyTemplates"/>
					<xsl:with-param name="styleToPrint" select="$styleToPrint"/>
					<xsl:with-param name="additionalParam" select="$additionalParam"/>
					<xsl:with-param name="turnToLowerOrUpper" select="$turnToLowerOrUpper"/>
				</xsl:call-template>
			</span>
		</xsl:if>
		<xsl:if test="not(parent::toc-quoted-entry)">
			<xsl:call-template name="actualCreateLinkWrapper">
				<xsl:with-param name="toPrintLineBreakInToc" select="$toPrintLineBreakInToc"/>
				<xsl:with-param name="applyTemplates" select="$applyTemplates"/>
				<xsl:with-param name="styleToPrint" select="$styleToPrint"/>
				<xsl:with-param name="additionalParam" select="$additionalParam"/>
				<xsl:with-param name="turnToLowerOrUpper" select="$turnToLowerOrUpper"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- *****To separate it - for resolving bugzilla problem with html tags in text -->
	<xsl:template name="TocEntryMainChoose">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:variable name="toPrintLineBreakInToc">
			<xsl:call-template name="printLineBreakInToc">
				<xsl:with-param name="currStyle" select="$aCurrElementStyle"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<!-- USC style -->
			<xsl:when test="$aCurrElementStyle = 'USC'">
				<xsl:choose>
					<xsl:when test="@level = 'section'">
						<span style="text-align:left">
							<xsl:call-template name="createLinkWrapper">
								<xsl:with-param name="styleToPrint"
									>lbexTocSectionTrad</xsl:with-param>
								<xsl:with-param name="toPrintLineBreakInToc"
									select="$toPrintLineBreakInToc"/>
								<xsl:with-param name="additionalParam">yes</xsl:with-param>
								<xsl:with-param name="applyTemplates">no</xsl:with-param>
							</xsl:call-template>

						</span>
					</xsl:when>
					<xsl:when test="@level = 'title' or @level = 'division'">
						<div style="text-align:center">
							<xsl:call-template name="createLinkWrapper">
								<xsl:with-param name="styleToPrint"
									>lbexTocTitleTrad</xsl:with-param>
								<xsl:with-param name="toPrintLineBreakInToc"
									select="$toPrintLineBreakInToc"/>
								<xsl:with-param name="additionalParam">no</xsl:with-param>
								<xsl:with-param name="applyTemplates">yes</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:when>
					<xsl:when test="@level = 'subtitle'">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint">lbexTocDivisionOLC</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">yes</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="@level = 'chapter' and not(enum-in-header)">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint">lbexTocChapterTrad</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">yes</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="@level = 'chapter' and enum-in-header">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">noParam</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="./@level = 'subchapter'">
						<div style="text-align:center">
							<xsl:call-template name="createLinkWrapper">
								<xsl:with-param name="styleToPrint"
									>lbexTocSubchapterTrad</xsl:with-param>
								<xsl:with-param name="toPrintLineBreakInToc"
									select="$toPrintLineBreakInToc"/>
								<xsl:with-param name="additionalParam">yes</xsl:with-param>
								<xsl:with-param name="applyTemplates">no</xsl:with-param>
								<xsl:with-param name="turnToLowerOrUpper">upper</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:when>
					<xsl:when test="level = 'subchapter'">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint"
								>lbexTocSubchapterTrad</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">yes</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="./@level = 'part' and not(enum-in-header)">
						<div style="text-align:center">
							<xsl:call-template name="createLinkWrapper">
								<xsl:with-param name="styleToPrint">lbexTocPartTrad</xsl:with-param>
								<xsl:with-param name="toPrintLineBreakInToc"
									select="$toPrintLineBreakInToc"/>
								<xsl:with-param name="additionalParam">yes</xsl:with-param>
								<xsl:with-param name="applyTemplates">no</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:when>
					<xsl:when test="./@level = 'part' and enum-in-header">
						<div style="text-align:center">
							<xsl:call-template name="createLinkWrapper">
								<xsl:with-param name="toPrintLineBreakInToc"
									select="$toPrintLineBreakInToc"/>
								<xsl:with-param name="additionalParam">noParam</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:when>
					<xsl:when test="@level = 'subpart'">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint">lbexTocSubPartTrad</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">yes</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="preceding-sibling::toc-entry[1]/@level = 'section'">
							<br/>
						</xsl:if>
						<span style="text-align:left">
							<xsl:call-template name="createLinkWrapper">
								<xsl:with-param name="styleToPrint"
									>lbexTocSectionTrad</xsl:with-param>
								<xsl:with-param name="toPrintLineBreakInToc"
									select="$toPrintLineBreakInToc"/>
								<xsl:with-param name="additionalParam">yes</xsl:with-param>
								<xsl:with-param name="applyTemplates">no</xsl:with-param>
							</xsl:call-template>

						</span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- Tax style -->
			<xsl:when test="$aCurrElementStyle = 'tax'">
				<xsl:choose>
					<xsl:when
						test="
							(@level = 'section' and ancestor::*[@reported-display-style = 'boldface-roman'])
							or (@level = 'section' and ancestor::*[@reported-display-style = 'boldface-italic'])">
						<span style="text-align:left" class="lbexIndentFour">
							<xsl:call-template name="createLinkWrapper">
								<xsl:with-param name="styleToPrint"
									>lbexTocSectionIRCBold</xsl:with-param>
								<xsl:with-param name="toPrintLineBreakInToc"
									select="$toPrintLineBreakInToc"/>
								<xsl:with-param name="additionalParam">yes</xsl:with-param>
								<xsl:with-param name="applyTemplates">no</xsl:with-param>
							</xsl:call-template>
						</span>
					</xsl:when>
					<xsl:when test="@level = 'section'">
						<span style="text-align:left" class="lbexIndentFive">
							<xsl:call-template name="createLinkWrapper">
								<xsl:with-param name="styleToPrint"
									>lbexTocSectionIRCTax</xsl:with-param>
								<xsl:with-param name="toPrintLineBreakInToc"
									select="$toPrintLineBreakInToc"/>
								<xsl:with-param name="additionalParam">noParam</xsl:with-param>
							</xsl:call-template>
						</span>
					</xsl:when>
					<xsl:when
						test="
							(@level = 'part' and ancestor::*[@reported-display-style = 'boldface-roman']) or
							(@level = 'part' and ancestor::*[@reported-display-style = 'boldface-italic'])">
						<span style="text-align:left" class="lbexIndentFour">
							<xsl:call-template name="createLinkWrapper">
								<xsl:with-param name="styleToPrint"
									>lbexTocPartIRCBold</xsl:with-param>
								<xsl:with-param name="toPrintLineBreakInToc"
									select="$toPrintLineBreakInToc"/>
								<xsl:with-param name="additionalParam">yes</xsl:with-param>
								<xsl:with-param name="applyTemplates">no</xsl:with-param>
							</xsl:call-template>
						</span>
					</xsl:when>

					<xsl:when test="@level = 'part'">
						<span style="text-align:left" class="lbexIndentFour">
							<xsl:call-template name="createLinkWrapper">
								<xsl:with-param name="styleToPrint"
									>lbexTocSectionIRCTax</xsl:with-param>
								<xsl:with-param name="toPrintLineBreakInToc"
									select="$toPrintLineBreakInToc"/>
								<xsl:with-param name="additionalParam">noParam</xsl:with-param>
							</xsl:call-template>
						</span>
					</xsl:when>
					<xsl:when test="@level = 'subpart'">
						<span style="text-align:left" class="lbexIndentFour">
							<xsl:call-template name="createLinkWrapper">
								<xsl:with-param name="styleToPrint"
									>lbexTocSectionIRCTax</xsl:with-param>
								<xsl:with-param name="toPrintLineBreakInToc"
									select="$toPrintLineBreakInToc"/>
								<xsl:with-param name="additionalParam">noParam</xsl:with-param>
							</xsl:call-template>
						</span>
					</xsl:when>
					<xsl:when
						test="
							(@level = 'chapter' or @level = 'subchapter' or @level = 'subtitle') and
							(ancestor::*[@reported-display-style = 'boldface-roman'] or @level = 'chapter' and ancestor::*[@reported-display-style = 'boldface-italic'])">

						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint"
								>lbexTocBigCapsLowCapsIRCBold</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">no</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
							<xsl:with-param name="turnToLowerOrUpper">lower</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when
						test="@level = 'title' or @level = 'subchapter' or @level = 'chapter' or @level = 'subtitle'">
						<!--additional param was changed to yes TB 20Dec2012 - checking-->
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint"
								>lbexTocBigCapsLowCapsIRC</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">yes</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
							<xsl:with-param name="turnToLowerOrUpper">lower</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<span style="text-align:left" class="lbexIndentFive">
							<xsl:call-template name="createLinkWrapper">
								<xsl:with-param name="styleToPrint"
									>lbexTocSectionIRCTax</xsl:with-param>
								<xsl:with-param name="toPrintLineBreakInToc"
									select="$toPrintLineBreakInToc"/>
								<xsl:with-param name="additionalParam">noParam</xsl:with-param>
							</xsl:call-template>
						</span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!--traditional style-->
			<xsl:when
				test="contains($aCurrElementStyle, 'traditional') or contains($aCurrElementStyle, 'archaic') or $aCurrElementStyle = 'appropriations'">
				<xsl:choose>
					<xsl:when test="@level = 'section'">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint">lbexTocSectionTrad</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">yes</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="@level = 'title' or @level = 'division'">
						<div style="text-align:center">
							<xsl:call-template name="createLinkWrapper">
								<xsl:with-param name="styleToPrint"
									>lbexTocTitleTrad</xsl:with-param>
								<xsl:with-param name="toPrintLineBreakInToc"
									select="$toPrintLineBreakInToc"/>
								<xsl:with-param name="additionalParam">no</xsl:with-param>
								<xsl:with-param name="applyTemplates">yes</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:when>
					<xsl:when test="@level = 'subtitle'">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint">lbexTocDivisionOLC</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">yes</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="@level = 'chapter' and not(enum-in-header)">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint">lbexTocChapterTrad</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">yes</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="@level = 'chapter' and enum-in-header">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">noParam</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="./@level = 'subchapter'">
						<div style="text-align:center">
							<xsl:call-template name="createLinkWrapper">
								<xsl:with-param name="styleToPrint"
									>lbexTocSubchapterTrad</xsl:with-param>
								<xsl:with-param name="toPrintLineBreakInToc"
									select="$toPrintLineBreakInToc"/>
								<xsl:with-param name="additionalParam">yes</xsl:with-param>
								<xsl:with-param name="applyTemplates">no</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:when>
					<xsl:when test="level = 'subchapter'">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint"
								>lbexTocSubchapterTrad</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">yes</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="./@level = 'part' and not(enum-in-header)">
						<div style="text-align:center">
							<xsl:call-template name="createLinkWrapper">
								<xsl:with-param name="styleToPrint">lbexTocPartTrad</xsl:with-param>
								<xsl:with-param name="toPrintLineBreakInToc"
									select="$toPrintLineBreakInToc"/>
								<xsl:with-param name="additionalParam">yes</xsl:with-param>
								<xsl:with-param name="applyTemplates">no</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:when>
					<xsl:when test="./@level = 'part' and enum-in-header">
						<div style="text-align:center">
							<xsl:call-template name="createLinkWrapper">
								<xsl:with-param name="toPrintLineBreakInToc"
									select="$toPrintLineBreakInToc"/>
								<xsl:with-param name="additionalParam">noParam</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:when>
					<xsl:when test="@level = 'subpart'">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint">lbexTocSubPartTrad</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">yes</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="preceding-sibling::toc-entry[1]/@level = 'section'">
							<br/>
						</xsl:if>
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint">lbexTocSectionTrad</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">yes</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>

			<xsl:when test="$aCurrElementStyle = 'OLC' or $aCurrElementStyle = ''">
				<!--OLC style-->
				<xsl:choose>
					<xsl:when test="@level = 'section'">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint">lbexTocSectionOLC</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">yes</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="@level = 'division'">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint">lbexTocDivisionOLC</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">no</xsl:with-param>
							<xsl:with-param name="applyTemplates">yes</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<!-- TB 20Sep2007 Enum-in -header fixing in toc-entry -->
					<xsl:when test="@level = 'subdivision' and not(enum-in-header)">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint"
								>lbexTocSubDivisionOLC</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">yes</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="@level = 'subdivision' and enum-in-header">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">noParam</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="./@level = 'title'">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint">lbexTocDivisionOLC</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="applyTemplates">yes</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="./@level = 'subtitle' and not(enum-in-header)">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint">lbexTocSubTitleOLC</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">yes</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
						</xsl:call-template>

					</xsl:when>
					<xsl:when
						test="(./@level = 'subtitle' or @level = 'subpart') and enum-in-header">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">noParam</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="@level = 'chapter'">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint">lbexTocDivisionOLC</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">no</xsl:with-param>
							<xsl:with-param name="applyTemplates">yes</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="@level = 'subchapter'">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint"
								>lbexTocSubChapterOLC</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">no</xsl:with-param>
							<xsl:with-param name="applyTemplates">yes</xsl:with-param>
						</xsl:call-template>
					</xsl:when>

					<xsl:when test="@level = 'part'">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint">lbexTocDivisionOLC</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">no</xsl:with-param>
							<xsl:with-param name="applyTemplates">yes</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="@level = 'subpart' and not(enum-in-header)">
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint">lbexTocSubPartOLC</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">yes</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
							<xsl:with-param name="turnToLowerOrUpper">upper</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="preceding-sibling::toc-entry[1]/@level = 'section'">
							<br/>
						</xsl:if>
						<xsl:call-template name="createLinkWrapper">
							<xsl:with-param name="styleToPrint">lbexTocSectionOLC</xsl:with-param>
							<xsl:with-param name="toPrintLineBreakInToc"
								select="$toPrintLineBreakInToc"/>
							<xsl:with-param name="additionalParam">yes</xsl:with-param>
							<xsl:with-param name="applyTemplates">no</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- *******Quoted Block******************* -->
	<xsl:template match="quoted-block">
		<xsl:choose>
			<xsl:when test="./@style = 'USC'">
				<div style="text-align:left">
					<xsl:apply-templates/>
				</div>
			</xsl:when>
			<xsl:when test="section">
				<div style="text-align:left">
					<xsl:apply-templates/>
				</div>
			</xsl:when>
			<xsl:when test="parent::paragraph and child::subsection">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="parent::paragraph and child::paragraph/@indent = 'up1'">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="parent::paragraph and child::paragraph">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="paragraph">
				<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
			</xsl:when>
			<xsl:when test="parent::subsection and child::subsection">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when
				test="(parent::subsection/preceding-sibling::subsection/quoted-block/paragraph/subparagraph)">
				<ul>
					<xsl:apply-templates/>
				</ul>
			</xsl:when>
			<xsl:when test="parent::subsection and child::subparagraph">
				<ul>
					<xsl:apply-templates/>
				</ul>
			</xsl:when>
			<xsl:when test="parent::section and child::subparagraph">
				<ul>
					<xsl:apply-templates/>
				</ul>
			</xsl:when>
			<xsl:when test="parent::paragraph and child::subparagraph[@indent = 'up2']">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="parent::paragraph and child::subparagraph[@indent = 'up1']">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="parent::paragraph and child::subparagraph">
				<ul>
					<xsl:apply-templates/>
				</ul>
			</xsl:when>
			<xsl:when test="parent::subparagraph and child::subparagraph">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="parent::clause and child::subparagraph">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="parent::paragraph and child::clause">
				<ul>
					<xsl:apply-templates/>
				</ul>
			</xsl:when>
			<xsl:when test="parent::section and child::clause">
				<ul>
					<ul>
						<xsl:apply-templates/>
					</ul>
				</ul>
			</xsl:when>
			<xsl:when test="parent::paragraph and child::subclause">
				<ul>
					<ul>
						<ul>
							<xsl:apply-templates/>
						</ul>
					</ul>
				</ul>
			</xsl:when>
			<xsl:when test="subparagraph">
				<ul>
					<xsl:apply-templates/>
				</ul>
			</xsl:when>
			<xsl:when test="./@style = 'tax' and child::toc">
				<!-- TB June 2012 bug fixing  #1262 -->
				<!--ul>
					<ul>
						<ul>
							<ul-->
				<span class="lbexHang">
					<xsl:apply-templates/>
				</span>
				<!--/ul>
						</ul>
					</ul>
				</ul-->
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="subitem">
		<!-- TB Aug 2016 bug fixing 1434 -->
		<xsl:call-template name="printSectionAndDownStructure">
			<xsl:with-param name="thePrintingTemplate">displaySubitem</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="displaySubitem">
		<xsl:choose>
			<xsl:when test="@display-inline = 'yes-display-inline'">
				<!-- TB aug 2012 Bug fixing #1270 -->
				<xsl:if test="parent::quoted-block and not(preceding-sibling::*)">
					<xsl:call-template name="openQuotes"/>
				</xsl:if>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="indentLevel">
					<xsl:call-template name="defineIndentation">
						<xsl:with-param name="aLevelElement">subitem</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<!-- TB 1Feb2012 one more paragraph with back to zero indentation applied - to support 
					indentation in Firefox. transparent for other browsers -->
				<xsl:variable name="bringIndentToZeroAttr">
					<xsl:call-template name="zeroindentlevel">
						<xsl:with-param name="aLevelToIndent">
							<xsl:value-of select="$indentLevel"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<p>
					<xsl:attribute name="style">
						<xsl:value-of select="$bringIndentToZeroAttr"/>
					</xsl:attribute>
					<p>
						<xsl:attribute name="class">
							<xsl:value-of select="$indentLevel"/>
						</xsl:attribute>
						<xsl:if test="@commented = 'yes' or contains(ancestor::quoted-block/@reported-display-style,'brackets')">
							<xsl:call-template name="openBracketStyles"/>
						</xsl:if>
						<xsl:if test="ancestor::quoted-block">
							<xsl:call-template name="openQuotes"/>
						</xsl:if>
						<xsl:apply-templates/>
						<xsl:if test="@commented = 'yes'">
							<xsl:call-template name="closedBracketStyles"/>
						</xsl:if>
					</p>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="constitution-article">
		<p style="text-align:left">
			<div style="text-align:center">
				<xsl:if
					test="parent::quoted-block/@style = 'traditional' or parent::quoted-block/@style = 'constitutional-amendment'">
					<xsl:call-template name="openQuotes"/>
					<span class="lbexSectionLevelOLCnuclear">
						<xsl:text>article </xsl:text>
					</span>
					<xsl:apply-templates select="enum"/>
				</xsl:if>
			</div>
			<xsl:apply-templates select="section"/>
		</p>
	</xsl:template>
	<!--*****beginning of cont-text***-->
	<!-- ******************************************************************************************************************* -->
	<xsl:template match="continuation-text">
		<xsl:call-template name="ContinuationText"/>
	</xsl:template>

	<!-- **************************Continuation Text*********************************** -->
	<xsl:template name="ContinuationText">
		<xsl:variable name="continuationTextLevel">
			<xsl:choose>
				<xsl:when test="./@quoted-block-continuation-text-level">
					<xsl:value-of select="./@quoted-block-continuation-text-level"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="./@continuation-text-level"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$continuationTextLevel = 'section'">
				<p/>
				<span class="lbexNonIndentSubsection">
					<xsl:call-template name="ActualPrintContinuationText"/>
				</span>
			</xsl:when>
			<xsl:when test="$continuationTextLevel = 'subsection'">
				<p/>
				<span class="lbexNonIndentSubsection">
					<xsl:call-template name="ActualPrintContinuationText"/>
				</span>
			</xsl:when>
			<xsl:when test="contains($continuationTextLevel, 'appropriations')">
				<p/>
				<span class="lbexNonIndentSubsection">
					<xsl:call-template name="ActualPrintContinuationText"/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="indentLevel">
					<xsl:call-template name="defineIndentation">
						<xsl:with-param name="aLevelElement" select="$continuationTextLevel"/>
					</xsl:call-template>
				</xsl:variable>
				<p>
					<xsl:attribute name="class">
						<xsl:value-of
							select="concat('lbexNon', substring-after($indentLevel, 'lbex'))"/>
					</xsl:attribute>
					<xsl:call-template name="ActualPrintContinuationText"/>
				</p>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>
	<!--******** Actual Print continuation text********************-->
	<xsl:template name="ActualPrintContinuationText">
		<xsl:if test="ancestor::quoted-block and not(preceding-sibling::*)">
			<xsl:call-template name="openQuotes"/>
		</xsl:if>

		<xsl:variable name="appropriationReportedStyle">
			<xsl:call-template name="getAppropriationReportingStyle"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$appropriationReportedStyle = 'strikethrough'">
				<span class="lbexTextStrikethrough">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if
			test="$appropriationReportedStyle = 'bold-brackets' or $appropriationReportedStyle = 'brackets-bold-italic' or $appropriationReportedStyle = 'brackets-bold-roman'">
			<!-- and the next node is not inline -->
			<xsl:variable name="toCloseBrackets">
				<xsl:call-template name="toCloseTheBrakets"/>
			</xsl:variable>
			<xsl:if test="$toCloseBrackets = 'yes'">
				<span class="lbexBrakets">
					<xsl:text>]</xsl:text>
				</span>
			</xsl:if>
		</xsl:if>
		<!--/div-->
	</xsl:template>

	<!-- ************** Clause ***************************************** -->
	<xsl:template match="clause">
		<!-- TB Aug 2016 bug fixing 1434 -->
		<xsl:call-template name="printSectionAndDownStructure">
			<xsl:with-param name="thePrintingTemplate">displayClause</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="displayClause">
		<xsl:variable name="appropReportedStyle">
			<xsl:call-template name="getAppropriationReportingStyle"/>
		</xsl:variable>
		<xsl:call-template name="createAnchor"/>
		<xsl:choose>
			<xsl:when test="(@display-inline = 'yes-display-inline')">
				<xsl:if test="@commented = 'yes'">
					<span class="lbexBrakets">
						<xsl:text>[</xsl:text>
					</span>
				</xsl:if>
				<!-- TB aug 2012 Bug fixing #1270 -->
				<xsl:if test="parent::quoted-block and not(preceding-sibling::*)">
					<xsl:call-template name="openQuotes"/>
				</xsl:if>
				<xsl:apply-templates/>
				<xsl:if test="@commented = 'yes'">
					<span class="lbexBrakets">
						<xsl:text>]</xsl:text>
					</span>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="indentLevel">
					<xsl:call-template name="defineIndentation">
						<xsl:with-param name="aLevelElement">clause</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<!-- TB 1Feb2012 one more paragraph with back to zero indentation applied - to support 
					indentation in Firefox. transparent for other browsers -->
				<xsl:variable name="bringIndentToZeroAttr">
					<xsl:call-template name="zeroindentlevel">
						<xsl:with-param name="aLevelToIndent">
							<xsl:value-of select="$indentLevel"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<p>
					<xsl:attribute name="style">
						<xsl:value-of select="$bringIndentToZeroAttr"/>
					</xsl:attribute>

					<p>
						<xsl:attribute name="class">
							<xsl:value-of select="$indentLevel"/>
						</xsl:attribute>
						<xsl:if test="contains($appropReportedStyle ,'brackets') or @commented = 'yes'">
							<xsl:call-template name="openBracketStyles"/>
						</xsl:if>
						<xsl:if test="ancestor::quoted-block">
							<xsl:call-template name="openQuotes"/>
						</xsl:if>
						<xsl:choose>
							<xsl:when test="$appropReportedStyle = 'strikethrough'">
								<span class="lbexTextStrikethrough">
									<xsl:apply-templates/>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:variable name="isToCloseTheBrackets">
							<xsl:call-template name="toCloseTheBrakets"/>
						</xsl:variable>
						<xsl:choose>
							<!-- Check in aditional that this is the last element in deleted block -->
							<xsl:when
								test="(contains($appropReportedStyle , 'brackets') and child::text and $isToCloseTheBrackets = 'yes')">
								<xsl:text></xsl:text>
							</xsl:when>
						<xsl:when
								test="(contains($appropReportedStyle , 'brackets') and $isToCloseTheBrackets = 'yes') ">
								<xsl:call-template name="closedBracketStyles"/>
							</xsl:when>
						</xsl:choose>
					<xsl:choose>
							<xsl:when test="@commented = 'yes' and (child::text or child::*/@commented='yes') and local-name()='clause'">
								
							</xsl:when>
							<xsl:when test="@commented = 'yes' and not(child::text)">
								<xsl:call-template name="closedBracketStyles"/>
							</xsl:when>
						</xsl:choose>
					</p>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="subclause">
		<!-- TB Aug 2016 bug fixing 1434 -->
		<xsl:call-template name="printSectionAndDownStructure">
			<xsl:with-param name="thePrintingTemplate">displaySubclause</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="displaySubclause">
		<xsl:call-template name="createAnchor"/>
		<xsl:variable name="appropReportedStyle">
			<xsl:call-template name="getAppropriationReportingStyle"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="./@display-inline = 'yes-display-inline'">
				<xsl:if test="@commented = 'yes'">
					<span class="lbexBrakets">
						<xsl:text>[</xsl:text>
					</span>
				</xsl:if>
				<!-- TB aug 2012 Bug fixing #1270 -->
				<xsl:if test="parent::quoted-block and not(preceding-sibling::*)">
					<xsl:call-template name="openQuotes"/>
				</xsl:if>
				<xsl:apply-templates/>
				<xsl:if test="@commented = 'yes'">
					<span class="lbexBrakets">
						<xsl:text>]</xsl:text>
					</span>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="indentLevel">
					<xsl:call-template name="defineIndentation">
						<xsl:with-param name="aLevelElement">subclause</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<!-- TB 1Feb2012 one more paragraph with back to zero indentation applied - to support 
					indentation in Firefox. transparent for other browsers -->
				<xsl:variable name="bringIndentToZeroAttr">
					<xsl:call-template name="zeroindentlevel">
						<xsl:with-param name="aLevelToIndent">
							<xsl:value-of select="$indentLevel"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<p>
					<xsl:attribute name="style">
						<xsl:value-of select="$bringIndentToZeroAttr"/>
					</xsl:attribute>
					<p>
						<xsl:attribute name="class">
							<xsl:value-of select="$indentLevel"/>
						</xsl:attribute>
						<xsl:if test="contains($appropReportedStyle ,'brackets') or @commented = 'yes'">
							<xsl:call-template name="openBracketStyles"/>
						</xsl:if>
						<xsl:if test="ancestor::quoted-block">
							<xsl:call-template name="openQuotes"/>
						</xsl:if>
						<xsl:apply-templates/>
						<xsl:variable name="isToCloseTheBrackets">
							<xsl:call-template name="toCloseTheBrakets"/>
						</xsl:variable>
						<xsl:choose>
							<!-- Check in aditional that this is the last element in deleted block -->
							<xsl:when
								test="(contains($appropReportedStyle , 'brackets') and child::text and $isToCloseTheBrackets = 'yes')">
								<xsl:text></xsl:text>
							</xsl:when>
						<xsl:when
								test="(contains($appropReportedStyle , 'brackets') and $isToCloseTheBrackets = 'yes')">
								<xsl:call-template name="closedBracketStyles"/>
							</xsl:when>
						</xsl:choose>
					<xsl:choose>
							<xsl:when test="@commented = 'yes' and (child::text or child::*/@commented='yes') and local-name()='subclause'">
								
							</xsl:when>
							<xsl:when test="@commented = 'yes' and not(child::text)">
								<xsl:call-template name="closedBracketStyles"/>
							</xsl:when>
						</xsl:choose>
					</p>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="item">
		<!-- TB Aug 2016 bug fixing 1434 -->
		<xsl:call-template name="printSectionAndDownStructure">
			<xsl:with-param name="thePrintingTemplate">displayItem</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="displayItem">
		<xsl:call-template name="createAnchor"/>
		<xsl:choose>
			<xsl:when test="@display-inline = 'yes-display-inline'">
				<!-- TB aug 2012 Bug fixing #1270 -->
				<xsl:if test="parent::quoted-block and not(preceding-sibling::*)">
					<xsl:call-template name="openQuotes"/>
				</xsl:if>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="indentLevel">
					<xsl:call-template name="defineIndentation">
						<xsl:with-param name="aLevelElement">item</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<!-- TB 1Feb2012 one more paragraph with back to zero indentation applied - to support 
				indentation in Firefox. transparent for other browsers -->
				<xsl:variable name="bringIndentToZeroAttr">
					<xsl:call-template name="zeroindentlevel">
						<xsl:with-param name="aLevelToIndent">
							<xsl:value-of select="$indentLevel"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<p>
					<xsl:attribute name="style">
						<xsl:value-of select="$bringIndentToZeroAttr"/>
					</xsl:attribute>
					<p>
						<xsl:attribute name="class">
							<xsl:value-of select="$indentLevel"/>
						</xsl:attribute>
						<xsl:if test="@commented = 'yes' or contains(ancestor::quoted-block/@reported-display-style,'brackets') ">
							<xsl:call-template name="openBracketStyles"/>
						</xsl:if>
						<xsl:if test="ancestor::quoted-block">
							<xsl:call-template name="openQuotes"/>
						</xsl:if>

						<xsl:apply-templates/>
						<xsl:if test="@commented = 'yes'">
							<xsl:call-template name="closedBracketStyles"/>
						</xsl:if>
					</p>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="quote/quote">
		<span class="lbexThinSpace">
			<xsl:text> </xsl:text>
		</span>
		<xsl:text>‘</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>’</xsl:text>
	</xsl:template>
	<xsl:template match="quote">
		<xsl:if
			test="local-name(preceding-sibling::*[1]) = 'deleted-phrase' and preceding-sibling::*[1]/@reported-display-style = 'bold-brackets'">
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="child::short-title">
				<xsl:call-template name="printQuotedText"/>
				<xsl:text>”</xsl:text>
			</xsl:when>
			<xsl:when test="parent::continuation-text or ancestor::quoted-block">
				<xsl:text>‘</xsl:text>
				<xsl:apply-templates/>
				<xsl:text>’</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="printQuotedText"/>
				<xsl:text>”</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<!--xsl:if
			test="local-name(following-sibling::*[1]) = 'deleted-phrase' and following-sibling::*[1]/@reported-display-style='bold-brackets'"-->
		<xsl:if
			test="contains(following-sibling::*[1]/@reported-display-style, 'brackets') or contains(following-sibling::*[1]/@reported-display-style, 'parentheses') or contains(following-sibling::*[1]/@commented, 'yes')">
			<!--xsl:text> </xsl:text-->

			<xsl:variable name="isNoTextFollowing">
				<xsl:call-template name="noTextInBetween">
					<xsl:with-param name="aFirstPartText">
						<xsl:value-of select="normalize-space(.)"/>
					</xsl:with-param>
					<xsl:with-param name="aSecondPartText">
						<xsl:value-of select="normalize-space(following-sibling::*[1]/text())"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<xsl:if test="$isNoTextFollowing = 'true'">
				<xsl:text> </xsl:text>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!-- TB 5May2010 I was absolutely unable to cach this text by normal model. Have to wrote this template to parse the text -->
	<xsl:template name="noTextInBetween">
		<xsl:param name="aFirstPartText"/>
		<xsl:param name="aSecondPartText"/>

		<xsl:variable name="aWholeText">
			<xsl:for-each select="parent::node()">
				<xsl:value-of select="."/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="stringPartToProceed_1">
			<xsl:value-of select="normalize-space(substring-before($aWholeText, $aSecondPartText))"
			/>
		</xsl:variable>
		<xsl:variable name="stringInBetween">
			<xsl:value-of
				select="substring-after($stringPartToProceed_1, normalize-space($aFirstPartText))"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="normalize-space($stringInBetween) = ''">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>false</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template match="term">
		<xsl:choose>
			<xsl:when test="parent::quote or ancestor::quoted-block">
				<xsl:text>‘</xsl:text>
				<xsl:apply-templates/>
				<xsl:text>’</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="printQuotedText"/>
				<xsl:text>”</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="enum-in-header">
		<xsl:variable name="currentElementStyle">
			<xsl:call-template name="getCurrentElementStyle"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when
				test="
					parent::header-in-text[@level = 'section' or @level = 'division'
					or @level = 'part' or @level = 'chapter' or @level = 'subpart' or @level = 'subchapter']">
				<span class="lbexTitleLevelOLC">
					<xsl:value-of select="."/>
				</span>
			</xsl:when>
			<xsl:when
				test="../parent::section and ../parent::section/header/enum-in-header and $currentElementStyle = 'tax'">
				<span class="lbexTextNormalBold">
					<xsl:value-of select="."/>
				</span>
			</xsl:when>
			<xsl:when
				test="../parent::section and ../parent::section/header/enum-in-header and $currentElementStyle = 'OLC'">
				<span class="lbexSectionlevelOLC">
					<xsl:value-of select="."/>
				</span>
			</xsl:when>
			<xsl:when
				test="../parent::section and ../parent::section/header/enum-in-header and $currentElementStyle != 'traditional'">
				<span class="lbexSmallTextNormal">
					<xsl:value-of select="."/>
				</span>
			</xsl:when>
			<xsl:when
				test="../parent::section and ../parent::section/header/enum-in-header and $currentElementStyle = 'traditional'">
				<span class="lbexTextNormal">
					<xsl:value-of select="."/>
				</span>
			</xsl:when>
			<xsl:when test="parent::toc-entry[@level = 'subdivision' or @level = 'subtitle']">
				<span style="text-transform:none;font-variant: normal;">
					<xsl:value-of select="."/>
				</span>
			</xsl:when>
			<xsl:when
				test="$currentElementStyle = 'OLC' or $currentElementStyle = 'traditional' or $currentElementStyle = 'tax' or $currentElementStyle = 'nuclear' or $currentElementStyle = 'traditional-inline' or $currentElementStyle = 'archaic-paragraph'">
				<span class="lbexTextNormal">
					<xsl:value-of select="."/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexTextNormal">
					<xsl:value-of select="."/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template match="header-in-text">

		<xsl:variable name="preCurrElementStyle">
			<xsl:choose>
				<!--commented by TB 30July2009 becasue on the web the default value alwasy exists -> and it gives OLC style all the time-->
				<xsl:when test="@style and @style != 'other'">
					<xsl:value-of select="@style"/>
				</xsl:when>
				<xsl:when test="@style and @style = 'other'">
					<xsl:value-of select="@other-style"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="currElementStyle">
			<xsl:choose>
				<xsl:when test="$preCurrElementStyle != 'OLC'">
					<!-- I want to exclude the default from that. It will be still some problems sometimes, where it will be defined - but the number of problems will be eliminated -->
					<xsl:value-of select="$preCurrElementStyle"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="getCurrentElementStyle"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:call-template name="ActualPrintHeaderInText">
			<xsl:with-param name="styleToPrint" select="$currElementStyle"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="ActualPrintHeaderInText">
		<xsl:param name="styleToPrint"/>
		<xsl:variable name="printItalicTextForReport">
			<xsl:call-template name="IsPrintItalicTextForReport"/>
		</xsl:variable>
		<xsl:variable name="classToPrint">
			<xsl:call-template name="getHeaderInTextClass">
				<xsl:with-param name="aStyle" select="$styleToPrint"/>
				<xsl:with-param name="aLevel" select="@level"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="toBeNeutralized">
			<xsl:call-template name="isNeutralizeSegment"/>
		</xsl:variable>
		<xsl:variable name="neutralBlockClassName">
			<xsl:call-template name="getNeutralBlockClassName"/>
		</xsl:variable>
		<xsl:variable name="neutralInlineClassName">
			<xsl:call-template name="getNeutralInlineClassName"/>
		</xsl:variable>
		<xsl:if test="$classToPrint != 'lowLevel'">
			<span>
				<xsl:attribute name="class">
					<xsl:value-of select="$classToPrint"/>
				</xsl:attribute>
				<xsl:choose>
					<xsl:when test="$printItalicTextForReport = 'yes'">
						<i>
							<xsl:if test="$toBeNeutralized = 'yes'">
								<xsl:attribute name="class">
									<xsl:value-of select="$neutralInlineClassName"/>
								</xsl:attribute>
							</xsl:if>
							<xsl:apply-templates/>
						</i>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates/>
					</xsl:otherwise>
				</xsl:choose>
			</span>
		</xsl:if>
		<xsl:if test="$classToPrint = 'lowLevel'">
			<xsl:call-template name="headerInTextLowerlevels">
				<xsl:with-param name="printReportItalic" select="$printItalicTextForReport"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="getHeaderInTextClass">
		<xsl:param name="aStyle"/>
		<xsl:param name="aLevel"/>
		<xsl:choose>
			<!-- OLC -->
			<xsl:when
				test="$aStyle = 'OLC' and ($aLevel = 'title' or $aLevel = 'chapter' or $aLevel = 'division' or $aLevel = 'subdivision')">
				<xsl:text>lbexTitleLevelTradIn</xsl:text>
			</xsl:when>
			<xsl:when
				test="$aStyle = 'OLC' and ($aLevel = 'subtitle' or $aLevel = 'subchapter' or $aLevel = 'subpart')">
				<xsl:text>lbexSubChapterLevelOLC</xsl:text>
			</xsl:when>
			<xsl:when test="$aStyle = 'OLC' and ($aLevel = 'part' or $aLevel = 'section')">
				<xsl:text>lbexSectionLevelIRCEx</xsl:text>
			</xsl:when>
			<xsl:when test="$aStyle = 'OLC' and $aLevel = 'subsection'">
				<xsl:text>lbexSectionLevelOLCnuclear</xsl:text>
			</xsl:when>
			<!-- Traditional - traditional inline - approbpriations -->
			<xsl:when
				test="((contains($aStyle, 'traditional') or $aStyle = 'appropriations') and $aLevel = 'title') or ($aLevel = 'subchapter' and $aStyle = 'traditional') or ($aLevel = 'division' and $aStyle = 'traditional')">
				<xsl:text>lbexHeaderAppropMajor</xsl:text>
			</xsl:when>
			<xsl:when
				test="(contains($aStyle, 'traditional') or $aStyle = 'appropriations') and ($aLevel = 'division' and ($aStyle = 'traditional-inline' or $aStyle = 'appropriations'))">
				<xsl:text>lbexTitleLevelTradIn</xsl:text>
			</xsl:when>
			<xsl:when
				test="(contains($aStyle, 'traditional') or $aStyle = 'appropriations') and ($aLevel = 'subtitle' or $aLevel = 'subpart' or ($aLevel = 'subdivision' and $aStyle = 'traditional'))">
				<xsl:text>lbexSubTitleLevelTrad</xsl:text>
			</xsl:when>
			<xsl:when
				test="(contains($aStyle, 'traditional') or $aStyle = 'appropriations') and ($aLevel = 'subdivision' and ($aStyle = 'traditional-inline' or $aStyle = 'appropriations'))">
				<xsl:text>lbexSubChapterLevelOLC</xsl:text>
			</xsl:when>
			<xsl:when test="$aLevel = 'chapter' and $aStyle = 'traditional'">
				<xsl:text>lbexTitleLevelTradIn</xsl:text>
			</xsl:when>
			<xsl:when
				test="$aLevel = 'chapter' and ($aStyle = 'traditional-inline' or $aStyle = 'appropriations')">
				<xsl:text>lbexTitleLevelTradEx</xsl:text>
			</xsl:when>
			<xsl:when
				test="$aLevel = 'subchapter' and ($aStyle = 'traditional-inline' or $aStyle = 'appropriations')">
				<xsl:text>lbexSubTitleLevelTrad</xsl:text>
			</xsl:when>
			<xsl:when
				test="(contains($aStyle, 'traditional') or $aStyle = 'appropriations') and $aLevel = 'part'">
				<xsl:text>lbexPartlevelTrad</xsl:text>
			</xsl:when>
			<xsl:when
				test="(contains($aStyle, 'traditional') or $aStyle = 'appropriations') and $aLevel = 'section'">
				<xsl:text>lbexAllcapnormal</xsl:text>
			</xsl:when>
			<xsl:when
				test="(contains($aStyle, 'traditional') or $aStyle = 'appropriations') and $aLevel = 'subsection'">
				<xsl:text>lbexSectionLevelOLCnuclear</xsl:text>
			</xsl:when>
			<!-- USC and Tax -->
			<xsl:when
				test="($aStyle = 'USC' or $aStyle = 'tax') and ($aLevel = 'title' or $aLevel = 'chapter' or $aLevel = 'part' or $aLevel = 'division' or $aLevel = 'subdivision')">
				<xsl:text>lbexTitleLevelTradIn</xsl:text>
			</xsl:when>
			<xsl:when test="($aStyle = 'USC') and $aLevel = 'subchapter'">
				<xsl:text>lbexHeaderAppropMajor</xsl:text>
			</xsl:when>
			<xsl:when test="($aStyle = 'tax') and $aLevel = 'subchapter'">
				<xsl:text>lbexSubChapterLevelOLC</xsl:text>
			</xsl:when>
			<xsl:when
				test="($aStyle = 'USC' or $aStyle = 'tax') and ($aLevel = 'subtitle' or $aLevel = 'subpart')">
				<xsl:text>lbexSubChapterLevelOLC</xsl:text>
			</xsl:when>
			<xsl:when test="$aStyle = 'USC' and $aLevel = 'section'">
				<xsl:text>lbexSectionlevelOLCBold</xsl:text>
			</xsl:when>
			<xsl:when test="$aStyle = 'tax' and $aLevel = 'section'">
				<xsl:text>lbexSectionLevelIRCEx</xsl:text>
			</xsl:when>
			<xsl:when test="($aStyle = 'USC' or $aStyle = 'tax') and $aLevel = 'subsection'">
				<xsl:text>lbexSectionLevelOLCnuclear</xsl:text>
			</xsl:when>
			<!-- Archaic and Archaic Paragraph -->
			<xsl:when
				test="contains($aStyle, 'archaic') and ($aLevel = 'title' or $aLevel = 'division' or $aLevel = 'subchapter')">
				<xsl:text>lbexHeaderAppropMajor</xsl:text>
			</xsl:when>
			<xsl:when
				test="contains($aStyle, 'archaic') and ($aLevel = 'subtitle' or $aLevel = 'subdivision')">
				<xsl:text>lbexSubTitleLevelTrad</xsl:text>
			</xsl:when>
			<xsl:when test="contains($aStyle, 'archaic') and $aLevel = 'chapter'">
				<xsl:text>lbexTitleLevelTradIn</xsl:text>
			</xsl:when>
			<xsl:when test="contains($aStyle, 'archaic') and $aLevel = 'part'">
				<xsl:text>lbexPartlevelTrad</xsl:text>
			</xsl:when>
			<xsl:when test="contains($aStyle, 'archaic') and $aLevel = 'subpart'">
				<xsl:text>lbexSubTitleLevelTrad</xsl:text>
			</xsl:when>
			<xsl:when test="contains($aStyle, 'archaic') and $aLevel = 'section'">
				<xsl:text>lbexAllcapnormal</xsl:text>
			</xsl:when>
			<xsl:when test="contains($aStyle, 'archaic') and $aLevel = 'subsection'">
				<xsl:text>lbexSubTitleLevelTrad</xsl:text>
			</xsl:when>
			<!-- appropriations -->
			<xsl:when test="$aLevel = 'appropriations-major'">
				<xsl:text>lbexHeaderAppropMajor</xsl:text>
			</xsl:when>
			<xsl:when test="$aLevel = 'appropriations-intermediate'">
				<xsl:text>lbexPartlevelTrad</xsl:text>
			</xsl:when>
			<xsl:when test="$aLevel = 'appropriations-small'">
				<xsl:text>lbexAllcapnormal</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<!--xsl:text>allcapnormal</xsl:text-->
				<xsl:text>lowLevel</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="italic">
		<i>
			<xsl:apply-templates/>
		</i>
	</xsl:template>
	<xsl:template match="fraction">
		<xsl:choose>
			<xsl:when test="contains(., '/')">
				<font size="2">
					<sup>
						<xsl:value-of select="substring-before(., '/')"/>
					</sup>
				</font>
				<xsl:text>⁄</xsl:text>
				<font size="1">
					<xsl:value-of select="substring-after(., '/')"/>
					<xsl:text> </xsl:text>
				</font>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="pre-form">
		<xsl:if test="not(@display = 'no')">
			<!-- TB 27Dec2007 running header -->
			<xsl:apply-templates select="first-page-header"/>
			<xsl:apply-templates select="first-page-date"/>
			<xsl:if test="not(//committee-report)">
				<xsl:apply-templates select="first-page-desc"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="suspension-floor-action">
			<xsl:apply-templates select="suspension-floor-action"/>
		</xsl:if>
		<xsl:if test="suspension-instructions">
			<xsl:apply-templates select="suspension-instructions"/>
		</xsl:if>
	</xsl:template>

	<!-- TB 27Dec2007 running header -->
	<xsl:template match="first-page-header">
		<xsl:choose>
			<xsl:when test="$isReport = 'yes'">
				<!-- nothing -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:if
					test="(@display = 'yes' or not(@display)) and not($amendType = 'engrossed-amendment')">
					<!--xsl:if
						test="contains(translate(//first-page-header/text(),$upper,$lower), 'committee') or //amendment-doc"-->

					<div style="text-align:center">
						<p class="lbexTitleLevelOLC">
							<xsl:value-of select="."/>
						</p>
					</div>
				</xsl:if>
				<!--/xsl:if-->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="first-page-desc" name="first-page-desc">
		<xsl:if
			test="(//first-page-desc/@display = 'yes' or not(//first-page-desc/@display)) and //first-page-desc/text() != ''">
			<div style="text-align:center">
				<hr class="lbexBlack"/>
				<xsl:choose>
					<xsl:when test="string-length(.) &lt; 80">
						<p style="text-align:center" class="lbexSessionEnrolled">
							<xsl:value-of select="//first-page-desc"/>
						</p>
					</xsl:when>
					<xsl:otherwise>
						<p style="text-align:left" class="lbexSessionEnrolled">
							<xsl:value-of select="//first-page-desc"/>
						</p>
					</xsl:otherwise>
				</xsl:choose>
				<hr class="lbexBlack"/>

			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="first-page-date">
		<xsl:if
			test="text() != '' and not(//committee-report) and not(@display = 'no') and not(parent::pre-form/@display = 'no')">
			<div style="text-align:center">
				<p class="lbexSectionLevelOLCnuclear">
					<xsl:value-of select="."/>
				</p>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="section/quoted-block/part/section">
		<!--xsl:text disable-output-escaping="yes">&lt;/center&gt;</xsl:text-->
		<p style="text-align:left">
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<!--no section included  ************************-->
	<xsl:template match="section/quoted-block">
		<!--xsl:call-template name="ApplyTemplWithSimpleIndentP"/-->
		<p style="text-align:left" class="lbexHang">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="section/quoted-block[@display-inline = 'yes-display-inline']">
		<!-- TB May2011 bug#1202 - condition added -->
		<xsl:if test="not(child::*[1]/@display-inline = 'no-display-inline')">
			<xsl:text> “</xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template
		match="section[@display-inline = 'no-display-inline']/paragraph[@display-inline = 'no-display-inline']/quoted-block[@display-inline = 'no-display-inline' or not(@display-inline)]">
		<xsl:choose>
			<xsl:when test="@display-inline = 'yes-display-inline'">
				<xsl:text> “</xsl:text>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="section/paragraph/quoted-block[@display-inline = 'yes-display-inline']">
		<!--xsl:text> “</xsl:text-->
		<xsl:text> </xsl:text>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="section/paragraph/subparagraph/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph/quoted-block[@display-inline = 'yes-display-inline']">
		<!--xsl:text> “</xsl:text-->
		<xsl:text> </xsl:text>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="section/paragraph/subparagraph[@indent = 'up2']/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template match="section/paragraph[@indent = 'up1']/subparagraph/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template match="section/paragraph/subparagraph/clause/quoted-block">
		<!--ul>
			<ul>
				<ul-->
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		<!--/ul>
			</ul>
		</ul-->
	</xsl:template>
	<!-- TB Sep-2016 template changed - bug fixing #1438 -->
	<xsl:template
		match="section/paragraph/subparagraph/clause/quoted-block[@display-inline = 'yes-display-inline']">
		<!--xsl:text> “</xsl:text-->
		<xsl:text> </xsl:text>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="section/paragraph/subparagraph/clause[@indent = 'up2']/quoted-block">
		<ul>
			<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		</ul>
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph[@display-inline = 'yes-display-inline']/clause[@display-inline = 'yes-display-inline']/quoted-block">
		<ul>
			<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		</ul>
	</xsl:template>
	<xsl:template match="section/paragraph/subparagraph[@indent = 'up1']/clause/quoted-block">
		<ul>
			<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		</ul>
	</xsl:template>
	<xsl:template match="section/paragraph/subparagraph/clause[@indent = 'up3']/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template match="section/paragraph/subparagraph[@indent = 'up2']/clause/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template match="section/paragraph[@indent = 'up1']/subparagraph/clause/quoted-block">
		<!--ul-->
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		<!--/ul-->
	</xsl:template>
	<xsl:template
		match="section/paragraph[@indent = 'up1']/subparagraph/clause[@indent = 'up1']/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template match="section/paragraph/subparagraph/clause/subclause/quoted-block">
		<!--ul>
			<ul>
				<ul>
					<ul-->
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		<!--/ul>
				</ul>
			</ul>
		</ul-->
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph/clause/subclause/quoted-block[@display-inline = 'yes-display-inline']">
		<xsl:text> “</xsl:text>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph/clause[@indent = 'up2']/subclause/quoted-block">
		<!--ul-->
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		<!--/ul-->
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph[@indent = 'up1']/clause/subclause/quoted-block">
		<!--ul>
			<ul-->
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		<!--/ul>
		</ul-->
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph/clause/subclause[@indent = 'up4']/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph/clause[@indent = 'up3']/subclause/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph[@indent = 'up2']/clause/subclause/quoted-block">
		<!--ul-->
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		<!--/ul-->
	</xsl:template>
	<xsl:template
		match="section/paragraph[@indent = 'up1']/subparagraph/clause/subclause/quoted-block">
		<!--ul>
			<ul-->
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		<!--/ul>
		</ul-->
	</xsl:template>
	<xsl:template
		match="section/paragraph[@indent = 'up1']/subparagraph/clause[@indent = 'up1']/subclause/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template match="section/paragraph/subparagraph/clause/subclause/item/quoted-block">
		<!--ul>
			<ul>
				<ul>
					<ul>
						<ul-->
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		<!--/ul>
					</ul>
				</ul>
			</ul>
		</ul-->
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph/clause/subclause/item/quoted-block[@display-inline = 'yes-display-inline']">
		<xsl:text> “</xsl:text>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph/clause/subclause/item[@indent = 'up5']/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph/clause/subclause[@indent = 'up4']/item/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph/clause[@indent = 'up3']/subclause/item/quoted-block">
		<!--ul-->
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		<!--/ul-->
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph[@indent = 'up2']/clause/subclause/item/quoted-block">
		<!--ul>
			<ul-->
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		<!--/ul>
		</ul-->
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph[@indent = 'up1']/clause/subclause/item/quoted-block">
		<!--ul>
			<ul>
				<ul-->
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		<!--/ul>
			</ul>
		</ul-->
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph[@indent = 'up2']/clause/subclause[@indent = 'up1']/item/quoted-block">
		<!--ul-->
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		<!--/ul-->
	</xsl:template>
	<xsl:template
		match="section/paragraph[@indent = 'up1']/subparagraph/clause/subclause/item/quoted-block">
		<!--ul>
			<ul>
				<ul-->
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		<!--/ul>
			</ul>
		</ul-->
	</xsl:template>
	<xsl:template
		match="section/paragraph[@indent = 'up1']/subparagraph/clause[@indent = 'up1']/subclause/item[@indent = 'up1']/quoted-block">
		<!--ul-->
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		<!--/ul-->
	</xsl:template>
	<xsl:template match="section/paragraph/subparagraph/clause/subclause/item/subitem/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph/clause/subclause/item/subitem/quoted-block[@display-inline = 'yes-display-inline']">
		<xsl:text> “</xsl:text>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph/clause/subclause[@indent = 'up3']/item/subitem/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph[@indent = 'up1']/clause/subclause/item/subitem[@indent = 'up1']/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph/clause/subclause/item[@indent = 'up5']/subitem/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph/clause/subclause[@indent = 'up4']/item/subitem/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph/clause[@indent = 'up3']/subclause/item/subitem/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph[@indent = 'up2']/clause/subclause/item/subitem/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="section/paragraph/subparagraph[@indent = 'up2']/clause/subclause/item/subitem[@indent = 'up1']/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="section/paragraph[@indent = 'up1']/subparagraph/clause/subclause/item/subitem/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="section/paragraph[@indent = 'up1']/subparagraph/clause[@indent = 'up1']/subclause/item[@indent = 'up1']/subitem/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<!--end of no section included **********************************-->
	<!-- section included-->
	<xsl:template match="subsection/quoted-block">
		<xsl:choose>
			<xsl:when test="@display-inline = 'yes-display-inline'">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="subsection/paragraph/quoted-block">
		<xsl:choose>
			<xsl:when
				test="
					parent::paragraph[@display-inline = 'yes-display-inline'] and
					not(child::section)">
				<xsl:text> </xsl:text>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="@display-inline = 'yes-display-inline'">
				<xsl:text> </xsl:text>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="./@style = 'other' and ./@other-style = 'archaic'">
				<p style="text-align:left" class="lbexIndentSubsection">
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p style="text-align:left" class="lbexIndentSubsection">
					<xsl:apply-templates/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="subsection/paragraph[@indent = 'up1']/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template match="subsection/paragraph/subparagraph/quoted-block">
		<xsl:choose>
			<xsl:when test="@display-inline = 'yes-display-inline'">
				<xsl:text> </xsl:text>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="parent::subparagraph[@display-inline = 'yes-display-inline']">
				<p style="text-align:left" class="lbexIndentSubpar">
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when test="parent::subparagraph[@indent = 'up1']">
				<p style="text-align:left" class="lbexIndentSubpar">
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when test="./@style = 'tax' and child::toc">
				<p style="text-align:left" class="lbexNonIndentClause">
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when test="./@style = 'tax'">
				<p style="text-align:left" class="lbexIndentSubpar">
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when test="local-name(child::*[1]) = 'section'">
				<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
			</xsl:when>
			<xsl:otherwise>
				<p style="text-align:left" class="lbexIndentClause">
					<xsl:apply-templates/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- TB to be reviewed  -->
	<xsl:template match="subsection/paragraph/subparagraph[@indent = 'up2']/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template match="subsection/paragraph[@indent = 'up1']/subparagraph/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template match="subsection/paragraph/subparagraph/clause/quoted-block">
		<xsl:choose>
			<xsl:when test="@display-inline = 'yes-display-inline'">
				<xsl:text> </xsl:text>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<p style="text-align:left" class="lbexIndentClause">
					<xsl:apply-templates/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="subsection/paragraph/subparagraph/clause[@indent = 'up2']/quoted-block">
		<p style="text-align:left" class="lbexIndentClause">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph[@display-inline = 'yes-display-inline']/clause[@display-inline = 'yes-display-inline']/quoted-block">
		<p style="text-align:left" class="lbexIndentClause">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="subsection/paragraph/subparagraph[@indent = 'up1']/clause/quoted-block">
		<p style="text-align:left" class="lbexIndentSubpar">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="subsection/paragraph/subparagraph/clause[@indent = 'up3']/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template match="subsection/paragraph/subparagraph[@indent = 'up2']/clause/quoted-block">
		<p style="text-align:left" class="lbexIndent">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="subsection/paragraph[@indent = 'up1']/subparagraph/clause/quoted-block">
		<p style="text-align:left" class="lbexIndentClause">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph[@indent = 'up1']/subparagraph/clause[@indent = 'up1']/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template match="subsection/paragraph/subparagraph/clause/subclause/quoted-block">
		<xsl:choose>
			<xsl:when test="@display-inline = 'yes-display-inline'">
				<xsl:text> </xsl:text>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<p class="lbexIndentSubclause" style="text-align:left">
					<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph/clause[@indent = 'up2']/subclause/quoted-block">
		<p class="lbexIndentSubclause" style="text-align:left">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph[@indent = 'up1']/clause/subclause/quoted-block">
		<p class="lbexIndentSubclause" style="text-align:left">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph/clause/subclause[@indent = 'up4']/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph/clause[@indent = 'up3']/subclause/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph[@indent = 'up2']/clause/subclause/quoted-block">
		<p class="lbexIndentSubclause">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph[@indent = 'up1']/subparagraph/clause/subclause/quoted-block">
		<p class="lbexIndentSubclause">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph[@indent = 'up1']/subparagraph/clause[@indent = 'up1']/subclause/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template match="subsection/paragraph/subparagraph/clause/subclause/item/quoted-block">
		<xsl:choose>
			<xsl:when test="@display-inline = 'yes-display-inline'">
				<xsl:text> </xsl:text>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<p class="lbexIndentItem">
					<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph/clause/subclause/item[@indent = 'up5']/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph/clause/subclause[@indent = 'up4']/item/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph/clause[@indent = 'up3']/subclause/item/quoted-block">
		<p class="lbexIndentItem">
			<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		</p>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph[@indent = 'up2']/clause/subclause/item/quoted-block">
		<p class="lbexIndentItem">
			<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
		</p>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph[@indent = 'up1']/clause/subclause/item/quoted-block">
		<p style="text-align:left" class="lbexIndentItem">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph[@indent = 'up2']/clause/subclause[@indent = 'up1']/item/quoted-block">
		<p style="text-align:left" class="lbexIndentSubclause">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph[@indent = 'up1']/subparagraph/clause/subclause/item/quoted-block">
		<p style="text-align:left" class="lbexIndentItem">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph[@indent = 'up1']/subparagraph/clause[@indent = 'up1']/subclause/item[@indent = 'up1']/quoted-block">
		<p style="text-align:left" class="lbexIndentItem">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph/clause/subclause/item/subitem/quoted-block">
		<xsl:choose>
			<xsl:when test="@display-inline = 'yes-display-inline'">
				<xsl:text> “</xsl:text>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>

				<p style="text-align:left" class="lbexIndentSubItem">
					<xsl:apply-templates/>
				</p>

			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph/clause/subclause[@indent = 'up3']/item/subitem/quoted-block">

		<p style="text-align:left" class="lbexIndentSubclause">
			<xsl:apply-templates/>
		</p>

	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph[@indent = 'up1']/clause/subclause/item/subitem[@indent = 'up1']/quoted-block">

		<p style="text-align:left" class="lbexIndentSubItem">
			<xsl:apply-templates/>
		</p>

	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph/clause/subclause/item[@indent = 'up5']/subitem/quoted-block">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph/clause/subclause[@indent = 'up4']/item/subitem/quoted-block">

		<p style="text-align:left" class="lbexIndentSubclause">
			<xsl:apply-templates/>
		</p>

	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph/clause[@indent = 'up3']/subclause/item/subitem/quoted-block">

		<p style="text-align:left" class="lbexIndentItem">
			<xsl:apply-templates/>
		</p>

	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph[@indent = 'up2']/clause/subclause/item/subitem/quoted-block">

		<p style="text-align:left" class="lbexIndentSubItem">
			<xsl:apply-templates/>
		</p>

	</xsl:template>
	<xsl:template
		match="subsection/paragraph/subparagraph[@indent = 'up2']/clause/subclause/item/subitem[@indent = 'up1']/quoted-block">

		<p style="text-align:left" class="lbexIndentSubItem">
			<xsl:apply-templates/>
		</p>

	</xsl:template>
	<xsl:template
		match="subsection/paragraph[@indent = 'up1']/subparagraph/clause/subclause/item/subitem/quoted-block">

		<p style="text-align:left" class="lbexIndentSubItem">
			<xsl:apply-templates/>
		</p>

	</xsl:template>
	<xsl:template
		match="subsection/paragraph[@indent = 'up1']/subparagraph/clause[@indent = 'up1']/subclause/item[@indent = 'up1']/subitem/quoted-block">

		<p style="text-align:left" class="lbexIndentItem">
			<xsl:apply-templates/>
		</p>

	</xsl:template>
	<!-- end of section included-->
	<!--beginning of senate section -->
	<!-- subsection -->
	<xsl:template match="paragraph[@indent = 'subsection']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:if test="ancestor::quoted-block">
				<xsl:call-template name="openQuotes"/>
			</xsl:if>
			<xsl:apply-templates select="enum"/>
			<xsl:apply-templates select="text"/>

			<p class="lbexIndentSubpar">
				<xsl:apply-templates select="subparagraph"/>
			</p>

		</p>
	</xsl:template>

	<xsl:template match="paragraph/subparagraph[@indent = 'paragraph']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph[@display-inline = 'yes-display-inline']/subparagraph[@indent = 'paragraph']">

		<p style="text-align:left" class="lbexIndentSubpar">
			<xsl:call-template name="ActualPrintText"/>
		</p>

	</xsl:template>
	<xsl:template match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'paragraph']">

		<p style="text-align:left" class="lbexIndentSubpar">
			<xsl:call-template name="ActualPrintText"/>
		</p>

	</xsl:template>

	<xsl:template match="paragraph/subparagraph[@indent = 'subsection']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'subsection']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>

	<xsl:template match="paragraph/subparagraph/clause/subclause[@indent = 'clause']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'subsection']/clause[@indent = 'clause']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template match="paragraph/subparagraph/clause[@indent = 'subparagraph']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph/subparagraph[@display-inline = 'yes-display-inline']/clause[@indent = 'subparagraph']">

		<p style="text-align:left" class="lbexIndentSubsection">
			<xsl:call-template name="ActualPrintText"/>
		</p>

	</xsl:template>
	<xsl:template
		match="paragraph/subparagraph[@indent = 'paragraph']/clause[@indent = 'subparagraph']">

		<p style="text-align:left" class="lbexIndentSubsection">
			<xsl:call-template name="ActualPrintText"/>
		</p>

	</xsl:template>
	<xsl:template match="paragraph/subparagraph/clause[@indent = 'paragraph']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'subsection']/clause[@indent = 'paragraph']">

		<p style="text-align:left" class="lbexIndentSubsection">
			<xsl:call-template name="ActualPrintText"/>
		</p>

	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'subsection']/clause[@indent = 'subsection' and @display-inline = 'no-display-inline']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@display-inline = 'yes-display-inline']/clause[@indent = 'subsection' and @display-inline = 'no-display-inline']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'subsection']/clause[@indent = 'subsection' and @display-inline = 'yes-display-inline']">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="paragraph/subparagraph/clause/subclause[@indent = 'subparagraph']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'paragraph']/clause[@indent = 'paragraph']/subclause[@indent = 'subparagraph']">

		<p style="text-align:left" class="lbexIndentSubpar">
			<xsl:call-template name="ActualPrintText"/>
		</p>

	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'subsection']/clause[@indent = 'paragraph']/subclause[@indent = 'subparagraph']">

		<p style="text-align:left" class="lbexIndentSubpar">
			<xsl:call-template name="ActualPrintText"/>
		</p>

	</xsl:template>
	<xsl:template match="paragraph/subparagraph/clause/subclause[@indent = 'paragraph']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'subsection']/clause[@indent = 'subsection']/subclause[@indent = 'subsection' and @display-inline = 'no-display-inline']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@display-inline = 'no-display-inline']/clause[@display-inline = 'no-display-inline']/subclause[@indent = 'subsection' and @display-inline = 'no-display-inline']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'subsection']/clause[@indent = 'subsection']/subclause[@indent = 'subsection' and @display-inline = 'yes-display-inline']">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template
		match="paragraph/subparagraph/clause[@indent = 'subparagraph']/subclause[@indent = 'clause']">

		<p style="text-align:left" class="lbexIndentClause">
			<xsl:call-template name="ActualPrintText"/>
		</p>

	</xsl:template>

	<xsl:template match="paragraph/subparagraph/clause/subclause/item[@indent = 'subclause']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph/subparagraph/clause/subclause[@indent = 'clause']/item[@indent = 'subclause']">

		<p style="text-align:left" class="lbexIndentSubclause">
			<xsl:call-template name="ActualPrintText"/>
		</p>

	</xsl:template>
	<xsl:template
		match="paragraph/subparagraph/clause[@indent = 'subparagraph']/subclause[@indent = 'clause']/item[@indent = 'clause']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template match="paragraph/subparagraph/clause/subclause/item[@indent = 'clause']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph/subparagraph/clause[@display-inline = 'yes-display-inline']/subclause[@display-inline = 'yes-display-inline']/item[@indent = 'clause']">

		<p style="text-align:left" class="lbexIndentClause">
			<xsl:call-template name="ActualPrintText"/>
		</p>

	</xsl:template>
	<xsl:template
		match="paragraph/subparagraph[@display-inline = 'yes-display-inline']/clause[@indent = 'subparagraph']/subclause[@display-inline = 'yes-display-inline']/item[@indent = 'clause']">

		<p style="text-align:left" class="lbexIndentClause">
			<xsl:call-template name="ActualPrintText"/>
		</p>

	</xsl:template>
	<xsl:template
		match="paragraph/subparagraph/clause/subclause[@indent = 'subparagraph']/item[@indent = 'clause']">
		<ul>
			<p style="text-align:left" class="lbexIndent">
				<xsl:call-template name="ActualPrintText"/>
			</p>
		</ul>
	</xsl:template>
	<xsl:template
		match="paragraph/subparagraph/clause[@indent = 'subparagraph']/subclause[@indent = 'subparagraph']/item[@indent = 'subparagraph']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template match="paragraph/subparagraph/clause/subclause/item[@indent = 'subparagraph']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'paragraph']/clause[@indent = 'paragraph']/subclause[@indent = 'paragraph']/item[@indent = 'subparagraph']">

		<p style="text-align:left" class="lbexIndentSubpar">
			<xsl:call-template name="ActualPrintText"/>
		</p>

	</xsl:template>
	<xsl:template match="paragraph/subparagraph/clause/subclause/item[@indent = 'paragraph']">
		<xsl:choose>
			<xsl:when test="./@display-inline = 'yes-display-inline'">
				<xsl:call-template name="ActualPrintText"/>
			</xsl:when>
			<xsl:otherwise>
				<p align="justiy" class="lbexIndent">
					<xsl:call-template name="ActualPrintText"/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'subsection']/clause[@indent = 'subsection']/subclause[@indent = 'subsection']/item[@indent = 'subsection' and @display-inline = 'no-display-inline']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'subsection']/clause[@indent = 'subsection']/subclause[@indent = 'subsection']/item[@indent = 'subsection' and @display-inline = 'yes-display-inline']">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="paragraph/subparagraph/clause/subclause/item/subitem[@indent = 'item']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph/subparagraph/clause/subclause/item/subitem[@indent = 'subclause']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template match="paragraph/subparagraph/clause/subclause/item/subitem[@indent = 'clause']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph/subparagraph/clause/subclause/item/subitem[@indent = 'paragraph']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph/subparagraph/clause/subclause/item/subitem[@indent = 'subparagraph']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'paragraph']/clause[@indent = 'paragraph']/subclause[@indent = 'paragraph']/item[@indent = 'subparagraph']/subitem[@indent = 'subparagraph']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'paragraph']/clause[@indent = 'subparagraph']/subclause[@display-inline = 'yes-display-inline']/item[@indent = 'subparagraph']/subitem[@indent = 'subparagraph']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'subsection']/clause[@indent = 'subsection']/subclause[@indent = 'subsection']/item[@indent = 'subsection']/subitem[@indent = 'subsection' and @display-inline = 'no-display-inline']">
		<p style="text-align:left" class="lbexIndent">
			<xsl:call-template name="ActualPrintText"/>
		</p>
	</xsl:template>
	<xsl:template
		match="paragraph[@indent = 'subsection']/subparagraph[@indent = 'subsection']/clause[@indent = 'subsection']/subclause[@indent = 'subsection']/item[@indent = 'subsection']/subitem[@indent = 'subsection' and @display-inline = 'yes-display-inline']">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- TB to be reviewed  -->

	<xsl:template match="multi-column-toc-entry">
		<xsl:variable name="printItalicTextForReport">
			<xsl:call-template name="IsPrintItalicTextForReport"/>
		</xsl:variable>

		<xsl:variable name="isItalicToc">
			<xsl:choose>
				<xsl:when test="$printItalicTextForReport = 'yes'">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when
					test="ancestor::*[@reported-display-style = 'italic'] and not(ancestor::*[@reported-display-style = 'italic']/descendant::*[@changed = 'not-changed']) and not(ancestor::*[@reported-display-style = 'italic']/descendant::*[@reported-display-style = 'strikethrough'])">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when
					test="ancestor::*[@reported-display-style = 'boldface-italic'] and not(ancestor::*[@reported-display-style = 'italic']/descendant::*[@changed = 'not-changed']) and not(ancestor::*[@reported-display-style = 'italic']/descendant::*[@reported-display-style = 'strikethrough'])">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="@bold = 'on' and $isItalicToc = 'no'">
				<!--b-->
				<xsl:call-template name="ActualPrintMultiColumnToc">
					<xsl:with-param name="isBold">yes</xsl:with-param>
					<xsl:with-param name="isItalic">no</xsl:with-param>
				</xsl:call-template>
				<!--/b-->
			</xsl:when>
			<xsl:when test="@bold = 'on' and $isItalicToc = 'yes'">
				<!--span style="font-weight:bold;font:italic;"-->
				<!--i-->
				<xsl:call-template name="ActualPrintMultiColumnToc">
					<xsl:with-param name="isBold">yes</xsl:with-param>
					<xsl:with-param name="isItalic">yes</xsl:with-param>
				</xsl:call-template>
				<!--/i-->
				<!--/span-->
			</xsl:when>
			<xsl:when test="not(@bold = 'on') and $isItalicToc = 'yes'">
				<!--span style="ffont:italic;">
					<i-->
				<xsl:call-template name="ActualPrintMultiColumnToc">
					<xsl:with-param name="isBold">no</xsl:with-param>
					<xsl:with-param name="isItalic">yes</xsl:with-param>
				</xsl:call-template>
				<!--i>
				</span-->
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="ActualPrintMultiColumnToc">
					<xsl:with-param name="isBold">no</xsl:with-param>
					<xsl:with-param name="isItalic">no</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="loop">
		<xsl:param name="index">0</xsl:param>
		<xsl:param name="val"/>
		<xsl:if test="$index &gt; 0">
			<xsl:text>.</xsl:text>
			<xsl:call-template name="loop">
				<xsl:with-param name="index" select="$index - 1"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!--end of senate section -->

	<xsl:template match="amendment-list">
		<xsl:variable name="theListType" select="@amendment-list-type"/>
		<xsl:call-template name="ActualPrintList">
			<xsl:with-param name="listType" select="$theListType"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="list">
		<xsl:variable name="theListType" select="@list-type"/>
		<xsl:variable name="theListLevelClass">
			<xsl:call-template name="getListLevelClass">
				<xsl:with-param name="aListLevel" select="./@level"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="thePrintingClass">
			<xsl:call-template name="getOutputStyle"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$thePrintingClass='hidden'">
				<div>
					<xsl:attribute name="class">
						<xsl:value-of select="$thePrintingClass"/>
					</xsl:attribute>
					<xsl:choose>
						<xsl:when test="$theListLevelClass != ''">
							<div>
								<xsl:attribute name="class">
									<xsl:value-of select="$theListLevelClass"/>
								</xsl:attribute>
								<xsl:call-template name="ActualPrintList">
									<xsl:with-param name="listType" select="$theListType"/>
								</xsl:call-template>
							</div>
						</xsl:when>
					<xsl:otherwise>
							<xsl:call-template name="ActualPrintList">
								<xsl:with-param name="listType" select="$theListType"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$theListLevelClass != ''">
						<div>
							<xsl:attribute name="class">
								<xsl:value-of select="$theListLevelClass"/>
							</xsl:attribute>
							<xsl:call-template name="ActualPrintList">
								<xsl:with-param name="listType" select="$theListType"/>
							</xsl:call-template>
						</div>
					</xsl:when>
				<xsl:otherwise>
						<xsl:call-template name="ActualPrintList">
							<xsl:with-param name="listType" select="$theListType"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="getListLevelClass">
		<xsl:param name="aListLevel"/>
		<xsl:choose>
			<xsl:when test="$aListLevel = 'section'">
				<xsl:text>lbexIndent</xsl:text>
			</xsl:when>
			<xsl:when test="$aListLevel = 'subsection'">
				<xsl:text>lbexIndent</xsl:text>
			</xsl:when>
			<xsl:when test="$aListLevel = 'paragraph'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="$aListLevel = 'subparagraph'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="$aListLevel = 'clause'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="$aListLevel = 'subclause'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:when test="$aListLevel = 'item'">
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:when>
			<xsl:when test="$aListLevel = 'subitem'">
				<xsl:text>lbexIndentSubItem</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndent</xsl:text>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!-- *******************deleted-phrase********************************** -->
	<xsl:template match="deleted-phrase">
		<xsl:param name="source"/>

		<xsl:choose>
			<!-- TB May2011 #1207 -->
			<xsl:when test="parent::after-quoted-block and $source != 'after-quoted-block'"/>
			<xsl:when
				test="(ancestor::appropriations-major or ancestor::appropriations-intermediate or ancestor::appropriations-small) and parent::header">

				<!--xsl:call-template name="displayHeader"/-->
				<xsl:call-template name="PrintHeaderForAppropriations"/>
			</xsl:when>
			<xsl:when
				test="(ancestor::appropriations-major or ancestor::appropriations-intermediate or ancestor::appropriations-small) and parent::subheader">

				<xsl:call-template name="ActualDisplayApppropriationsSubheader"/>

			</xsl:when>
			<xsl:when
				test="(ancestor::appropriations-major or ancestor::appropriations-intermediate or ancestor::appropriations-small)">
				<xsl:call-template name="ActualPrintAppropriationElement"/>
			</xsl:when>
			<xsl:when test="parent::header">
				<xsl:choose>
					<xsl:when test="contains(@reported-display-style,'brackets')">
						<span class="lbexBrakets">
							<xsl:text>[</xsl:text>
						</span>
						<xsl:call-template name="displayHeader"/>
						<span class="lbexBrakets">
							<xsl:text>]</xsl:text>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text> </xsl:text>
						<span class="lbexTextStrikethrough">
							<xsl:call-template name="displayHeader"/>
						</span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when
				test="
					(parent::enum and ./@deleted-display-style = 'bold-brackets') or
					(parent::enum and ./@reported-display-style = 'bold-brackets')">
				<!--span style="font-family:Arial Black;"-->
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
				<xsl:value-of select="."/>
				<!--/span-->
				<span class="lbexBrakets">
					<xsl:text>]</xsl:text>
				</span>
			</xsl:when>
			<xsl:when test="@reported-display-style = 'strikethrough'">
				<span class="lbexTextStrikethrough">
					<xsl:if test="ancestor::*/@reported-display-style = 'italic'">
						<xsl:attribute name="style">font-style: normal;</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="(./@reported-display-style = 'boldface-italic' or @reported-display-style = 'boldface-italic')">
				<b>
					<i class="lbexTextNeutral">
						<xsl:apply-templates/>
					</i>
				</b>
			</xsl:when>
			<xsl:when test="(@reported-display-style = 'brackets-boldface-italic')">
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
				<b>
					<i class="lbexTextNeutral">
						<xsl:apply-templates/>
					</i>
				</b>
				<span class="lbexBrakets">
					<xsl:text>]</xsl:text>
				</span>
			</xsl:when>
			<xsl:when test="@reported-display-style = 'parentheses-boldface-italic'">
				<span class="lbexBrakets">
					<xsl:text>(</xsl:text>
				</span>
				<b>
					<i class="lbexTextNeutral">
						<xsl:apply-templates/>
					</i>
				</b>
				<span class="lbexBrakets">
					<xsl:text>)</xsl:text>
				</span>
			</xsl:when>
			<xsl:when test="(@reported-display-style = 'brackets-boldface-roman')">
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
				<b>
					<xsl:apply-templates/>
				</b>
				<span class="lbexBrakets">
					<xsl:text>]</xsl:text>
				</span>
			</xsl:when>
			<xsl:when test="(@reported-display-style = 'boldface-roman')">
				<b>
					<xsl:apply-templates/>
				</b>
			</xsl:when>
			<xsl:when test="@reported-display-style = 'parentheses-boldface-roman'">
				<span class="lbexBrakets">
					<xsl:text>(</xsl:text>
				</span>
				<b>
					<xsl:apply-templates/>
				</b>
				<span class="lbexBrakets">
					<xsl:text>)</xsl:text>
				</span>
			</xsl:when>
			<xsl:when
				test="
					(./@reported-display-style = 'parentheses-boldface-italic') or
					(./@reported-display-style = 'brackets-boldface-italic')">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when
				test="(./@reported-display-style = 'bold-brackets' or @reported-display-style = 'bold-brackets')">
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
				<xsl:apply-templates/>
				<span class="lbexBrakets">
					<xsl:text>]</xsl:text>
				</span>
			</xsl:when>
			<xsl:when test="@reported-display-style = 'italic'">
				<i class="lbexTextNeutral">
					<xsl:apply-templates/>
				</i>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexTextStrikethrough">
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<!-- ********************No Text Before***************** -->
	<xsl:template name="NoTextBefore">
		<xsl:param name="aCurrentText"/>

		<xsl:variable name="aWholeText">
			<xsl:for-each select="parent::node()">
				<xsl:value-of select="."/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="stringPartToProceed_1">
			<xsl:value-of select="normalize-space(substring-before($aWholeText, $aCurrentText))"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when
				test="parent::subparagraph or parent::clause or parent::subclause or parent::item or parent::subitem">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when test="$stringPartToProceed_1 = ''">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>false</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- **********No text before******************** -->
	<xsl:template name="SpecialTextBefore">
		<xsl:param name="aCurrentText"/>

		<xsl:variable name="aWholeText">
			<xsl:for-each select="parent::node()">
				<xsl:value-of select="."/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="stringPartToProceed_1">
			<xsl:value-of select="normalize-space(substring-before($aWholeText, $aCurrentText))"/>
		</xsl:variable>
		<xsl:variable name="stringInBefore">
			<xsl:value-of
				select="substring($stringPartToProceed_1, string-length($stringPartToProceed_1), 1)"
			/>
		</xsl:variable>
		<xsl:variable name="string5ChBefore">
			<xsl:value-of
				select="substring($stringPartToProceed_1, string-length($stringPartToProceed_1) - 4, 5)"
			/>
		</xsl:variable>
		<xsl:variable name="string10ChBefore">
			<xsl:value-of
				select="substring($stringPartToProceed_1, string-length($stringPartToProceed_1) - 9, 10)"
			/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$stringInBefore = '('">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when test="$stringInBefore = '['">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when test="$stringInBefore = '+'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when test="$stringInBefore = '-'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when test="$stringInBefore = '—'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when test="$stringInBefore = '–'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when test="$stringInBefore = '‘'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when test="$stringInBefore = '“'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when test="$string5ChBefore = '&amp;' ">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when test="$string10ChBefore = '[[[mdash]]]'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when test="$string10ChBefore = '[[[ndash]]]'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when test="$string10ChBefore = '[[[ensp]]]'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>false</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- **********To generate em-dash************* -->
	<xsl:template name="GenerateEmDash">
		<xsl:param name="IsForFollowingSibling"/>
		<xsl:param name="currentStyle"/>
		<xsl:variable name="IAmInLowLevelStructure">
			<xsl:choose>
				<xsl:when test="ancestor::subparagraph">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when test="ancestor::clasue">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when test="ancestor::subclause">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when test="ancestor::item">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when test="ancestor::subitem">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:when
					test="ancestor::rules-subparagraph or ancestor::rules-subdivision or ancestor::rules-item or ancestor::rules-subitem">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="style">
			<xsl:choose>
				<xsl:when test="not($currentStyle = '')">
					<xsl:value-of select="$currentStyle"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>OLC</xsl:text>
				</xsl:otherwise>
				<!--xsl:otherwise>
					<xsl:call-template name="GetNearestAncestorStyleRecursive"/>
				</xsl:otherwise-->
			</xsl:choose>

		</xsl:variable>

		<xsl:variable name="isNoTextBefore">
			<xsl:call-template name="NoTextBefore">
				<xsl:with-param name="aCurrentText" select="."/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="isInRamseyerGenerate">
			<xsl:call-template name="isRamseyerGenerateOn"/>
		</xsl:variable>

		<xsl:variable name="isInCordonGenerate">
			<xsl:call-template name="isInCordonGenerateOn"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when
				test="$isInRamseyerGenerate = 'no' and ($IAmInLowLevelStructure = 'yes' or ancestor-or-self::section or ancestor-or-self::subsection)">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="$isInCordonGenerate = 'no' and ($IAmInLowLevelStructure = 'yes' or ancestor-or-self::section or ancestor-or-self::subsection)">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::subsection or parent::paragraph or parent::subparagraph or parent::clause or parent::subclause or parent::item or parent::subitem">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="$IsForFollowingSibling = 'true' and (string(parent::header) != '' and not(parent::header[@display-inline = 'no-display-inline']) and (not(ancestor::section[1]/@level-type = 'undesignated') or (ancestor::section[1]/@level-type = 'undesignated' and string(ancestor::section[1]/enum) != ''))) and $isNoTextBefore = 'true'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="$IsForFollowingSibling = 'true' and (string(parent::header) != '' and not(parent::header[@display-inline = 'no-display-inline']) and (not(ancestor::section[1]/@level-type = 'undesignated') or (ancestor::section[1]/@level-type = 'undesignated' and string(ancestor::section[1]/enum) != ''))) and $isNoTextBefore = 'true'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="string(./header) != '' and not(./header[@display-inline = 'no-display-inline']) and (not(./@level-type = 'undesignated') or (./@level-type = 'undesignated' and string(./enum) != ''))">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="$IsForFollowingSibling = 'true' and ancestor::section and $style = 'nuclear' and (parent::header or parent::text) and $isNoTextBefore = 'true'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="local-name() = 'section' and $style = 'nuclear' and (./header or ./text)">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="$IsForFollowingSibling = 'true' and ancestor::subsection and not(contains($style, 'archaic')) and (parent::header or parent::text) and $isNoTextBefore = 'true'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="local-name() = 'subsection' and not(contains($style, 'archaic')) and (./header or ./text)">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="$IsForFollowingSibling = 'true' and ancestor::paragraph and not($style = 'archaic-paragraph') and (parent::header or parent::text) and $isNoTextBefore = 'true'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="local-name() = 'paragraph' and not($style = 'archaic-paragraph') and (./header or ./text)">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="$IsForFollowingSibling = 'true' and ancestor::nstruction-paragraph and (parent::header or parent::text) and $isNoTextBefore = 'true'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when test="local-name() = 'nstruction-paragraph' and (./header or ./text)">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="$IsForFollowingSibling = 'true' and ancestor::instruction-subparagraph and (parent::header or parent::text) and $isNoTextBefore = 'true'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when test="local-name() = 'instruction-subparagraph' and (./header or ./text)">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::section and $style = 'traditional-inline' and following-sibling::*">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="$IsForFollowingSibling = 'true' and $IAmInLowLevelStructure = 'yes' and (parent::header or parent::text) and $isNoTextBefore = 'true'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="$IAmInLowLevelStructure = 'yes' and (./header or ./text) and $isNoTextBefore = 'true'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>false</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--************************  -->
	<xsl:template name="spaceBeforeAddedDeleted">
		<xsl:variable name="isSpecialTextBefore">
			<xsl:call-template name="SpecialTextBefore">
				<xsl:with-param name="aCurrentText" select="."/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="isNoTextBefore">
			<xsl:call-template name="NoTextBefore">
				<xsl:with-param name="aCurrentText" select="."/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="IsGenerateEmDash">
			<xsl:call-template name="GenerateEmDash">
				<xsl:with-param name="IsForFollowingSibling">
					<xsl:text>true</xsl:text>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="parent::enum">
				<!-- no space -->
			</xsl:when>
			<xsl:when
				test="parent::toc-entry and (local-name(preceding-sibling::*[1]) = 'added-phrase' or local-name(preceding-sibling::*[1]) = 'deleted-phrase')">
				<!-- no space-->
			</xsl:when>
			<xsl:when
				test="parent::header and not(preceding-sibling::*) and $isNoTextBefore = 'true'">
				<!-- no space -->
			</xsl:when>
			<xsl:when
				test="substring(normalize-space(.), 1, 1) = ',' or substring(normalize-space(.), 1, 1) = '.' or substring(normalize-space(.), 1, 1) = ':' or substring(normalize-space(.), 1, 1) = ';'">
				<!-- if starts with punctuation -->
				<!-- no space -->
			</xsl:when>
			<xsl:when test="$isSpecialTextBefore = 'true'">
				<!-- if starts with punctuation -->
				<!-- no space -->
			</xsl:when>
			<xsl:when test="normalize-space(.) = ''">
				<!-- if empty content of the phrase -->
				<!-- no space -->
			</xsl:when>
			<xsl:when
				test="(parent::term or parent::quote) and not(preceding-sibling::*) and $isNoTextBefore = 'true'">
				<!-- no space -->
			</xsl:when>
			<xsl:when
				test="substring(preceding-sibling::text()[1], string-length(preceding-sibling::text()[1]) - 10) = '[[[ldquo]]]' and local-name() = 'italic'">
				<!-- TB Sep 2011 bug fixing 1221 -->
				<!-- no space -->
			</xsl:when>
			<xsl:when
				test="(local-name(ancestor::*[2]) = 'term' or local-name(ancestor::*[2]) = 'quote') and not(parent::*/preceding-sibling) and not(preceding-sibling::*) and $isNoTextBefore = 'true'">
				<!-- no space -->
			</xsl:when>
			<xsl:when test="$IsGenerateEmDash = 'true'">
				<!-- no space -->
			</xsl:when>
			<xsl:when
				test=". = 'l' or . = 'll' or (contains(., 'l–') and substring-before(., 'l–') = '') or (contains(., 'l[[[ndash]]]') and substring-before(., 'l[[[ndash]]]') = '')">
				<!-- but #1169 lower case l we put after number to the italic tag - to distinguish from the number 1 -->
				<!-- exception - no space should be inserted -->
				<!-- no space -->
			</xsl:when>
			<xsl:when test="parent::committee-report-header and $isNoTextBefore = 'true'">
				<!-- no space -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:text disable-output-escaping="yes"> </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="added-phrase">
		<xsl:param name="source"/>

		<xsl:variable name="needNeutralization">
			<xsl:choose>
				<xsl:when
					test="ancestor::*[@reported-display-style = 'strikethrough'][1] and not(ancestor::*[@changed = 'not-changed']/ancestor::*[@reported-display-style = 'strikethrough'])">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="neutralBlockClassName">
			<xsl:call-template name="getNeutralBlockClassName"/>
		</xsl:variable>
		<xsl:variable name="neutralInlineClassName">
			<xsl:call-template name="getNeutralInlineClassName"/>
		</xsl:variable>

		<xsl:call-template name="spaceBeforeAddedDeleted"/>
		<xsl:choose>
			<!-- TB May2011 #1207 -->
			<xsl:when test="parent::after-quoted-block and $source != 'after-quoted-block'"/>
			<!-- TB 22Apr2009 fixing for appropriations -->
			<xsl:when
				test="(ancestor::appropriations-major or ancestor::appropriations-intermediate or ancestor::appropriations-small) and parent::header">

				<!--xsl:call-template name="displayHeader"/-->
				<xsl:call-template name="PrintHeaderForAppropriations"/>
			</xsl:when>
			<xsl:when
				test="(ancestor::appropriations-major or ancestor::appropriations-intermediate or ancestor::appropriations-small) and parent::subheader">

				<xsl:call-template name="ActualDisplayApppropriationsSubheader"/>

			</xsl:when>
			<xsl:when test="parent::header and ./@added-display-style = 'italic'">
				<i>
					<xsl:if test="$needNeutralization = 'yes'">
						<xsl:attribute name="class">
							<xsl:value-of select="$neutralInlineClassName"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:call-template name="displayHeader"/>
				</i>
			</xsl:when>
			<xsl:when test="./@added-display-style = 'italic' and ancestor::quoted-block">
				<i>
					<xsl:if test="$needNeutralization = 'yes'">
						<xsl:attribute name="class">
							<xsl:value-of select="$neutralInlineClassName"/>
						</xsl:attribute>
					</xsl:if>

					<xsl:text> </xsl:text>
					<xsl:value-of select="."/>
				</i>
			</xsl:when>
			<xsl:when
				test="./@added-display-style = 'italic' or ./@reported-display-style = 'italic'">
				<span>
					<xsl:if test="$needNeutralization = 'yes'">
						<xsl:attribute name="class">
							<xsl:value-of select="$neutralBlockClassName"/>
						</xsl:attribute>
					</xsl:if>
					<i>
						<xsl:apply-templates/>
					</i>
					</span>
			<!-- TB 24Oct2011 removing extra space after added phrase -->
				<!--xsl:if test="not(following-sibling::text()='.')">
						<xsl:text> </xsl:text>
					</xsl:if-->

			</xsl:when>
			<xsl:when test="(@reported-display-style = 'brackets-boldface-italic')">
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
				<b>
					<i>
						<xsl:if test="$needNeutralization = 'yes'">
							<xsl:attribute name="class">
								<xsl:value-of select="$neutralInlineClassName"/>
							</xsl:attribute>
						</xsl:if>
						<xsl:apply-templates/>
					</i>
				</b>
				<span class="lbexBrakets">
					<xsl:text>]</xsl:text>
				</span>
			</xsl:when>
			<xsl:when test="@reported-display-style = 'parentheses-boldface-italic'">
				<span class="lbexBrakets">
					<xsl:text>(</xsl:text>
				</span>
				<b>
					<i>
						<xsl:if test="$needNeutralization = 'yes'">
							<xsl:attribute name="class">
								<xsl:value-of select="$neutralInlineClassName"/>
							</xsl:attribute>
						</xsl:if>
						<xsl:apply-templates/>
					</i>
				</b>
				<span class="lbexBrakets">
					<xsl:text>)</xsl:text>
				</span>
			</xsl:when>
			<xsl:when test="(@reported-display-style = 'brackets-boldface-roman')">
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
				<b>
					<xsl:apply-templates/>
				</b>
				<span class="lbexBrakets">
					<xsl:text>]</xsl:text>
				</span>
			</xsl:when>
			<xsl:when test="(@reported-display-style = 'bold-brackets')">
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
				<xsl:apply-templates/>
				<span class="lbexBrakets">
					<xsl:text>]</xsl:text>
				</span>
			</xsl:when>
			<xsl:when test="@reported-display-style = 'parentheses-boldface-roman'">
				<span class="lbexBrakets">
					<xsl:text>(</xsl:text>
				</span>
				<b>
					<xsl:apply-templates/>
				</b>
				<span class="lbexBrakets">
					<xsl:text>)</xsl:text>
				</span>
			</xsl:when>
			<xsl:when
				test="(./@reported-display-style = 'boldface-roman') or @eported-display-style = 'boldface-roman'">
				<b>
					<xsl:apply-templates/>
				</b>
			</xsl:when>
			<xsl:when
				test="
					(./@reported-display-style = 'parentheses-boldface-italic') or
					(./@reported-display-style = 'brackets-boldface-italic')">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when
				test="./@reported-display-style = 'boldface-italic' or @reported-display-style = 'boldface-italic'">
				<span class="lbexBldItalic">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="./@reported-display-style = 'strikethrough' or @reported-display-style = 'strikethrough'">
				<span class="lbexTextStrikethrough">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<i>
					<xsl:if test="$needNeutralization = 'yes'">
						<xsl:attribute name="class">
							<xsl:value-of select="$neutralInlineClassName"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:text> </xsl:text>
					<xsl:value-of select="."/>
				</i>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="official-title-amendment">
		<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
	</xsl:template>
	<!--************* Actual Print List Non Ordered or Ordered ****************-->
	<xsl:template name="ActualPrintList">
		<xsl:param name="listType"/>

		<xsl:choose>
			<xsl:when test="$listType = 'bulleted'">
				<ul>
					<xsl:apply-templates/>
				</ul>
			</xsl:when>
			<xsl:when test="$listType = 'numbered'">
				<ol>
					<xsl:apply-templates/>
				</ol>
			</xsl:when>
			<xsl:when test="$listType = 'lettered'">
				<ol class="lbexListStyle">
					<xsl:apply-templates/>
				</ol>
			</xsl:when>
			<xsl:otherwise>
				<ul>
					<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
				</ul>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>
	<!-- ******************List Items************************************** -->
	<xsl:template name="isLastListItem">
		<xsl:choose>
			<xsl:when
				test="position() = last()">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ******************  Is Last Element************************************** -->
	<xsl:template name="isLastElementInLoop">
		<xsl:choose>
			<xsl:when
				test="
					parent::section/following-sibling::*/@changed = 'not-changed' or not(parent::section/following-sibling) or
					parent::subsection/following-sibling::*/@changed = 'not-changed' or not(parent::subsection/following-sibling) or parent::paragraph/following-sibling::*/@changed = 'not-changed' or not(parent::paragraph/following-sibling) or
					parent::subparagraph/following-sibling::*/@changed = 'not-changed' or not(parent::subparagraph/following-sibling) or
					parent::item/following-sibling::*/@changed = 'not-changed' or not(parent::item/following-sibling) or
					parent::subitem/following-sibling::*/@changed = 'not-changed' or not(parent::subitem/following-sibling) or
					parent::clause/following-sibling::*/@changed = 'not-changed' or not(parent::clause/following-sibling) or
					parent::subclause/following-sibling::*/@changed = 'not-changed' or not(parent::subclause/following-sibling)">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- TB 6Feb2008 Added logic about numbered, bulleted, lettered -->
	<xsl:template match="list-item">
		<xsl:variable name="listType" select="parent::list/@list-type"/>
		<!-- ************Put the opening tag according to the list type*************** -->
		<xsl:choose>
			<!--xsl:when test="$listType !='' and not ($listType='none')"-->
			<xsl:when test="$listType != ''">
				<xsl:call-template name="ActualPrintListItem">
					<xsl:with-param name="aListType" select="$listType"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- TB fixing problem in firefox and ie11 March-23-2015 -->
				<xsl:call-template name="ActualPrintListItem">
					<xsl:with-param name="aListType">
						<xsl:text>none</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="toc-quoted-entry">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- *********Amendment  List  Item************************************************** -->
	<xsl:template match="amendment-list-item">
		<xsl:variable name="listType" select="parent::amendment-list/@amendment-list-type"/>
		<!-- ************Put the opening tag according to the list type*************** -->
		<xsl:choose>
			<xsl:when test="$listType != ''">
				<xsl:call-template name="ActualPrintListItem">
					<xsl:with-param name="aListType" select="$listType"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<p style="text-align:left" class="lbexIndent">
					<xsl:call-template name="ActualPrintText"/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="following-sibling::*">
			<br/>
			<div style="text-align:center">
				<hr class="lbexGeneralStyle100"/>
			</div>
			<br/>
		</xsl:if>
	</xsl:template>
	<!-- Bulleted List -->
	<xsl:template name="ActualPrintListItem">
		<xsl:param name="aListType"/>
		<xsl:variable name="theListLevelClass">
			<xsl:call-template name="getListLevelClass">
				<xsl:with-param name="aListLevel" select="./@level"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="thePrintingClass">
			<xsl:call-template name="getOutputStyle"/>
			</xsl:variable>
	<xsl:choose>
			<xsl:when test="$thePrintingClass='hidden'">
				<div>
					<xsl:attribute name="class">
						<xsl:value-of select="$thePrintingClass"/>
					</xsl:attribute>
					<xsl:choose>
						<xsl:when test="$aListType = 'none' or not($aListType)">
							<ul>
								<div>
									<xsl:attribute name="class">
										<xsl:value-of select="$theListLevelClass"/>
									</xsl:attribute>
									<xsl:call-template name="ActualPrintText"/>
								</div>
							</ul>
						</xsl:when>
						<xsl:otherwise>
							<li>
								<div>
									<xsl:attribute name="class">
										<xsl:value-of select="$theListLevelClass"/>
									</xsl:attribute>
									<xsl:attribute name="align">
										<xsl:text>justify</xsl:text>
									</xsl:attribute>
									<xsl:call-template name="ActualPrintText"/>
								</div>
							</li>
						</xsl:otherwise>
					</xsl:choose>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$aListType = 'none' or not($aListType)">
						<ul>
							<div>
								<xsl:attribute name="class">
									<xsl:value-of select="$theListLevelClass"/>
								</xsl:attribute>
								<xsl:call-template name="ActualPrintText"/>
							</div>
						</ul>
					</xsl:when>
					<xsl:otherwise>
						<li>
							<div>
								<xsl:attribute name="class">
									<xsl:value-of select="$theListLevelClass"/>
								</xsl:attribute>
								<xsl:attribute name="align">
									<xsl:text>justify</xsl:text>
								</xsl:attribute>
								<xsl:call-template name="ActualPrintText"/>
							</div>
						</li>
					</xsl:otherwise>
				</xsl:choose>	
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>



	<xsl:template match="inline-comment">
		<xsl:choose>
			<xsl:when test="@display = 'no'"/>
			<xsl:otherwise>
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
				<xsl:apply-templates/>
				<span class="lbexBrakets">
					<xsl:text>]</xsl:text>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="legis-comment">
		<xsl:choose>
			<xsl:when test="@display = 'no'"/>
			<xsl:otherwise>
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
				<xsl:apply-templates/>
				<span class="lbexBrakets">
					<xsl:text>]</xsl:text>
				</span>
				<p/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="superscript">
		<sup>
			<xsl:apply-templates/>
		</sup>
	</xsl:template>
	<xsl:template match="subscript">
		<sub>
			<xsl:apply-templates/>
		</sub>
	</xsl:template>
	<xsl:template match="lbexBold">
		<b>
			<xsl:apply-templates/>
		</b>
	</xsl:template>
	<xsl:template match="attestation">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="attestation-date">
		<!--ul-->
		<!-- TB 2Jan2009 -->
		<!--p class="nonIndentSubsection"-->
		<p class="lbexIndentSubsection">
			<xsl:apply-templates/>
		</p>
		<!--/ul-->
	</xsl:template>
	<!--changes made 12/29/05-->
	<xsl:template match="attestation-group">
		<xsl:choose>
			<xsl:when
				test="
					$billStage = 'Received-in-Senate' or $billStage = 'Received-in-House'
					or $billStage = 'Referred-in-Senate' or $billStage = 'Referred-in-House' or
					$resolutionStage = 'Referred-in-Senate' or $resolutionStage = 'Received-in-Senate' or $resolutionStage = 'Placed-on-Calendar-Senate'">
				<xsl:apply-templates select="attestation-date"/>
				<ul>
					<table style="width:95%">
						<tr>
							<td style="text-align:left">
								<span class="lbexAttest">Attest:</span>
							</td>
							<td style="text-align:right">
								<span class="lbexSimplecap">
									<!-- TB 30Aug2007 #280 display=No is default -->
									<xsl:call-template name="displayAttestor">
										<xsl:with-param name="displayFlag"
											select="attestor/@display"/>
									</xsl:call-template>
								</span>
								<xsl:text disable-output-escaping="yes">&#x00A0;</xsl:text>
								<xsl:text disable-output-escaping="yes">&#x00A0;</xsl:text>
								<xsl:text disable-output-escaping="yes">&#x00A0;</xsl:text>
							</td>
						</tr>
						<tr>
							<td/>
							<td style="text-align:right">
								<xsl:value-of select="role"/>
							</td>
						</tr>
					</table>
				</ul>
			</xsl:when>

			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="role">
		<xsl:choose>
			<xsl:when
				test="
					$resolutionStage = 'Enrolled-in-Senate' or $documentStage = 'Enrolled-Bill' or $resolutionStage = 'Enrolled-House' or
					$resolutionStage = 'Re-enrolled-in-Senate' or $billStage = 'Re-Enrolled-Bill'">
				<xsl:if
					test="$resolutionStage = 'Enrolled-in-Senate' and not(contains($resolutionType, 'joint'))">
					<p class="lbexIndent"> Attest: </p>
				</xsl:if>
				<xsl:if
					test="(not(./attestor) or ./attestor[@display = 'no']) and not(parent::attestation-group/attestor) and not(contains($resolutionType, 'joint'))">
					<p class="lbexIndent"> Attest: </p>
				</xsl:if>
				<P style="text-align:right">
					<table style="width:40%">
						<tr>
							<td style="text-align:right">
								<i>
									<br/>
									<br/>
									<br/>
									<br/>
									<xsl:choose>
										<xsl:when
											test=". = 'Vice President of the United States and President of the Senate.'">
											<xsl:text> Vice President of the United States and </xsl:text>
											<xsl:text disable-output-escaping="yes">&#x00A0;</xsl:text>
											<xsl:text disable-output-escaping="yes">&#x00A0;</xsl:text>
											<br/>
											<xsl:text>President of the Senate.</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates/>
											<xsl:text disable-output-escaping="yes">&#x00A0;</xsl:text>
											<xsl:text disable-output-escaping="yes">&#x00A0;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</i>
							</td>
						</tr>
					</table>
				</P>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not($resolutionType = 'senate-concurrent')">
					<p class="lbexIndent">
						<xsl:apply-templates select="@attestation-date"/>
					</p>
				</xsl:if>
				<xsl:if
					test="not(local-name(preceding-sibling::*[1]) = 'attestor') and not(local-name(preceding-sibling::*[1]) = 'proxy')">
					<p class="lbexIndentSubsection"> Attest: </p>

					<br/>
					<br/>
					<br/>
					<br/>
				</xsl:if>
				<p style="text-align:right">
					<i class="lbexTextNeutral">
						<xsl:apply-templates/>
						<xsl:text disable-output-escaping="yes">&#x00A0;</xsl:text>
						<xsl:text disable-output-escaping="yes">&#x00A0;</xsl:text>
					</i>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="proxy">
		<table style="width:50%">
			<tr>
				<td style="text-align:right">
					<xsl:text>By</xsl:text>
				</td>
			</tr>

		</table>
		<xsl:if test="@display = 'yes'">
			<xsl:apply-templates/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="committee-appointment-paragraph">
		<p class="lbexIndent" style="text-align:left">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="linebreak">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="pagebreak">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="attestor">
		<xsl:if test="not($billStage = 'Enrolled-Bill') and not(contains($documentType, 'joint'))">
			<!--span class="nonIndentSubsection">Attest:</span-->
			<!-- inserted paragraph by TB 15Dec2009 - file amd_section -->
			<p/>
			<span class="lbexNonIndentParagraph">Attest:</span>
			<xsl:if test="not(@display = 'yes')">
				<br/>
				<br/>
				<br/>
				<br/>
				<br/>
				<br/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="@display = 'yes'">
			<table class="lbexGeneralStyle100">
				<tr>
					<td style="text-align:right" class="lbexInitialCapTrad">
						<xsl:value-of select="."/>
					</td>
				</tr>
			</table>
		</xsl:if>
	</xsl:template>

	<!-- ************ Congress Text ****************************** -->
	<xsl:template name="CongressText">
		<!-- TB 29-Aug-2007 #667 the code was extracted to templated and new piece was added -->
		<!-- TB 8july2010 checking about the font of the title - puting picture of the Goudy Text font -->
		<xsl:param name="CNum"/>
		<xsl:variable name="theSrcImeage">
			<xsl:choose>
				<xsl:when
					test="contains($CNum, '106') or contains(normalize-space(translate($CNum, $upper, $lower)), 'one hundred sixth')">
					<xsl:text>EnrolledTitle_106.JPG</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains($CNum, '107') or contains(normalize-space(translate($CNum, $upper, $lower)), 'one hundred seventh')">
					<xsl:text>EnrolledTitle_107.JPG</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains($CNum, '108') or contains(normalize-space(translate($CNum, $upper, $lower)), 'one hundred eighth')">
					<xsl:text>EnrolledTitle_108.JPG</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains($CNum, '109') or contains(normalize-space(translate($CNum, $upper, $lower)), 'one hundred ninth')">
					<xsl:text>EnrolledTitle_109.JPG</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains($CNum, '110') or contains(normalize-space(translate($CNum, $upper, $lower)), 'one hundred tenth')">
					<xsl:text>EnrolledTitle_110.JPG</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains($CNum, '111') or contains(normalize-space(translate($CNum, $upper, $lower)), 'one hundred eleventh')">
					<xsl:text>EnrolledTitle_111.JPG</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains($CNum, '112') or contains(normalize-space(translate($CNum, $upper, $lower)), 'one hundred twelfth')">
					<xsl:text>EnrolledTitle_112.JPG</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains($CNum, '113') or contains(normalize-space(translate($CNum, $upper, $lower)), 'one hundred thirteenth')">
					<xsl:text>EnrolledTitle_113.JPG</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains($CNum, '114') or contains(normalize-space(translate($CNum, $upper, $lower)), 'one hundred fourteen')">
					<xsl:text>EnrolledTitle_114.JPG</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains($CNum, '115') or contains(normalize-space(translate($CNum, $upper, $lower)), 'one hundred fifteenth')">
					<xsl:text>EnrolledTitle_115.JPG</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains($CNum, '116') or contains(normalize-space(translate($CNum, $upper, $lower)), 'one hundred sixteenth')">
					<xsl:text>EnrolledTitle_116.JPG</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains($CNum, '117') or contains(normalize-space(translate($CNum, $upper, $lower)), 'one hundred seventeenth')">
					<xsl:text>EnrolledTitle_117.JPG</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>NoImage</xsl:text>
				</xsl:otherwise>
			</xsl:choose>

			<!-- It is a potential to check if the file exists on the source - according to that to decide what to print. but in the current version of XSL it still does not work -->
			<!--xsl:choose >
				<xsl:when test="document($tempImageName)">
					<xsl:value-of select="$tempImageName"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>NoImage</xsl:text>
				</xsl:otherwise>
			</xsl:choose-->

		</xsl:variable>
		<!-- TB 9-Jan-2014 fixing back title for committee reports -->
		<xsl:if test="congress/@display = 'yes' or (not(congress/@display) and congress)">
			<xsl:call-template name="actualPrintCongressName">
				<xsl:with-param name="CNum" select="$CNum"/>
				<xsl:with-param name="imageURL" select="$theSrcImeage"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="actualPrintCongressName">
		<xsl:param name="CNum"/>
		<xsl:param name="imageURL"/>
		<xsl:choose>
			<xsl:when test="$imageURL != 'NoImage'">
				<xsl:call-template name="PrintImageByName">
					<xsl:with-param name="imageName" select="$imageURL"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="contains($CNum, '106')">
				<div style="text-align:center">One Hundred Sixth Congress <BR/> of the <BR/> United
					States of America</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '107')">
				<div style="text-align:center">One Hundred Seventh Congress <BR/> of the <BR/>
					United States of America</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '108')">
				<div style="text-align:center">One Hundred Eighth Congress <BR/> of the <BR/> United
					States of America</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '109')">
				<div style="text-align:center">One Hundred Ninth Congress <BR/> of the <BR/> United
					States of America</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '110')">
				<div style="text-align:center">One Hundred Tenth Congress <BR/> of the <BR/> United
					States of America</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '111')">
				<div style="text-align:center">One Hundred Eleventh Congress <BR/> of the <BR/>
					United States of America</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '112')">
				<div style="text-align:center">One Hundred Twelfth Congress <BR/> of the <BR/>
					United States of America</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '113')">
				<div style="text-align:center">One Hundred Thirteenth Congress <BR/> of the <BR/>
					United States of America</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '114')">
				<div style="text-align:center">One Hundred Fourteenth Congress <BR/> of the <BR/>
					United States of America</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '115')">
				<div style="text-align:center">One Hundred Fifteenth Congress <BR/> of the <BR/>
					United States of America</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '116')">
				<div style="text-align:center">One Hundred Sixteenth Congress <BR/> of the <BR/>
					United States of America</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '117')">
				<div style="text-align:center">One Hundred Seventeenth Congress <BR/> of the <BR/>
					United States of America</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="contains($CNum, 'of the')">
					<div style="text-align:center"><xsl:value-of
							select="substring-before($CNum, 'of the')"/><BR/> of the <BR/> United
						States of America</div>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="actualPrintCongressNameShort">
		<xsl:param name="CNum"/>
		<xsl:param name="imageURL"/>
		<xsl:choose>
			<xsl:when test="$imageURL != 'NoImage'">
				<xsl:call-template name="PrintImageByName">
					<xsl:with-param name="imageName" select="$imageURL"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="contains($CNum, '106')">
				<div style="text-align:center">One Hundred Sixth Congress </div>
			</xsl:when>
			<xsl:when test="contains($CNum, '107')">
				<div style="text-align:center">One Hundred Seventh Congress </div>
			</xsl:when>
			<xsl:when test="contains($CNum, '108')">
				<div style="text-align:center">One Hundred Eighth Congress</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '109')">
				<div style="text-align:center">One Hundred Ninth Congress</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '110')">
				<div style="text-align:center">One Hundred Tenth Congress</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '111')">
				<div style="text-align:center">One Hundred Eleventh Congress</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '112')">
				<div style="text-align:center">One Hundred Twelfth Congress </div>
			</xsl:when>
			<xsl:when test="contains($CNum, '113')">
				<div style="text-align:center">One Hundred Thirteenth Congress</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '114')">
				<div style="text-align:center">One Hundred Fourteenth Congress</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '115')">
				<div style="text-align:center">One Hundred Fifteenth Congress</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '116')">
				<div style="text-align:center">One Hundred Sixteenth Congress</div>
			</xsl:when>
			<xsl:when test="contains($CNum, '117')">
				<div style="text-align:center">One Hundred Seventeenth Congress</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="contains($CNum, 'of the')">
					<div style="text-align:center">
						<xsl:value-of select="substring-before($CNum, 'of the')"/>
					</div>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="PrintImageByName">
		<xsl:param name="imageName"/>
		<!-- TB 9July2010  I have to do this template, because unfortunately I cannot print image by parameter - so this not spart choose staement must be done -->
		<xsl:choose>
			<xsl:when test="$imageName = 'EnrolledTitle_106.JPG'">
				<div style="text-align:center">
					<img src="EnrolledTitle_106.JPG" alt=""/>
				</div>
			</xsl:when>
			<xsl:when test="$imageName = 'EnrolledTitle_107.JPG'">
				<div style="text-align:center">
					<img src="EnrolledTitle_107.JPG" alt=""/>
				</div>
			</xsl:when>
			<xsl:when test="$imageName = 'EnrolledTitle_108.JPG'">
				<div style="text-align:center">
					<img src="EnrolledTitle_108.JPG" alt=""/>
				</div>
			</xsl:when>
			<xsl:when test="$imageName = 'EnrolledTitle_109.JPG'">
				<div style="text-align:center">
					<img src="EnrolledTitle_109.JPG" alt=""/>
				</div>
			</xsl:when>
			<xsl:when test="$imageName = 'EnrolledTitle_110.JPG'">
				<div style="text-align:center">
					<img src="EnrolledTitle_110.JPG" alt=""/>
				</div>
			</xsl:when>
			<xsl:when test="$imageName = 'EnrolledTitle_111.JPG'">
				<div style="text-align:center">
					<img src="EnrolledTitle_111.JPG" alt=""/>
				</div>
			</xsl:when>
			<xsl:when test="$imageName = 'EnrolledTitle_112.JPG'">
				<div style="text-align:center">
					<img src="EnrolledTitle_112.JPG" alt=""/>
				</div>
			</xsl:when>
			<xsl:when test="$imageName = 'EnrolledTitle_113.JPG'">
				<div style="text-align:center">
					<img src="EnrolledTitle_113.JPG" alt=""/>
				</div>
			</xsl:when>
			<xsl:when test="$imageName = 'EnrolledTitle_114.JPG'">
				<div style="text-align:center">
					<img src="EnrolledTitle_114.JPG" alt=""/>
				</div>
			</xsl:when>
			<xsl:when test="$imageName = 'EnrolledTitle_115.JPG'">
				<div style="text-align:center">
					<img src="EnrolledTitle_115.JPG" alt=""/>
				</div>
			</xsl:when>
			<xsl:when test="$imageName = 'EnrolledTitle_116.JPG'">
				<div style="text-align:center">
					<img src="EnrolledTitle_116.JPG" alt=""/>
				</div>
			</xsl:when>
			<xsl:when test="$imageName = 'EnrolledTitle_117.JPG'">
				<div style="text-align:center">
					<img src="EnrolledTitle_117.JPG" alt=""/>
				</div>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="SessionTextAll">
		<!-- TB 29-Aug-2007 #667 the code was extracted to templated and new piece was added -->
		<xsl:param name="SText"/>
		<xsl:if test="session/@display = 'yes' or (not(session/@display and session))">
			<xsl:choose>
				<!--1st -->
				<xsl:when test="contains($SText, 'First')">
					<xsl:text>AT THE FIRST SESSION</xsl:text>
				</xsl:when>
				<!--2nd-->
				<xsl:when test="contains($SText, 'Second')">
					<xsl:text>AT THE SECOND SESSION</xsl:text>
				</xsl:when>
				<xsl:when test="contains($SText, '1')">
					<xsl:text>AT THE FIRST SESSION</xsl:text>
				</xsl:when>
				<!--2nd-->
				<xsl:when test="contains($SText, '2')">
					<xsl:text>AT THE SECOND SESSION</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text disable-output-escaping="yes"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="actionDateText">

		<!-- TB 29-Aug-2007 #668 -->
		<xsl:value-of select="action/action-desc"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="action/action-date"/>
	</xsl:template>
	<xsl:template name="displayAttestor">
		<xsl:param name="displayFlag"/>
		<xsl:choose>
			<xsl:when test="$displayFlag = 'no'"/>
			<xsl:otherwise>
				<xsl:value-of select="translate(attestor, $upper, $lower)"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>
	<!--TB 31Aug2007 template displays division word. in case of the parent has traditional stype it should be printed in title traditional style  -->
	<xsl:template name="displayEnumDivision">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when
				test="$aCurrElementStyle = 'traditional' or contains($aCurrElementStyle, 'archaic')">
				<span class="lbexTitleLevelTrad">
					<xsl:call-template name="actualDisplayDivision"/>
				</span>
			</xsl:when>
			<xsl:when
				test="$aCurrElementStyle = 'traditional-inline' or $aCurrElementStyle = 'appropriations'">
				<span class="lbexTitleLevelTradIn">
					<xsl:call-template name="actualDisplayDivision"/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexTitleLevelOLC">
					<xsl:call-template name="actualDisplayDivision"/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ***********************Display Division********************* -->
	<xsl:template name="actualDisplayDivision">
		<xsl:call-template name="ActualPrintHeadingOf">
			<xsl:with-param name="aTextToAdd">
				<xsl:text>DIVISION </xsl:text>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<!-- ***********************Division Body************************* -->
	<xsl:template name="displayDivisionBody">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when
				test="$aCurrElementStyle = 'traditional' or contains($aCurrElementStyle, 'archaic')">
				<span class="lbexTitleLevelTradEx">
					<xsl:call-template name="actualDisplayDivisionBody"/>
				</span>
			</xsl:when>
			<xsl:when
				test="$aCurrElementStyle = 'traditional-inline' or $aCurrElementStyle = 'appropriations'">
				<span class="lbexTitleLevelTradIn">
					<xsl:call-template name="actualDisplayDivisionBody"/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexTitleLevelOLC">
					<xsl:call-template name="actualDisplayDivisionBody"/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="actualDisplayDivisionBody">
		<xsl:choose>
			<xsl:when
				test="ancestor::amendment-block and ../@level-type = 'undesignated' and not(following-sibling::enum or preceding-sibling::enum) and ../header">
				<span class="lbexAllcap">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span style="text-align:center">
					<xsl:text>—</xsl:text>
				</span>
				<span class="lbexAllcap">
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--*********** Subdivision ****************************-->
	<xsl:template name="displaySubdivisionBody">
		<xsl:param name="aCurrElementStyle"/>
		<xsl:choose>
			<xsl:when
				test="$aCurrElementStyle = 'OLC' or $aCurrElementStyle = 'USC' or $aCurrElementStyle = 'tax'">
				<span class="lbexTitleLevelOLC">
					<xsl:call-template name="actualDisplaySubdivisionBody">
						<xsl:with-param name="aCurrElementStyle" select="$aCurrElementStyle"/>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:when
				test="$aCurrElementStyle = 'traditional-inline' or $aCurrElementStyle = 'appropriations'">
				<span class="lbexSubChapterLevelOLC">
					<xsl:call-template name="actualDisplaySubdivisionBody">
						<xsl:with-param name="aCurrElementStyle" select="$aCurrElementStyle"/>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexInitialCapArchaic">
					<xsl:call-template name="actualDisplaySubdivisionBody">
						<xsl:with-param name="aCurrElementStyle" select="$aCurrElementStyle"/>
					</xsl:call-template>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="actualDisplaySubdivisionBody">
		<xsl:param name="aCurrElementStyle"/>

		<xsl:choose>
			<xsl:when
				test="ancestor::amendment-block and ../@level-type = 'undesignated' and not(following-sibling::enum or preceding-sibling::enum) and ../header"> </xsl:when>
			<xsl:otherwise>
				<span style="text-align:center">
					<xsl:text>—</xsl:text>
				</span>
			</xsl:otherwise>
		</xsl:choose>

		<!-- <xsl:value-of select="translate(.,$lower,$upper)"/> -->
		<!-- Replaced above line with following  line to fix bug #766. nvargish 2007-11-02 -->
		<xsl:choose>
			<xsl:when
				test="$aCurrElementStyle = 'OLC' or $aCurrElementStyle = 'USC' or $aCurrElementStyle = 'tax'">
				<span class="lbexAllcap">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if
			test="not(following-sibling::*) and name(ancestor::quoted-block/child::*[2]) = 'after-quoted-block'">
			<xsl:text>”</xsl:text>
			<xsl:value-of
				select="translate(ancestor::quoted-block/child::after-quoted-block, $lower, $upper)"
			/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="displaySection">
		<xsl:variable name="currentElementStyle">
			<xsl:call-template name="getCurrentElementStyle"/>
		</xsl:variable>

		<xsl:variable name="isIdReferenceExists">
			<xsl:call-template name="IdReferenceExists">
				<xsl:with-param name="currentID" select="./@id"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- end fix TB 28Apr2009 -->
		<xsl:choose>
			<xsl:when
				test="./@section-type = 'undesignated-section' and not($billType = 'appropriations')">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="./@section-type = 'resolved'">
				<p class="lbexIndent" style="text-align:left">
					<em>
						<xsl:value-of select="$HouseResolution"/>
					</em>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when test="./@section-type = 'ordered'">
				<p class="lbexIndent" style="text-align:left">
					<em>
						<xsl:value-of select="$OrderedSection"/>
					</em>
					<xsl:apply-templates/>
				</p>
			</xsl:when>

			<xsl:when
				test="contains($currentElementStyle, 'archaic') and ancestor::quoted-block and $isIdReferenceExists = 'yes'">
				<div style="text-align:center">
					<a>
						<xsl:attribute name="href">
							<xsl:text>#</xsl:text>
							<xsl:value-of select="@id"/>
						</xsl:attribute>
						<!-- TB Jan-2014  billres clean up obsolete attributes -->
						<!--xsl:attribute name="NAME"-->
						<xsl:attribute name="id">
							<xsl:text>toc-</xsl:text>
							<xsl:value-of select="@id"/>
						</xsl:attribute>
						<p/>
						<xsl:if test="header">
							<xsl:call-template name="openQuotes"/>
							<!--xsl:value-of select="translate(header,$lower,$upper)"/-->
							<xsl:apply-templates select="header">
								<xsl:with-param name="isSpecialPrinting">
									<xsl:text>yes</xsl:text>
								</xsl:with-param>
							</xsl:apply-templates>
						</xsl:if>
						<p/>
						<xsl:if test="subsection/header">
							<!--span class="initialcapArchaic" span commented by tB 28Aug2009-->
							<xsl:call-template name="openQuotes"/>
							<!--xsl:value-of select="subsection/header"/-->
							<xsl:apply-templates select="subsection/header">
								<xsl:with-param name="isSpecialPrinting">
									<xsl:text>yes</xsl:text>
								</xsl:with-param>
							</xsl:apply-templates>
							<!--/span-->
						</xsl:if>

						<p/>
					</a>
				</div>
				<p class="lbexIndent">
					<xsl:if test="@section-type = 'subsequent-section'">
						<!--xsl:text disable-output-escaping="yes">&lt;/center&gt;</xsl:text-->
						<!-- TB Aug 2016 - fixing double Sec for archaic -->
						<!--xsl:call-template name="openQuotes"/-->
						<!--span class="initialcap"-->
						<span class="lbexSectionLevelOLCnuclear">
							<!--xsl:text>Sec. </xsl:text-->
							<!-- TB 28Dec2007 Bug #767 -->
							<xsl:apply-templates select="enum"/>


						</span>
					</xsl:if>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="text"/>
					<!-- TB May-7-2015 bug fixing #1384 -->
					<xsl:for-each select="node()">
						<xsl:choose>
							<xsl:when test="local-name() = 'header' and parent::section">
								<!-- nothing -->
							</xsl:when>
							<xsl:when test="local-name() = 'enum' and parent::section">
								<!-- nothing -->
							</xsl:when>
							<xsl:when test="local-name() = 'header' and parent::subsection">
								<!-- nothing -->
							</xsl:when>
							<xsl:when test="local-name() = 'enum' and parent::subsection">
								<!-- nothing -->
							</xsl:when>
							<xsl:when test="local-name() = 'text' and parent::section">
								<!-- nothing -->
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="self::*"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					<!--xsl:apply-templates select="subsection"/-->
					<!--
						<xsl:text>“</xsl:text>
						<span class="initialcap">
						<xsl:text>Sec. </xsl:text>
						<xsl:value-of select="enum"/>
						</span>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:apply-templates select="subsection"/>
					-->
				</p>
			</xsl:when>
			<!--  archaic style not linked -->
			<xsl:when
				test="$currentElementStyle = 'archaic' or $currentElementStyle = 'archaic-paragraph'">
				<div style="text-align:center">

					<xsl:if test="header">
						<p/>

						<xsl:call-template name="openQuotes"/>
						<xsl:apply-templates select="header"/>
						<!--xsl:value-of select="translate(header,$lower,$upper)"/-->

					</xsl:if>
					<p/>
					<!--span class="initialcapArchaic" commented by TB 28Aug2009-->
					<!-- TB 5Sep2007 #691 print quotes only if it is following header. inserted second condition the header element existance is evaluating -->
					<xsl:if test="child::subsection and child::subsection/header">
						<xsl:call-template name="openQuotes"/>
						<!--xsl:value-of select="subsection/header"/-->
						<xsl:apply-templates select="child::subsection[1]/header">
							<xsl:with-param name="isSpecialPrinting">
								<xsl:text>yes</xsl:text>
							</xsl:with-param>
						</xsl:apply-templates>
					</xsl:if>
					<!--/span-->
					<xsl:if
						test="child::subsection/paragraph and child::subsection/paragraph/header and $currentElementStyle = 'archaic-paragraph' and child::subsection/paragraph/@display-inline = 'yes-display-inline'">
						<p/>
						<span class="lbexInitialCapArchaic">
							<!-- TB 5Sep2007 #691 print quotes only if it is following header. inserted second condition the header element existance is evaluating -->

							<xsl:call-template name="openQuotes"/>
							<xsl:value-of
								select="translate(subsection/paragraph/header, $lower, $upper)"/>
						</span>
					</xsl:if>
				</div>
				<p class="lbexIndent">
					<xsl:if test="@section-type = 'subsequent-section'">
						<!--xsl:call-template name="openQuotes"/-->
						<!-- TB 2Jan2008 Bug #767 -->
						<!--span class="initialcap"-->
						<span class="lbexSectionLevelOLCnuclear">
							<!-- commented by TB Aug-2016 double Sec. in Archaic -->
							<!--xsl:text>Sec. </xsl:text-->
							<!-- TB 2Jan2008 Bug #767 -->
							<!--xsl:value-of select="enum"/-->
							<xsl:apply-templates select="enum"/>
						</span>
					</xsl:if>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="text"/>
					<xsl:text> </xsl:text>
					<!-- TB May-7-2015 bug fixing #1384 -->
					<xsl:for-each select="node()">
						<xsl:choose>
							<xsl:when test="local-name() = 'header' and parent::section">
								<!-- nothing -->
							</xsl:when>
							<xsl:when test="local-name() = 'enum' and parent::section">
								<!-- nothing -->
							</xsl:when>
							<xsl:when test="local-name() = 'header' and parent::subsection">
								<!-- nothing -->
							</xsl:when>
							<xsl:when test="local-name() = 'enum' and parent::subsection">
								<!-- nothing -->
							</xsl:when>
							<xsl:when test="local-name() = 'text' and parent::section">
								<!-- nothing -->
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="self::*"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					<!--xsl:apply-templates select="subsection"/-->
				</p>
			</xsl:when>
			<!-- UCS style not linked -->
			<xsl:when test="$currentElementStyle = 'USC' and $isIdReferenceExists = 'no'">

				<p style="text-align:left;clear:both" class="lbexHangWithMargin">
					<b>
						<xsl:apply-templates select="enum"/>
						<xsl:text> </xsl:text>
						<xsl:apply-templates select="header"/>
						<xsl:choose>
							<xsl:when
								test="child::header and header/following-sibling::text/@display-inline = 'yes-display-inline'">
								<xsl:apply-templates select="header/following-sibling::text"/>
							</xsl:when>
							<xsl:when
								test="child::enum and enum/following-sibling::text/@display-inline = 'yes-display-inline'">
								<xsl:apply-templates select="enum/following-sibling::text"/>
							</xsl:when>
						</xsl:choose>
					</b>
				</p>


				<xsl:choose>
					<xsl:when
						test="child::header and not(header/following-sibling::text/@display-inline = 'yes-display-inline')">
						<xsl:apply-templates select="child::header/following-sibling::*"/>
					</xsl:when>
					<xsl:when
						test="child::enum and not(enum/following-sibling::text/@display-inline = 'yes-display-inline')">
						<xsl:apply-templates select="child::enum/following-sibling::*"/>
					</xsl:when>
					<xsl:when
						test="child::header and header/following-sibling::text/@display-inline = 'yes-display-inline'">
						<xsl:apply-templates
							select="header/following-sibling::text[@display-inline = 'yes-display-inline']/following-sibling::*"
						/>
					</xsl:when>
					<xsl:when
						test="child::enum and enum/following-sibling::text/@display-inline = 'yes-display-inline'">
						<xsl:apply-templates
							select="enum/following-sibling::text[@display-inline = 'yes-display-inline']/following-sibling::*"
						/>
					</xsl:when>
					<xsl:when test="child::header">
						<xsl:apply-templates select="child::header/following-sibling::*"/>
					</xsl:when>
					<xsl:when test="child::enum">
						<xsl:apply-templates select="child::enum/following-sibling::*"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates/>
					</xsl:otherwise>
				</xsl:choose>


			</xsl:when>
			<!--  traditional style linked -->
			<xsl:when
				test="(//bill or //resolution) and ($currentElementStyle = 'traditional' or $currentElementStyle = 'appropriations') and $isIdReferenceExists = 'yes'">
				<a>
					<xsl:attribute name="href">
						<xsl:text>#</xsl:text>
						<xsl:value-of select="@id"/>
					</xsl:attribute>
					<!-- TB Jan-2014  billres clean up obsolete attributes -->
					<!--xsl:attribute name="NAME"-->
					<xsl:attribute name="id">
						<xsl:text>toc-</xsl:text>
						<xsl:value-of select="@id"/>
					</xsl:attribute>
					<p/>
					<div style="text-align:center">
						<!-- TB 22-Dec-2008 Bug #887  to print quotes in this case-->
						<xsl:if
							test="ancestor::quoted-block and not(header/enum-in-header or parent::section and ancestor::quoted-block[1]/@style = 'traditional')">
							<xsl:call-template name="openQuotes"/>
						</xsl:if>
						<xsl:apply-templates select="header"/>
					</div>
					<p/>
				</a>
				<p style="text-align:left" class="lbexIndent"/>
				<xsl:apply-templates select="enum"/>
				<xsl:text> </xsl:text>
				<xsl:if test="child::text[@display-inline = 'yes-display-inline']">
					<xsl:apply-templates select="text"/>
				</xsl:if>
				<!--/p-->
				<xsl:if test="child::text[@display-inline = 'no-display-inline']">
					<xsl:apply-templates select="text"/>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="child::text">
						<xsl:apply-templates select="child::text/following-sibling::*"/>
					</xsl:when>
					<xsl:when test="child::header">
						<xsl:apply-templates select="child::header/following-sibling::*"/>
					</xsl:when>
					<xsl:when test="child::enum">
						<xsl:apply-templates select="child::enum/following-sibling::*"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<!--  traditional style not linked -->
			<!-- TB 5Sep2007 #689 exclude the OLC nested quoted block from this case -->
			<xsl:when
				test="
					((ancestor::resolution-body/@style = 'traditional' and not(ancestor::quoted-block[1]/@style != 'traditional')) or $currentElementStyle = 'traditional'
					or ($currentElementStyle = 'appropriations' and not(@section-type = 'undesignated-section')
					and not(contains(local-name(child::*), 'appropriations')))
					and not(/resolution/descendant::*/@idref = ./@id))">
				<xsl:variable name="appropReportedStyle">
					<xsl:call-template name="getAppropriationReportingStyle"/>
				</xsl:variable>

				<xsl:if test="header">
					<ul>
						<p style="text-align:center">
							<!-- TB 8Jun2010 -->
							<xsl:choose>
								<xsl:when test="contains($appropReportedStyle, 'brackets')">
									<span class="lbexBrakets">
										<xsl:text>[</xsl:text>
									</span>
								</xsl:when>
							</xsl:choose>
							<!-- TB 4Jan2008 bug#767 -->
							<xsl:if
								test="ancestor::quoted-block and not(header/enum-in-header or parent::section and ancestor::quoted-block[1]/@style = 'traditional')">
								<xsl:call-template name="openQuotes"/>
							</xsl:if>
							<xsl:apply-templates select="header"/>
						</p>
					</ul>
				</xsl:if>
				<p style="text-align:left" class="lbexIndent">
					<!-- NB 2/27/2007 - Added for when the quoted block does not include a header -->
					<!--<xsl:choose>
						<xsl:when
							test="contains($appropReportedStyle, 'brackets') or @commented = 'yes'">
							<span class="lbexBrakets">
								<xsl:text>[</xsl:text>
							</span>
						</xsl:when>
					</xsl:choose>-->
					<xsl:if test="ancestor::quoted-block and not(header) and not(enum)">
						<xsl:call-template name="openQuotes"/>
					</xsl:if>
					<xsl:apply-templates select="enum"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="text"/>
					<!-- NB 2/7/2007 - Added for the unnested quoted-block -->
					<xsl:if test="./quoted-block">
						<xsl:apply-templates select="quoted-block"/>
					</xsl:if>

					<xsl:apply-templates select="paragraph"/>
					<xsl:apply-templates select="subsection"/>
					<xsl:apply-templates select="toc"/>
					<xsl:apply-templates select="table"/>

					<!-- TB 11Jun2010 -->
					<!-- TB 4May2015 bug fixing 1383-->
					<xsl:for-each select="node()">
						<xsl:choose>
							<xsl:when test="contains(local-name(), 'appropriations')">
								<xsl:apply-templates/>
							</xsl:when>
							<xsl:when test="contains(local-name(), 'continuation-text')">
								<xsl:apply-templates select="self::*"/>
							</xsl:when>
							<xsl:when test="local-name() = 'list'">
								<xsl:apply-templates select="self::*"/>
							</xsl:when>
							<!--xsl:when test="local-name() != 'paragraph' and local-name() != 'subsection' and local-name() != 'toc' ">
								<xsl:apply-templates/>
							</xsl:when-->
						</xsl:choose>

					</xsl:for-each>


					<!-- TB 8Jun2010 -->
					<!--<xsl:variable name="isToCloseTheBrackets">
						<xsl:call-template name="toCloseTheBrakets"/>
					</xsl:variable>
					<xsl:choose>
						<!-\- Check in aditional that this is the last element in deleted block -\->
						<xsl:when
							test="contains($appropReportedStyle, 'brackets') and $isToCloseTheBrackets = 'yes'">
							<span class="lbexBrakets">
								<xsl:text>]</xsl:text>
							</span>
						</xsl:when>
						<xsl:when test="@commented = 'yes'">
							<span class="lbexBrakets">
								<xsl:text>]</xsl:text>
							</span>
						</xsl:when>

					</xsl:choose>-->
					</p>
			</xsl:when>
			<!--  olc style linked -->
			<!--xsl:when test="$billType='olc' and /bill/descendant::*/@idref=./@id"-->
			<xsl:when
				test="($billType = 'olc' or $currentElementStyle = 'OLC') and $isIdReferenceExists = 'yes'">
				<p style="text-align:left" class="lbexHang">
					<a>
						<xsl:attribute name="href">
							<xsl:text>#</xsl:text>
							<xsl:value-of select="@id"/>
						</xsl:attribute>
						<!-- TB Jan-2014  billres clean up obsolete attributes -->
						<!--xsl:attribute name="NAME"-->
						<xsl:attribute name="id">
							<xsl:text>toc-</xsl:text>
							<xsl:value-of select="@id"/>
						</xsl:attribute>
						<div class="lbexHangWithMargin" style="clear:both;">
							<xsl:apply-templates select="enum"/>
							<xsl:apply-templates select="header"/>
						</div>
						<xsl:if
							test="count(child::*) = 2 and child::enum and child::header and ancestor::quoted-block">
							<!--xsl:text>”.</xsl:text-->
							<xsl:call-template name="closeQuotesByCondition"/>
						</xsl:if>
					</a>
					<xsl:if
						test="text[@display-inline = 'yes-display-inline'] or (text and not(text/@display-inline))">
						<xsl:text> </xsl:text>
						<xsl:apply-templates select="text"/>
						<xsl:if test="quoted-block[@display-inline = 'yes-display-inline']">
							<xsl:apply-templates select="quoted-block"/>
						</xsl:if>
					</xsl:if>
				</p>

				<xsl:if test="text[@display-inline = 'no-display-inline']">
					<p style="text-align:left" class="lbexIndent">
						<xsl:apply-templates select="text"/>
						<xsl:if test="quoted-block[@display-inline = 'yes-display-inline']">
							<xsl:apply-templates select="quoted-block"/>
						</xsl:if>
					</p>
				</xsl:if>

				<xsl:if
					test="quoted-block[@display-inline = 'no-display-inline'] or (quoted-block and not(quoted-block/@display-inline))">
					<xsl:apply-templates select="quoted-block"/>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="child::quoted-block">
						<xsl:apply-templates select="child::quoted-block/following-sibling::*"/>
					</xsl:when>
					<xsl:when test="child::text">
						<xsl:apply-templates select="child::text/following-sibling::*"/>
					</xsl:when>
					<xsl:when test="child::header">
						<xsl:apply-templates select="child::header/following-sibling::*"/>
					</xsl:when>
					<xsl:when test="child::enum">
						<xsl:apply-templates select="child::enum/following-sibling::*"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<!--  olc style linked -->
			<!-- TB 5Sep2007 bug #689  add nested quoted block with OLC style to this case-->

			<xsl:when
				test="($billType = 'appropriations') or $currentElementStyle = 'appropriations'">
				<xsl:choose>
					<xsl:when test="./@section-type = 'undesignated-section'">
						<span style="text-align:left" class="lbexIndent">
							<xsl:call-template name="ActualPrintAppropriationElement"/>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<p style="text-align:left" class="lbexIndent">
							<xsl:call-template name="ActualPrintAppropriationElement"/>
						</p>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when
				test="$currentElementStyle = 'tax' or $currentElementStyle = 'defense' or $currentElementStyle = 'USC' and $isIdReferenceExists = 'yes'">
				<!--xsl:apply-templates/-->
				<a>
					<xsl:attribute name="href">
						<xsl:text>#</xsl:text>
						<xsl:value-of select="@id"/>
					</xsl:attribute>
					<!-- TB Jan-2014  billres clean up obsolete attributes -->
					<!--xsl:attribute name="NAME"-->
					<xsl:attribute name="id">
						<xsl:text>toc-</xsl:text>
						<xsl:value-of select="@id"/>
					</xsl:attribute>

					<p style="text-align:left" class="lbexHangWithMargin">
						<b>
							<xsl:apply-templates select="enum"/>
							<xsl:text> </xsl:text>
							<xsl:apply-templates select="header"/>
						</b>
					</p>
				</a>
				<xsl:choose>
					<xsl:when test="child::header">
						<xsl:apply-templates select="child::header/following-sibling::*"/>
					</xsl:when>
					<xsl:when test="child::enum">
						<xsl:apply-templates select="child::enum/following-sibling::*"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when
				test="$currentElementStyle = 'tax' or $currentElementStyle = 'defense' and $isIdReferenceExists = 'no'">
				<!--xsl:apply-templates/-->
				<p style="text-align:left" class="lbexHangWithMargin">
					<b>
						<xsl:apply-templates select="enum"/>
						<xsl:text> </xsl:text>
						<xsl:apply-templates select="header"/>
					</b>
				</p>
				<xsl:choose>
					<xsl:when test="child::header">
						<xsl:apply-templates select="child::header/following-sibling::*"/>
					</xsl:when>
					<xsl:when test="child::enum">
						<xsl:apply-templates select="child::enum/following-sibling::*"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$currentElementStyle = 'OLC' and $isIdReferenceExists = 'no'">
				<!--ul-->
				<!-- TB January 2014 cleanup for the result html validation -->
				<!--p style="text-align:left" class="lbexHang"-->
				<p style="text-align:left" class="lbexHangWithMargin">
					<xsl:if test="ancestor::quoted-block and not(enum) and not(header)">
						<xsl:call-template name="openQuotes"/>
					</xsl:if>
					<!-- TB January 2014 cleanup for the result html validation -->
					<!--div class="lbexHangWithMargin"-->
					<xsl:apply-templates select="enum"/>
					<xsl:apply-templates select="header"/>
					<!--/div-->
					<xsl:if
						test="count(child::*) = 2 and child::enum and child::header and ancestor::quoted-block">
						<!--xsl:text>”.</xsl:text-->
						<xsl:call-template name="closeQuotesByCondition"/>
					</xsl:if>
					<!--TB 28Dec2007 Bug #767 -->
					<xsl:if
						test="$currentElementStyle = 'traditional-inline' and text/@display-inline = 'yes-display-inline'">
						<span class="lbexSectionLevelOLCnuclear">
							<xsl:text>—</xsl:text>
							<xsl:apply-templates select="text"/>
							<xsl:if test="quoted-block[@display-inline = 'yes-display-inline']">
								<xsl:apply-templates select="quoted-block"/>
							</xsl:if>
						</span>
					</xsl:if>
				</p>
				<!--/ul-->
				<xsl:if
					test="not($currentElementStyle = 'traditional-inline' and text/@display-inline = 'yes-display-inline')">
					<div style="text-align:left" class="lbexIndent">
						<xsl:apply-templates select="text"/>
						<xsl:if test="quoted-block[@display-inline = 'yes-display-inline']">
							<xsl:apply-templates select="quoted-block"/>
						</xsl:if>
					</div>
				</xsl:if>
				<xsl:if
					test="quoted-block[@display-inline = 'no-display-inline'] or (quoted-block and not(quoted-block/@display-inline))">
					<xsl:apply-templates select="quoted-block"/>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="child::quoted-block">
						<xsl:apply-templates select="child::quoted-block/following-sibling::*"/>
					</xsl:when>
					<xsl:when test="child::text">
						<xsl:apply-templates select="child::text/following-sibling::*"/>
					</xsl:when>
					<xsl:when test="child::header">
						<xsl:apply-templates select="child::header/following-sibling::*"/>
					</xsl:when>
					<xsl:when test="child::enum">
						<xsl:apply-templates select="child::enum/following-sibling::*"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="ApplyTemplWithSimpleIndentP"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="openBracketStyles">
		<xsl:choose>
			<xsl:when
				test="(@reported-display-style = 'brackets-boldface-roman' and not(ancestor::*[@reported-display-style = 'brackets-boldface-roman'])) or (not(@reported-display-style) and ancestor::legis-body/@reported-display-style = 'brackets-boldface-roman')">
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
			</xsl:when>
			<xsl:when
				test="(@reported-display-style = 'brackets-boldface-italic' and not(ancestor::*[@reported-display-style = 'brackets-boldface-italic'])) or (not(@reported-display-style) and ancestor::legis-body/@reported-display-style = 'brackets-boldface-italic') or (not(@reported-display-style) and ancestor::*/@reported-display-style = 'brackets-boldface-italic') ">
				<i class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</i>
			</xsl:when>
			<xsl:when
				test="(@reported-display-style = 'bold-brackets' and not(ancestor::*[@reported-display-style = 'bold-brackets'])) or (not(@reported-display-style) and ancestor::legis-body/@reported-display-style = 'bold-brackets') or (not(@reported-display-style) and ancestor::*/@reported-display-style = 'bold-brackets')">
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="openParenStyles">
		<span class="lbexBrakets">
			<xsl:text>(</xsl:text>
		</span>
	</xsl:template>
	<xsl:template name="closedParentheseStyles">
		<span class="lbexBrakets">
			<xsl:text>)</xsl:text>
		</span>
	</xsl:template>
	<xsl:template name="closedBracketStyles">
		<xsl:choose>
			<xsl:when
				test="(@reported-display-style = 'brackets-boldface-roman' and not(ancestor::*[@reported-display-style = 'brackets-boldface-roman'])) or (not(@reported-display-style) and ancestor::legis-body/@reported-display-style = 'brackets-boldface-roman')">
				<span class="lbexBrakets">
					<xsl:text>]</xsl:text>
				</span>
			</xsl:when>
			<xsl:when
				test="(@reported-display-style = 'brackets-boldface-italic' and not(ancestor::*[@reported-display-style = 'brackets-boldface-italic'])) or (not(@reported-display-style) and ancestor::legis-body/@reported-display-style = 'brackets-boldface-italic') or (not(@reported-display-style) and ancestor::*/@reported-display-style = 'brackets-boldface-italic')">
				<i class="lbexBrakets">
					<xsl:text>]</xsl:text>
				</i>
			</xsl:when>
			<xsl:when
				test="(@reported-display-style = 'bold-brackets' and not(ancestor::*[@reported-display-style = 'bold-brackets'])) or (not(@reported-display-style) and ancestor::legis-body/@reported-display-style = 'bold-brackets')">
				<span class="lbexBrakets">
					<xsl:text>]</xsl:text>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexBrakets">
					<xsl:text>]</xsl:text>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="openQuotes">
		<xsl:choose>
			<xsl:when
				test="ancestor::quoted-block and contains(@display-inline, 'yes-display-inline')">
				<xsl:text/>
			</xsl:when>
		<xsl:when
			test="ancestor::quoted-block and ancestor::quoted-block/descendant::quoted-block = ancestor::quoted-block">
			
			<span class="lbexThinSpace">
				<xsl:text> </xsl:text>
			</span>
			<xsl:text>&#8216;</xsl:text>
		</xsl:when>
			<xsl:otherwise>
				<xsl:text>“</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="closeQuotes">
		<xsl:param name="currNode"/>
		<!--xsl:variable name="isPrevNonEmptyAfterQuotedBlock">
			<xsl:call-template name="PrevNonEmptyAfterQuotedBlock">
				<xsl:with-param name="currentNode" select="$currNode"/>
			</xsl:call-template>
		</xsl:variable-->
		<xsl:choose>
			<!--xsl:when test="$isPrevNonEmptyAfterQuotedBlock='true' and not ($currNode)">
				<nothing - exit TB May2011 bug # 1208 >
			</xsl:when-->
			<xsl:when test="$currNode">
				<!-- TB  bug fixing #1208-->
				<xsl:if
					test="$currNode/ancestor::quoted-block[1] and $currNode/ancestor::quoted-block[2]">
					<xsl:text>&#8217;</xsl:text>
					<span class="lbexThinSpace">
						<xsl:text> </xsl:text>
					</span>
				</xsl:if>
				<!-- TB 4Oct2011 Bug fixing -->
				<!--xsl:if test="$currNode/ancestor::quoted-block[1] and not($currNode/ancestor::quoted-block[2])"-->
				<xsl:if test="ancestor::quoted-block[1] and not(ancestor::quoted-block[2])">
					<xsl:text>&#8221;</xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="ancestor::quoted-block[1] and ancestor::quoted-block[2]">
					<xsl:text>&#8217;</xsl:text>
					<span class="lbexThinSpace">
						<xsl:text> </xsl:text>
					</span>
				</xsl:if>
				<xsl:if test="ancestor::quoted-block[1] and not(ancestor::quoted-block[2])">
					<xsl:text>&#8221;</xsl:text>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!-- TB May 2011 option for solution of 1208 - partially -->
	<xsl:template name="NextNonEmptyAfterQuotedBlock">
		<xsl:param name="currentNode"/>
		<xsl:choose>
			<xsl:when test="local-name($currentNode/following-sibling::*[1]) = 'after-quoted-block'">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when
				test="$currentNode/following-sibling::*[1]/child::*/text() != '' or $currentNode/following-sibling::*[1]/text() != ''">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when test="not($currentNode/following-sibling) and $currentNode/parent::*">
				<xsl:call-template name="NextNonEmptyAfterQuotedBlock">
					<xsl:with-param name="currentNode" select="$currentNode/parent::*"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>false</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--xsl:template name="PrevNonEmptyAfterQuotedBlock">		
		<xsl:param name="currentNode"/>
		
		<xsl:choose>
			<xsl:when test="not($currentNode)">
				<xsl:choose>
					<xsl:when test="local-name(preceding-sibling::*[1]) = 'after-quoted-block'">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:when test="preceding-sibling::*[1]/text != ''">
						<xsl:text>false</xsl:text>
					</xsl:when>
					<xsl:when test="not(preceding-sibling) and child::*[position()=last()]">				
						<xsl:call-template name="NextNonEmptyAfterQuotedBlock">
							<xsl:with-param name="currentNode" select="child::*[position()=last()]"/>						
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>false</xsl:text>				
					</xsl:otherwise>				
				</xsl:choose>		
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="local-name($currentNode/preceding-sibling::*[1]) = 'after-quoted-block'">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:when test="$currentNode/preceding-sibling::*[1]/text != ''">
						<xsl:text>false</xsl:text>
					</xsl:when>
					<xsl:when test="not($currentNode/preceding-sibling) and $currentNode/child::*">				
						<xsl:call-template name="NextNonEmptyAfterQuotedBlock">
							<xsl:with-param name="currentNode" select="$currentNode/child::*"/>						
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>false</xsl:text>				
					</xsl:otherwise>				
				</xsl:choose>		
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template-->




	<xsl:template name="closeQuotesByCondition">
		<!-- TB 25Sep2007 checking several levels of parent following siblings. -->
		<!-- actually trying to check that I am a last entry in the quoted block -->
		<xsl:if
			test="(ancestor::quoted-block[1]/child::*[last()]/preceding-sibling::*[1] = ancestor-or-self::* and name(ancestor::quoted-block/child::*[last()]) = 'after-quoted-block')">
			<xsl:variable name="toCloseQuotes">
				<xsl:call-template name="isQuoteMustClose"/>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="$toCloseQuotes = 'false'">
					<!-- nothing -->
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="closeQuotes"/>
					<xsl:value-of select="ancestor::quoted-block/child::after-quoted-block"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<!-- Template that determines if the quotes must be closed -->
	<xsl:template name="isQuoteMustClose">
		<xsl:choose>
			<xsl:when
				test="
					following-sibling::* and (name(self::*) = name(following-sibling::*)
					or (name(following-sibling::*[last()]) != 'header' and name(following-sibling::*[last()]) != 'text'))">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="parent::*/following-sibling::* and local-name(parent::*/following-sibling::*) != 'after-quoted-block'">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="ancestor::*[2]/following-sibling::* and ancestor::quoted-block[1]/descendant::* = ancestor::*[2] and name(ancestor::*[2]/following-sibling::*[1]) != 'after-quoted-block'">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="ancestor::*[3]/following-sibling::* and ancestor::quoted-block[1]/descendant::* = ancestor::*[3] and name(ancestor::*[3]/following-sibling::*[1]) != 'after-quoted-block'">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="ancestor::*[4]/following-sibling::* and ancestor::quoted-block[1]/descendant::* = ancestor::*[4] and name(ancestor::*[4]/following-sibling::*[1]) != 'after-quoted-block'">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="ancestor::*[5]/following-sibling::* and ancestor::quoted-block[1]/descendant::* = ancestor::*[5] and name(ancestor::*[5]/following-sibling::*[1]) != 'after-quoted-block'">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="ancestor::*[6]/following-sibling::* and ancestor::quoted-block[1]/descendant::* = ancestor::*[6] and name(ancestor::*[6]/following-sibling::*[1]) != 'after-quoted-block'">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="ancestor::*[7]/following-sibling::* and ancestor::quoted-block[1]/descendant::* = ancestor::*[7] and name(ancestor::*[7]/following-sibling::*[1]) != 'after-quoted-block'">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="ancestor::*[8]/following-sibling::* and ancestor::quoted-block[1]/descendant::* = ancestor::*[8] and name(ancestor::*[8]/following-sibling::*[1]) != 'after-quoted-block'">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="ancestor::*[9]/following-sibling::* and ancestor::quoted-block[1]/descendant::* = ancestor::*[9] and name(ancestor::*[9]/following-sibling::*[1]) != 'after-quoted-block'">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when
				test="ancestor::*[10]/following-sibling::* and ancestor::quoted-block[1]/descendant::* = ancestor::*[10] and name(ancestor::*[10]/following-sibling::*[1]) != 'after-quoted-block'">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>true</xsl:text>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!-- TB 6Sep2007 #689 extracted from displayHeader otherwise case Only first case was exists without the second conditioon -->
	<xsl:template name="displayTitleByStyle">
		<!--xsl:variable name="currElementStyle">
			<xsl:call-template name="getCurrentElementStyle"/>
			</xsl:variable-->
		<xsl:param name="currElementStyle"/>
		<xsl:choose>
			<!--xsl:when
				test="(ancestor::quoted-block/@style='traditional' and not (ancestor::quoted-block/descendant::quoted-block = ancestor::quoted-block and ancestor::quoted-block/descendant::quoted-block/@style !='traditional'  )) and parent::subsection"-->
			<!--xsl:when test="$currElementStyle='traditional' and parent::subsection"-->
			<xsl:when
				test="parent::paragraph or parent::subparagraph or parent::clause or parent::subclause or parent::item or parent::subitem">
				<xsl:call-template name="printHeaderParagraphAndLower"/>
			</xsl:when>
			<xsl:when test="parent::header">
				<xsl:call-template name="actualDisplayTitle"/>
			</xsl:when>
			<xsl:when test="$currElementStyle = 'traditional'">
				<span class="lbexSectionTitleTrad">
					<xsl:call-template name="actualDisplayTitle"/>
				</span>
			</xsl:when>
			<!--xsl:when
				test="ancestor::quoted-block/@style='traditional' and not (ancestor::quoted-block/descendant::quoted-block = ancestor::quoted-block and ancestor::quoted-block/descendant::quoted-block/@style !='traditional'  ) and not (parent::subsection) "-->
			<!--xsl:when test="$currElementStyle='traditional' and not(parent::subsection)">				
				<span class="smallcap">
					<xsl:call-template name="actualDisplayTitle"/>
				</span>
			</xsl:when-->
			<xsl:otherwise>
				<span class="lbexSectionLevelOLCnuclear">
					<xsl:call-template name="actualDisplayTitle"/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="actualDisplayTitle">
		<!--xsl:if test="following-sibling::*">
			<xsl:apply-templates/>
		</xsl:if>		
		<xsl:if test="not(following-sibling::*)">
			<xsl:value-of select="."/>
			</xsl:if-->
		<xsl:variable name="myAncestor2" select="local-name(ancestor::*[2])"/>
		<xsl:choose>
			<!--xsl:when test="$myAncestor2='paragraph' or $myAncestor2='subparagraph' or $myAncestor2='clause' or  $myAncestor2='subclause' or $myAncestor2='item' or $myAncestor2='subitem'">
				<xsl:value-of select="substring(.,2)"/>
				</xsl:when-->
			<!--xsl:when
				test="parent::header and not (child::*) and (following-sibling::deleted-phrase or preceding-sibling::deleted-phrase) "-->
			<!-- TB  -->
			<xsl:when
				test="parent::header and not(child::*) and ((following-sibling::deleted-phrase or preceding-sibling::deleted-phrase) or (following-sibling::added-phrase or preceding-sibling::added-phrase))">
				<xsl:value-of select="."/>
			</xsl:when>
			<xsl:when test="following-sibling::*">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="not(following-sibling::*)">
				<xsl:value-of select="."/>
			</xsl:when>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="displayTocVerticalSpace">
		<xsl:if
			test="not(@level = 'section' or @level = 'subsection' or @level = 'paragraph' or @level = 'subparagraph' or @level = 'clause' or @level = 'subclause' or @level = 'item' or @level = 'subitem')">
			<p/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="headerInTextLowerlevels">
		<xsl:param name="printReportItalic"/>
		<!-- this template will be called only in case of paragraph and lower leves - till subitem-->
		<xsl:variable name="toBeNeutralized">
			<xsl:call-template name="isNeutralizeSegment"/>
		</xsl:variable>
		<xsl:variable name="neutralBlockClassName">
			<xsl:call-template name="getNeutralBlockClassName"/>
		</xsl:variable>
		<xsl:variable name="neutralInlineClassName">
			<xsl:call-template name="getNeutralInlineClassName"/>
		</xsl:variable>
		<xsl:for-each select="node()">
			<xsl:variable name="firstLetter" select="substring(normalize-space(.), 1, 1)"/>
			<xsl:variable name="isFirstSpace">
				<xsl:if test="substring(., 1, 1) = ' '">
					<xsl:text>true</xsl:text>
				</xsl:if>
			</xsl:variable>

			<xsl:choose>
				<xsl:when test="position() = 1 and contains($upper, $firstLetter)">
					<xsl:choose>
						<xsl:when test="$printReportItalic = 'yes' or local-name() = 'added-phrase'">
							<i>
								<xsl:if test="$toBeNeutralized = 'yes'">
									<xsl:attribute name="class">
										<xsl:value-of select="$neutralInlineClassName"/>
									</xsl:attribute>
								</xsl:if>
								<xsl:if test="$isFirstSpace = 'true'">
									<!-- insert space -->
									<xsl:text> </xsl:text>
								</xsl:if>
								<span style="font-size:110%">
									<xsl:value-of select="$firstLetter"/>
								</span>
								<span class="lbexAllcapnormal">
									<xsl:value-of select="substring(normalize-space(.), 2)"/>
								</span>
							</i>
						</xsl:when>
						<xsl:when test="local-name() = 'deleted-phrase'">
							<span class="lbexTextStrikethrough">
								<xsl:if test="$isFirstSpace = 'true'">
									<!-- insert space -->
									<xsl:text> </xsl:text>
								</xsl:if>
								<span style="font-size:110%">
									<xsl:value-of select="$firstLetter"/>
								</span>
								<span class="lbexAllcapnormal">
									<xsl:value-of select="substring(normalize-space(.), 2)"/>
								</span>
							</span>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="$isFirstSpace = 'true'">
								<!-- insert space -->
								<xsl:text> </xsl:text>
							</xsl:if>
							<span style="font-size:110%">
								<xsl:value-of select="$firstLetter"/>
							</span>
							<span class="lbexAllcapnormal">
								<xsl:value-of select="substring(normalize-space(.), 2)"/>
							</span>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<span class="lbexAllcapnormal">
						<xsl:choose>
							<xsl:when
								test="$printReportItalic = 'yes' or local-name() = 'added-phrase'">
								<i>
									<xsl:if test="$toBeNeutralized = 'yes'">
										<xsl:attribute name="class">
											<xsl:value-of select="$neutralInlineClassName"/>
										</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="."/>
								</i>
							</xsl:when>
							<xsl:when test="local-name() = 'deleted-phrase'">
								<span class="lbexTextStrikethrough">
									<xsl:value-of select="."/>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</span>

				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>


	<xsl:template name="getCurrentElementStyle">
		<xsl:choose>
			<!-- If nearest quated block has a subtitme with style defined ==> take style from subtitle -->
			<xsl:when test="ancestor::quoted-block[1]/descendant::subtitle/@style">
				<xsl:choose>
					<xsl:when
						test="ancestor-or-self::subtitle/text() = ancestor::quoted-block[1]/descendant::subtitle/text()">
						<xsl:choose>
							<xsl:when test="ancestor-or-self::subtitle/@style = 'other'">
								<xsl:value-of select="ancestor-or-self::subtitle/@other-style"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="ancestor-or-self::subtitle/@style"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="getStyleFromNearestQuotedBlock"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!--  If nearest quated block has a title with style defined ==> take style from title -->
			<xsl:when test="ancestor::quoted-block[1]/descendant::title/@style">
				<xsl:choose>
					<xsl:when
						test="ancestor-or-self::title/text() = ancestor::quoted-block[1]/descendant::title/text()">
						<xsl:choose>
							<xsl:when test="ancestor-or-self::title/@style = 'other'">
								<xsl:value-of select="ancestor-or-self::title/@other-style"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="ancestor-or-self::title/@style"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="getStyleFromNearestQuotedBlock"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>

			<!-- There is quoted block and not title or subtitle inside with style element -->
			<xsl:when test="ancestor::quoted-block[1]">
				<xsl:call-template name="getStyleFromNearestQuotedBlock"/>
			</xsl:when>
			<!-- If there is a nearest subtitle with style  -->
			<xsl:when test="ancestor-or-self::subtitle[1]/@style">
				<xsl:choose>
					<xsl:when test="ancestor-or-self::subtitle[1]/@style = 'other'">
						<xsl:value-of select="ancestor-or-self::subtitle[1]/@other-style"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="ancestor-or-self::subtitle[1]/@style"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- If there is a title with style -->
			<xsl:when test="ancestor-or-self::title[1]/@style">
				<xsl:choose>
					<xsl:when test="ancestor-or-self::title[1]/@style = 'other'">
						<xsl:value-of select="ancestor-or-self::title[1]/@other-style"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="ancestor-or-self::title[1]/@style"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="ancestor-or-self::amendment-block[1]/@style">
				<xsl:choose>
					<xsl:when test="ancestor-or-self::amendment-block[1]/@style = 'other'">
						<xsl:value-of select="ancestor-or-self::amendment-block[1]/@other-style"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="ancestor-or-self::amendment-block[1]/@style"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="ancestor-or-self::legis-body[1]/@style">
				<xsl:choose>
					<xsl:when test="ancestor-or-self::legis-body[1]/@style = 'other'">
						<xsl:value-of select="ancestor-or-self::legis-body[1]/@other-style"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="ancestor-or-self::legis-body[1]/@style"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="ancestor-or-self::resolution-body[1]/@style">
				<xsl:choose>
					<xsl:when test="ancestor-or-self::resolution-body[1]/@style = 'other'">
						<xsl:value-of select="ancestor-or-self::resolution-body[1]/@other-style"/>
					</xsl:when>
					<!-- TB 30Dec2008 -->
					<xsl:when
						test="ancestor-or-self::resolution-body[1]/@style = 'order-of-business'">
						<xsl:text>traditional</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="ancestor-or-self::resolution-body[1]/@style"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$documentType != ''">
				<xsl:choose>
					<xsl:when test="$documentType = 'olc'">
						<xsl:text>OLC</xsl:text>
					</xsl:when>
					<xsl:when test="$documentType = 'appropriations'">
						<xsl:choose>
							<xsl:when
								test="local-name() = 'section' or parent::section or local-name(../..) = 'section'">
								<xsl:text>traditional</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>traditional-inline</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$documentType"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>OLC</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="getStyleFromNearestQuotedBlock">
		<xsl:choose>
			<xsl:when test="ancestor-or-self::quoted-block[1]/@style = 'other'">
				<xsl:value-of select="ancestor-or-self::quoted-block[1]/@other-style"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="ancestor-or-self::quoted-block[1]/@style"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="displayHeaderInStyle">
		<xsl:variable name="currentElementStyle">
			<xsl:call-template name="getCurrentElementStyle"/>
		</xsl:variable>
		<xsl:choose>
			<!-- OLC Style -->
			<xsl:when
				test="(parent::division or parent::subdivision) and $currentElementStyle = 'OLC'">
				<span class="lbexTitleLevelIRCEx">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="parent::title and $currentElementStyle = 'OLC'">
				<span class="lbexTitleLevelIRCEx">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="parent::subtitle and $currentElementStyle = 'OLC'">
				<span class="lbexSubTitleLevelOLC">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="parent::part and $currentElementStyle = 'OLC'">
				<span class="lbexPartLevelIRCEx">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="parent::subpart and $currentElementStyle = 'OLC'">
				<span class="lbexSectionlevelOLCBold">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="parent::chapter and $currentElementStyle = 'OLC'">
				<span class="lbexTitleLevelTradIn">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="parent::subchapter and $currentElementStyle = 'OLC'">
				<span class="lbexSubChapterLevelOLC">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="(parent::subdivision or parent::division) and ($currentElementStyle = 'USC')">
				<span class="lbexTitleLevelIRCEx">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<!-- Traditional Style -->
			<xsl:when
				test="parent::division and ($currentElementStyle = 'traditional-inline' or $currentElementStyle = 'appropriations')">
				<span class="lbexTitleLevelTradIn">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="parent::subdivision and ($currentElementStyle = 'traditional' or contains($currentElementStyle, 'archaic'))">
				<span class="lbexInitialCapArchaic">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="parent::subdivision and ($currentElementStyle = 'traditional-inline' or $currentElementStyle = 'appropriations')">
				<span class="lbexSubChapterLevelOLC">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="(parent::division or parent::title or parent::subdivision) and ($currentElementStyle = 'traditional' or $currentElementStyle = 'traditional-inline' or contains($currentElementStyle, 'archaic'))">
				<span class="lbexSubTitleLevelTradUp">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="parent::subtitle and ($currentElementStyle = 'traditional' or $currentElementStyle = 'traditional-inline' or $currentElementStyle = 'archaic-paragraph')">
				<span class="lbexSubTitleLevelTrad">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="parent::part and ($currentElementStyle = 'traditional' or $currentElementStyle = 'traditional-inline' or $currentElementStyle = 'archaic-paragraph')">
				<span class="lbexPartlevelTrad">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="parent::subpart and ($currentElementStyle = 'traditional' or $currentElementStyle = 'traditional-inline' or $currentElementStyle = 'archaic-paragraph')">
				<span class="lbexSubTitleLevelTrad">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="parent::chapter and ($currentElementStyle = 'traditional')">
				<span class="lbexChapterLevelTrad">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="parent::chapter and $currentElementStyle = 'archaic-paragraph'">
				<span class="lbexTitleLevelTradEx">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="parent::chapter and ($currentElementStyle = 'traditional-inline' or $currentElementStyle = 'appropriations')">
				<span class="lbexTitleLevelTradEx">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="parent::subchapter and ($currentElementStyle = 'traditional' or $currentElementStyle = 'archaic-paragraph')">
				<span class="lbexSubTitleLevelTradUp">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="parent::subchapter and ($currentElementStyle = 'traditional-inline' or $currentElementStyle = 'appropriations')">
				<span class="lbexSubTitleLevelTrad">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<!-- Tax Style and Nuclear only chapter is different between them -->
			<xsl:when
				test="(parent::division or parent::title or parent::subdivision) and ($currentElementStyle = 'tax' or $currentElementStyle = 'nuclear')">
				<span class="lbexTitleLevelIRCEx">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="parent::subtitle and ($currentElementStyle = 'tax' or $currentElementStyle = 'nuclear')">
				<span class="lbexSubTitleLevelOLC">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="parent::part and ($currentElementStyle = 'tax' or $currentElementStyle = 'nuclear')">
				<span class="lbexPartLevelIRCEx">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="parent::subpart and ($currentElementStyle = 'tax' or $currentElementStyle = 'nuclear')">
				<span class="lbexSubpartLevelOLC">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="parent::chapter and $currentElementStyle = 'tax'">
				<span class="lbexTitleLevelTradIn">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="parent::subchapter and ($currentElementStyle = 'tax' or $currentElementStyle = 'nuclear')">
				<span class="lbexSubChapterLevelOLC">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<!--Nuclear style only - chapter-->
			<xsl:when test="parent::chapter and $currentElementStyle = 'nuclear'">
				<span class="lbexTitleLevelTradEx">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="parent::appropriations-major">
				<!--span class="lbexHeaderAppropMajor">
					<xsl:apply-templates/>
					</span-->
				<xsl:call-template name="toPrintApprHeaderNoBreaks"/>
			</xsl:when>
			<xsl:when test="parent::appropriations-intermediate">
				<!--span class="lbexHeaderAppropIntermediate">
					<xsl:apply-templates/>
					</span-->
				<xsl:call-template name="toPrintApprHeaderNoBreaks"/>
			</xsl:when>
			<xsl:when test="parent::appropriations-small">
				<!--span class="lbexHeaderAppropSmall">
					<xsl:apply-templates/>
					</span-->
				<xsl:call-template name="toPrintApprHeaderNoBreaks"/>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexSmallcap">
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template match="omitted-text">
		<xsl:choose>
			<xsl:when test="@type = 'horizontal'">
				<xsl:variable name="textPositionAfter" select="position()"/>
				<!-- TB I have to check by each different number. For unknown reason it is not taken by variable - brings empty node set. Sorry -->
				<xsl:if test="$textPositionAfter = 1">
					<xsl:call-template name="actualPrintHorizontalStars">
						<xsl:with-param name="stringBefore" select="NoData"/>
						<xsl:with-param name="stringAfter" select="parent::text/text()[1]"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$textPositionAfter = 2">
					<xsl:call-template name="actualPrintHorizontalStars">
						<xsl:with-param name="stringBefore" select="parent::text/text()[1]"/>
						<xsl:with-param name="stringAfter" select="parent::text/text()[2]"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$textPositionAfter = 3">
					<xsl:call-template name="actualPrintHorizontalStars">
						<xsl:with-param name="stringBefore" select="parent::text/text()[2]"/>
						<xsl:with-param name="stringAfter" select="parent::text/text()[3]"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$textPositionAfter = 4">
					<xsl:call-template name="actualPrintHorizontalStars">
						<xsl:with-param name="stringBefore" select="parent::text/text()[3]"/>
						<xsl:with-param name="stringAfter" select="parent::text/text()[4]"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$textPositionAfter = 5">
					<xsl:call-template name="actualPrintHorizontalStars">
						<xsl:with-param name="stringBefore" select="parent::text/text()[4]"/>
						<xsl:with-param name="stringAfter" select="parent::text/text()[5]"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$textPositionAfter = 6">
					<xsl:call-template name="actualPrintHorizontalStars">
						<xsl:with-param name="stringBefore" select="parent::text/text()[5]"/>
						<xsl:with-param name="stringAfter" select="parent::text/text()[6]"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$textPositionAfter = 7">
					<xsl:call-template name="actualPrintHorizontalStars">
						<xsl:with-param name="stringBefore" select="parent::text/text()[6]"/>
						<xsl:with-param name="stringAfter" select="parent::text/text()[7]"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$textPositionAfter = 8">
					<xsl:call-template name="actualPrintHorizontalStars">
						<xsl:with-param name="stringBefore" select="parent::text/text()[7]"/>
						<xsl:with-param name="stringAfter" select="parent::text/text()[8]"/>
					</xsl:call-template>
				</xsl:if>


				<xsl:if test="omitted-text/text-after">
					<!--if punctuation following-->
					<xsl:text> </xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:when test="@type = 'vertical'">
				<div style="text-align:center">
					<p class="lbexOmmitedTextSpace">
						<xsl:text>*  *  *  *  *  *  *</xsl:text>
					</p>
				</div>
			</xsl:when>

		</xsl:choose>
	</xsl:template>
	<xsl:template name="actualPrintHorizontalStars">
		<xsl:param name="stringBefore"/>
		<xsl:param name="stringAfter"/>

		<xsl:if test="$stringBefore != 'noData'">
			<span class="lbexNSpace">
				<xsl:text> </xsl:text>
			</span>
		</xsl:if>
		<span class="lbexNSpace">
			<xsl:text>*  *  *</xsl:text>
		</span>
		<xsl:if
			test="not($stringAfter = '.' or $stringAfter = ',' or $stringAfter = ';' or $stringAfter = ':' or $stringAfter = '?' or $stringAfter = '!' or $stringAfter = '...' or $stringAfter = '/')">
			<span class="lbexNSpace">
				<xsl:text> </xsl:text>
			</span>
		</xsl:if>
	</xsl:template>
	<!-- ********************* New Templates - aMendment Support Developed by TB Dec-2007 - Jan-2008 -->
	<xsl:template name="printActionDescForAmendment">
		<xsl:choose>
			<xsl:when test="$amendType = 'house-amendment'">
				<div style="text-align:center">
					<p class="lbexInitialcap">
						<xsl:apply-templates/>
					</p>
				</div>
			</xsl:when>
			<xsl:when test="$senateStyle1 = 'yes'">
				<ul>
					<div style="text-align:center">
						<p style="text-align:center">
							<xsl:choose>
								<!--xsl:when
									commentd by TB bug #1094
									test="starts-with(translate(.,$upper,$lower),'amendment in the nature of a substitute')">
									<span class="sectionlevelOLCnuclear">
										<xsl:text>Amendment in The Nature Of A Substitute</xsl:text>
									</span>
									<span class="hang">
										<xsl:value-of select="substring( .,40)"/>
									</span>
								</xsl:when-->
								<xsl:when
									test="starts-with(translate(., $upper, $lower), 'amendment') and position() = last()">
									<span class="lbexSectionLevelOLCnuclear">
										<xsl:text>Amendment </xsl:text>
									</span>
									<span class="lbexHang">
										<xsl:value-of select="substring(., 11)"/>
									</span>
								</xsl:when>
								<xsl:otherwise>
									<span class="lbexHang">
										<xsl:value-of select="."/>
									</span>
								</xsl:otherwise>
							</xsl:choose>
						</p>
					</div>
				</ul>
			</xsl:when>
			<xsl:otherwise>
				<ul>
					<p style="text-align:left" class="lbexHangSmall">
						<xsl:apply-templates/>
					</p>
				</ul>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="printActionInstructionForAmendmennt">
		<xsl:choose>
			<xsl:when test="$amendType = 'house-amendment'">
				<div style="text-align:center">
					<p class="lbexSectionlevelOLC">
						<xsl:apply-templates/>
					</p>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="text() != ''">
					<div style="text-align:center">
						<p style="font-size: 65%">
							<xsl:text>[</xsl:text>
							<xsl:apply-templates/>
							<xsl:text>]</xsl:text>
						</p>
					</div>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="IsElementCommented">
		<xsl:choose>
			<xsl:when test="not(@commented)">
				<xsl:text>no</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@commented"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="PrintAmendNumberForSenate">
		<xsl:if test="//amendment-doc/@dms-id = 'G'">
			<table class="lbexGeneralStyle100">
				<tr>
					<td class="lbexTocSectionIRCBold" style="width:50%;text-align:left;"/>

					<td class="lbexTdStyleSix">
						<xsl:if test="not(//calendar[@display = 'no'])">
							<span style="text-align:right" class="lbexTocSectionIRCBold">
								<xsl:call-template name="printAmendmentCalendar"/>
							</span>
						</xsl:if>
					</td>
				</tr>
				<tr>
					<td>
						<br/>
					</td>
					<td/>
				</tr>
				<tr>
					<td class="lbexTocSectionIRCBold" style="width:50%;text-align:left;">
						<xsl:if test="not(//amend-num[@display = 'no'])">
							<span style="text-align:left" class="lbexTocSectionIRCBold">
								<xsl:call-template name="printAmendNumberForSenate"/>
							</span>
						</xsl:if>
					</td>
				</tr>
			</table>
		</xsl:if>
		<xsl:if test="not(//amendment-doc/@dms-id = 'G')">
			<table class="lbexGeneralStyle100">
				<tr>
					<td class="lbexTocSectionIRCBold" style="width:50%;text-align:left;">
						<xsl:if test="not(//amend-num[@display = 'no'])">
							<span style="text-align:left" class="lbexTocSectionIRCBold">
								<xsl:call-template name="printAmendNumberForSenate"/>
							</span>
						</xsl:if>
					</td>
					<td class="lbexTdStyleSix">
						<xsl:if test="not(//calendar[@display = 'no'])">
							<span style="text-align:right" class="lbexTocSectionIRCBold">
								<xsl:call-template name="printAmendmentCalendar"/>
							</span>
						</xsl:if>
					</td>
				</tr>
			</table>
		</xsl:if>
	</xsl:template>

	<xsl:template name="printAmendNumberForSenate">
		<xsl:if test="contains(., '.')">
			<xsl:variable name="firstPart">
				<xsl:value-of select="concat(substring-before(., '.'), '. ')"/>
			</xsl:variable>
			<xsl:variable name="lastPart">
				<xsl:value-of select="substring-after(., '.')"/>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="contains($lastPart, '___')">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$firstPart"/>
					<b style="font-size:125%">
						<xsl:value-of select="$lastPart"/>
					</b>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="not(contains(., '.'))">
			<xsl:value-of select="."/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="distribution-code"/>

	<xsl:template name="printAmendmentCalendar">
		<!--xsl:value-of select="//amendment-form/calendar"/-->
		<xsl:if test="contains(//amendment-form/calendar, '.')">
			<xsl:variable name="firstPart">
				<xsl:value-of
					select="concat(substring-before(//amendment-form/calendar, '.'), '. ')"/>
			</xsl:variable>
			<xsl:variable name="lastPart">
				<xsl:value-of select="substring-after(//amendment-form/calendar, '.')"/>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="contains($lastPart, '___')">
					<xsl:value-of select="//amendment-form/calendar"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$firstPart"/>
					<b style="font-size:125%">
						<xsl:value-of select="$lastPart"/>
					</b>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="not(contains(//amendment-form/calendar, '.'))">
			<xsl:value-of select="//amendment-form/calendar"/>
		</xsl:if>
	</xsl:template>


	<xsl:template name="printCongressAndSessionForSenateAmend">
		<span class="lbexBoldLrge">
			<xsl:choose>
				<xsl:when
					test="//amendment-form/congress/@display = 'no' and //amendment-form/session/@display = 'no'">
					<!-- nothing -->
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="not(//current-chamber/@display = 'no')">
						<xsl:text>—</xsl:text>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="//amendment-form/congress/@display = 'no'">
					<!-- Nothing -->
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="//amendment-form/congress"/>
					<xsl:text>,</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="//amendment-form/session/@display = 'no'">
					<!-- Nothing -->
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="//amendment-form/session"/>
				</xsl:otherwise>
			</xsl:choose>
		</span>
	</xsl:template>

	<xsl:template match="engrossed-amendment-form/legis-type">
		<!-- nothing -->
	</xsl:template>

	<xsl:template name="printEngrossedAmendLegisType">
		<div style="text-align:center">
			<p class="lbexCalendarOLC">
				<xsl:value-of select="translate(legis-type, $lower, $upper)"/>
			</p>
			<xsl:if test="local-name() = 'endorsement'">
				<xsl:value-of select="translate(translate(//legis-type, ':', ''), $lower, $upper)"/>
			</xsl:if>
		</div>
	</xsl:template>

	<xsl:template name="displayResolvedSections">
		<xsl:for-each select="//engrossed-amendment-body/section[@section-type = 'resolved']">
			<xsl:call-template name="displaySection"/>
		</xsl:for-each>

	</xsl:template>

	<xsl:template match="amendment-doc/endorsement">
		<xsl:variable name="displayEndorsmentFlag">
			<xsl:text>yes</xsl:text>
			<xsl:if test="@display = 'no'">
				<xsl:text>no</xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:call-template name="DisplayEndorsement">
			<xsl:with-param name="displayFlag" select="$displayEndorsmentFlag"/>
		</xsl:call-template>

	</xsl:template>

	<xsl:template name="GetNumberToPrint">
		<xsl:if test="//bill/form/legis-num">
			<xsl:value-of select="//bill/form/legis-num"/>
		</xsl:if>
		<xsl:if test="//resolution/form/legis-num">
			<xsl:value-of select="//resolution/form/legis-num"/>
		</xsl:if>
		<xsl:if test="//amendment-doc/amendment-form/legis-num">
			<xsl:value-of select="//amendment-doc/amendment-form/legis-num"/>
		</xsl:if>
		<xsl:if test="//engrossed-amendment-body">
			<xsl:variable name="textToSearch">
				<xsl:value-of
					select="//engrossed-amendment-body/section[@section-type = 'resolved']/text"/>
			</xsl:variable>
			<xsl:if test="$textToSearch">
				<xsl:variable name="firstResult" select="substring-after($textToSearch, '(')"/>
				<xsl:value-of select="substring-before($firstResult, ')')"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="//conference-report-form/legis-num">
			<xsl:value-of select="//conference-report-form/legis-num"/>
		</xsl:if>
		<xsl:if test="//committee-report-form/legis-num">
			<xsl:value-of select="//committee-report-form/legis-num"/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="IsSenateAmendment">
		<xsl:choose>
			<xsl:when test="//amendment-doc[@amend-type = 'senate-amendment']">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="contains(translate(//amendment-form/current-chamber, $upper, $lower), 'senate')">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when
				test="contains(translate(//engrossed-amendment-form/current-chamber, $upper, $lower), 'senate')">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when test="contains(translate(//amendment-formlegis-num, $upper, $lower), 's.')">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="getOficialTitleToValidateLength">
		<xsl:if test="form/official-title">
			<xsl:value-of select="form/official-title"/>
		</xsl:if>
		<xsl:if test="//amendment-form/official-title">
			<xsl:value-of select="//amendment-form/official-title"/>
		</xsl:if>
		<xsl:if test="//engrossed-amendment-form/form/official-title">
			<xsl:apply-templates select="//engrossed-amendment-form/form/official-title"/>
		</xsl:if>
	</xsl:template>

	<!-- *******Print Text with quotes if nessesary************* -->
	<xsl:template name="ActualPrintText">
		<xsl:if test="ancestor::quoted-block">
			<xsl:call-template name="openQuotes"/>
		</xsl:if>
		<xsl:variable name="isLastItem">
			<xsl:call-template name="isLastListItem"/>
		</xsl:variable>
		<xsl:variable name="isLastElement">
			<xsl:call-template name="isLastElementInLoop"/>
		</xsl:variable>
		<xsl:variable name="isToCloseTheBrackets">
			<xsl:call-template name="toCloseTheBrakets"/>
		</xsl:variable>
		<xsl:if test="@commented='yes' and (./@indent != 'up1' or not(./@indent))">
			<xsl:choose>
				<xsl:when test="contains(@display-inline,'yes')"></xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="openBracketStyles"/>
				</xsl:otherwise>
			</xsl:choose>
			
		</xsl:if>
		<xsl:choose>
			<xsl:when
				test="contains(ancestor-or-self::*/@reported-display-style, 'brackets') and (not(@changed) or @changed != 'not-changed') and (not(parent::*/@changed) or parent::*/@changed != 'not-changed') and (./@indent != 'up1' or not(@indent)) ">
				<xsl:choose>
					<xsl:when test="ancestor::appropriations-major or ancestor::appropriations-intermediate or ancestor::appropriations-small">	
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="openBracketStyles"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="contains(ancestor::*/@reported-display-style, 'parentheses')">
				<xsl:call-template name="openParenStyles"/>
			</xsl:when>
		</xsl:choose>


		<xsl:choose>
			<xsl:when
				test="ancestor::appropriations-major or ancestor::appropriations-intermediate or ancestor::appropriations-small">
				<xsl:variable name="appropReportedStyle">
					<xsl:call-template name="getAppropriationReportingStyle"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$appropReportedStyle = 'italic'">
						<span style="font:italic;">
							<i class="lbexTextNeutral">
								<xsl:call-template name="ActualPrintAppropriationElement"/>
							</i>
						</span>
					</xsl:when>
					<xsl:when test="$appropReportedStyle = 'strikethrough'">
						<span class="lbexTextStrikethrough">
							<xsl:call-template name="ActualPrintAppropriationElement"/>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="ActualPrintAppropriationElement"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	<xsl:if test="parent::*/@commented='yes' and (parent::*[1]/@indent != 'up1' or not(parent::*[1]/@indent))">
			<xsl:choose>
				<xsl:when test="@commented='no'">
					
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="closedBracketStyles"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:if
			test="contains(ancestor-or-self::*/@reported-display-style, 'brackets') and $isLastItem = 'yes' and $isToCloseTheBrackets = 'yes' and $isLastElement = 'yes' and (./@indent != 'up1' or not(@indent))">
			<xsl:choose>
				<xsl:when test="ancestor::appropriations-major or ancestor::appropriations-intermediate or ancestor::appropriations-small">	
				</xsl:when>
				<xsl:when test ="child::text">
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="closedBracketStyles"/>
				</xsl:otherwise>
			</xsl:choose>
			
		</xsl:if>
	</xsl:template>

	<!--***************** Print Quoted Text************* -->
	<xsl:template name="printQuotedText">
		<xsl:variable name="currElementStyle">
			<xsl:call-template name="getCurrentElementStyle"/>
		</xsl:variable>

		<xsl:if
			test="local-name() = 'paragraph' and $currElementStyle = 'archaic-paragraph' and self::*/header/text() != ''">
			<!-- Display paragraph header -->
			<xsl:if test="not(parent::subsection) or parent::subsection[1]/header != ''">
			<div class="lbexSectionLevelOLCnuclear" style="text-align:center">
				<xsl:call-template name="openQuotes"/>
				<!--xsl:value-of select="header"/-->
				<xsl:apply-templates select="header">
					<xsl:with-param name="isSpecialPrinting">
						<xsl:text>yes</xsl:text>
					</xsl:with-param>
				</xsl:apply-templates>
			</div>
			<p/>
		</xsl:if>
		</xsl:if>
		<xsl:call-template name="openQuotes"/>
		<xsl:apply-templates/>

		<!-- TB May2011 Bug Fixing 1207 -->
		<xsl:if
			test="local-name(following-sibling::*[1]) = 'after-quoted-block' and (following-sibling::*[1]/deleted-phrase or following-sibling::*[1]/added-phrase)">
			<xsl:text>”</xsl:text>
			<xsl:for-each select="following-sibling::*[1]/node()">
				<xsl:choose>
					<xsl:when test="local-name() = 'deleted-phrase'">
						<xsl:apply-templates select=".">
							<xsl:with-param name="source">after-quoted-block</xsl:with-param>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:when test="local-name() = 'added-phrase'">
						<xsl:apply-templates select=".">
							<xsl:with-param name="source">after-quoted-block</xsl:with-param>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>

		</xsl:if>
	</xsl:template>


	<xsl:variable name="senateStyle1">
		<xsl:choose>
			<xsl:when test="$amendType = 'senate-amendment'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when test="$amendType = 'Amendment-in-the-Nature-of-a-Substitute'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when test="$amendType = 'Amendment-to-the-Amend'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when test="$amendType = 'Amendment-to-Amend-in-the-Nature-of-a-Substitute'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when test="$amendType = 'Substitute-to-Amend'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when test="$amendType = 'Amendment-to-the-Substitute'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when test="$amendType = 'Substitute-to-Amend-in-the-Nature-of-a-Substitute'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when test="$amendType = 'Amendment-to-Sub-to-Amend-in-the-Nature-of-a-Substitute'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:template name="IsDocumentReport">
		<xsl:choose>
			<xsl:when test="$amendType = 'conference-report'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:when test="//committee-report">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- TB January 2014 cleanup for the result html validation -->
	<xsl:template match="calendar">
		<xsl:choose>
			<xsl:when test="parent::committee-report-form">
				<!--skip-->
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="BuildReportHeader">
		<xsl:if
			test="//committee-report-form/calendar and not(//committee-report-form/calendar/@display = 'no') and //committee-report-form/calendar != ''">
			<table class="lbexGeneralStyle100" align="center">
				<tr>
					<td style="text-align:right" class="lbexLegisNumSml">
						<xsl:value-of select="//committee-report-form/calendar"/>
					</td>
				</tr>
			</table>
		</xsl:if>
		<table class="lbexGeneralStyle100">
			<xsl:if test="//running-header and not(//running-header/@display = 'no')">
				<tr>
					<td colspan="5" style="font-weight:bold;text-align:center">
						<xsl:value-of select="//running-header"/>
						<br/>
						<br/>
						<br/>
						<br/>
						<xsl:if test="not(//author-note) or //author-note/@display = 'no'">
							<br/>
							<br/>
							<br/>
						</xsl:if>
					</td>

				</tr>
			</xsl:if>
			<xsl:if test="//author-note and not(//author-note/@display = 'no')">
				<tr>
					<td colspan="5" style="text-align:left">
						<span style="font-weight:normal;">
							<xsl:value-of select="//author-note"/>
						</span>
						<br/>
						<br/>
					</td>
				</tr>
			</xsl:if>
			<tr>
				<td colspan="5" style="text-align:center" class="lbexSmallcap">
					<xsl:if test="//first-page-header[@display = 'yes' or not(@display)]">
						<xsl:value-of select="//first-page-header"/>
					</xsl:if>
				</td>
			</tr>
			<xsl:if test="//first-page-date and not(//first-page-date/@display = 'no')">
				<tr>
					<td colspan="5" style="font-size:16px;text-align:center">
						<div style="text-align:center">
							<xsl:value-of select="//first-page-date"/>
						</div>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="//first-page-desc and not(//first-page-desc/@display = 'no')">
				<tr>
					<td colspan="5" style="text-align:center">
						<xsl:call-template name="first-page-desc"/>
						<br/>
						<br/>
						<br/>
						<br/>
					</td>
				</tr>
			</xsl:if>
			<tr>
				<td style="width:21%;">
					<table class="lbexGeneralStyle100">
						<tr>
							<td style="text-align:center;" class="lbexTocSubDivisionOLC">
								<xsl:if test="//congress and not(//congress/@display = 'no')">
									<xsl:value-of select="//congress"/>
								</xsl:if>
							</td>
						</tr>
						<tr>
							<td style="text-align:center;">
								<i class="lbexTextNeutral">
									<xsl:if test="//session and not(//session/@display = 'no')">
										<xsl:value-of select="//session"/>
									</xsl:if>
								</i>
							</td>
						</tr>
					</table>
				</td>
				<td style="width:2%;font-size:30pt;">
					<xsl:text>}</xsl:text>
				</td>
				<td style="text-align:center" valign="center" class="lbexSmallCapTrad">
					<xsl:value-of select="translate(//current-chamber, $lower, $upper)"/>
				</td>
				<td style="width:2%;font-size:30pt;">
					<xsl:text>{</xsl:text>
				</td>
				<td style="width:21%;">
					<table class="lbexGeneralStyle100">
						<xsl:if test="not(//report-num/@part != '' and //report-num/@part != '0')">
							<tr>
								<td style="text-align:center" class="lbexTocSubDivisionOLC">
									<xsl:text>Report</xsl:text>
								</td>
							</tr>
						</xsl:if>
						<tr>
							<td style="text-align:center" class="lbexTocSubDivisionOLC">
								<xsl:choose>
									<xsl:when test="//report-num/@display = 'no'"/>
									<xsl:when
										test="//report-num/@part != '' and //report-num/@part != '0'">
										<xsl:text>Rept.</xsl:text>
										<xsl:value-of select="//report-num"/>
										<br/>
										<xsl:text>Part </xsl:text>
										<xsl:value-of select="//report-num/@part"/>
									</xsl:when>
									<xsl:when test="//report-num/text() != ''">
										<xsl:value-of select="//report-num"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>______________</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<!--xsl:choose>
									<xsl:when test="//report-num/@display='no'"/>
									<xsl:when test="//report-num/text() !=''">
										<xsl:value-of select="//report-num"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>______________</xsl:text>
									</xsl:otherwise>
								</xsl:choose-->
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="5" valign="top">
					<hr/>
				</td>
			</tr>
		</table>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
	</xsl:template>

	<xsl:template name="printToAccompanyText">
		<div style="text-align:center">
			<xsl:choose>
				<xsl:when test="$confReportStyle = 'bill'">
					<!-- No 65% for bill style -->
					<span class="lbexHang">
						<xsl:text>[To accompany </xsl:text>
						<xsl:value-of select="//legis-num"/>
						<xsl:text>]</xsl:text>
					</span>
				</xsl:when>
				<xsl:otherwise>
					<span class="lbexHang" style="font-size:65%">
						<xsl:text>[To accompany </xsl:text>
						<xsl:choose>
							<xsl:when test="//legis-num/@display = 'no'"/>
							<xsl:when test="//legis-num/text() != ''">
								<xsl:value-of select="//legis-num"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>_______ </xsl:text>
							</xsl:otherwise>
						</xsl:choose>


						<xsl:text>]</xsl:text>
					</span>
				</xsl:otherwise>
			</xsl:choose>

		</div>
	</xsl:template>

	<xsl:template name="calcLengthForLeader">
		<xsl:param name="currStringLength"/>
		<xsl:param name="isFirstLine"/>
		<xsl:param name="lenghtToMatch"/>
		<xsl:param name="indentLevel"/>

		<xsl:variable name="indentLevelNumber">
			<xsl:choose>
				<xsl:when test="$indentLevel != '' and $indentLevel != '0%'">
					<xsl:value-of select="substring-before($indentLevel, '%')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:variable>

		<xsl:variable name="matchToNumber">
			<xsl:choose>
				<xsl:when test="$lenghtToMatch &gt; 0">
					<xsl:value-of select="number($lenghtToMatch) - number($indentLevelNumber)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="90 - number($indentLevelNumber)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>


		<xsl:choose>
			<xsl:when
				test="($currStringLength - (number($matchToNumber) + 10) &lt; 0) and ($isFirstLine = 'true')">
				<xsl:value-of select="number($matchToNumber) + 10 - ($currStringLength * 1.8)"/>
			</xsl:when>
			<xsl:when
				test="($isFirstLine = 'true') and ($currStringLength - (number($matchToNumber) + 10) &gt; 0)">
				<xsl:call-template name="calcLengthForLeader">
					<xsl:with-param name="currStringLength"
						select="$currStringLength - (number($matchToNumber) + 10)"/>
					<xsl:with-param name="isFirstLine">false</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when
				test="($isFirstLine = 'true') and ($currStringLength - (number($matchToNumber) + 10) = 0)">
				<xsl:value-of select="number($matchToNumber) + 10"/>
			</xsl:when>
			<xsl:when test="$currStringLength - number($matchToNumber) = 0">
				<xsl:value-of select="$matchToNumber"/>
			</xsl:when>
			<xsl:when test="$currStringLength - number($matchToNumber) &lt; 0">
				<xsl:value-of select="number($matchToNumber) - ($currStringLength * 1.8)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="calcLengthForLeader">
					<xsl:with-param name="currStringLength"
						select="$currStringLength - number($matchToNumber)"/>
					<xsl:with-param name="isFirstLine">false</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="actualPrintFirstColumnMultiToc">
		<xsl:param name="isBold"/>
		<xsl:param name="isItalic"/>
		<xsl:param name="indentLevel"/>

		<xsl:variable name="toBeNeutralized">
			<xsl:call-template name="isNeutralizeSegment"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$isBold = 'yes' and $isItalic = 'yes'">
				<b>
					<i>
						<xsl:if test="$toBeNeutralized = 'yes'">
							<xsl:attribute name="class">lbexTextNeutral</xsl:attribute>
						</xsl:if>
						<xsl:call-template name="printMultiColTocMainContent"/>
					</i>
				</b>
			</xsl:when>
			<xsl:when test="$isBold = 'yes'">
				<b>
					<xsl:call-template name="printMultiColTocMainContent"/>
				</b>
			</xsl:when>
			<xsl:when test="$isItalic = 'yes'">
				<i>
					<xsl:if test="$toBeNeutralized = 'yes'">
						<xsl:attribute name="class">lbexTextNeutral</xsl:attribute>
					</xsl:if>
					<xsl:call-template name="printMultiColTocMainContent"/>
				</i>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="printMultiColTocMainContent"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="ActualPrintMultiColumnToc">
		<xsl:param name="isBold"/>
		<xsl:param name="isItalic"/>

		<xsl:variable name="indentLevel">
			<xsl:choose>
				<xsl:when test="@level = 'paragraph'">
					<xsl:text>10%</xsl:text>
				</xsl:when>
				<xsl:when test="@level = 'subparagraph'">
					<xsl:text>15%</xsl:text>
				</xsl:when>
				<xsl:when test="@level = 'clause'">
					<xsl:text>20%</xsl:text>
				</xsl:when>
				<xsl:when test="@level = 'subclause'">
					<xsl:text>25%</xsl:text>
				</xsl:when>
				<xsl:when test="@level = 'item'">
					<xsl:text>30%</xsl:text>
				</xsl:when>
				<xsl:when test="@level = 'item'">
					<xsl:text>35%</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0%</xsl:text>
					<!-- nothing -->
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>


		<li>
			<span>
				<xsl:call-template name="actualPrintFirstColumnMultiToc">
					<xsl:with-param name="isBold" select="$isBold"/>
					<xsl:with-param name="isItalic" select="$isItalic"/>
					<xsl:with-param name="indentLevel" select="$indentLevel"/>
				</xsl:call-template>
			</span>
			<span>
				<xsl:choose>
					<xsl:when test="$isBold = 'yes' and $isItalic = 'yes'">
						<b>
							<i class="lbexTextNeutral">
								<xsl:call-template name="printMultiColTocmiscContent"/>
							</i>
						</b>
					</xsl:when>
					<xsl:when test="$isBold = 'yes'">
						<b>
							<xsl:call-template name="printMultiColTocmiscContent"/>
						</b>
					</xsl:when>
					<xsl:when test="$isItalic = 'yes'">
						<i class="lbexTextNeutral">
							<xsl:call-template name="printMultiColTocmiscContent"/>
						</i>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="printMultiColTocmiscContent"/>
					</xsl:otherwise>
				</xsl:choose>
			</span>
		</li>
	</xsl:template>

	<xsl:template name="printMultiColTocMainContent">
		<xsl:if test="ancestor::quoted-block">
			<xsl:call-template name="openQuotes"/>
		</xsl:if>
		<xsl:apply-templates select="toc-enum"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="level-header"/>
		<xsl:text> </xsl:text>
		<xsl:text> </xsl:text>
	</xsl:template>

	<xsl:template name="printMultiColTocmiscContent">
		<xsl:apply-templates select="target"/>
		<xsl:apply-templates select="page-num"/>
	</xsl:template>

	<xsl:template name="IsPrintItalicTextForReport">
		<xsl:choose>
			<xsl:when
				test="ancestor-or-self::amendment-block and ($isReport = 'yes' and $confReportStyle = 'committee' and not(parent::amendment-instruction))">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="printLegisNumForBills">
		<xsl:if test="not(//form/@display = 'no')">
			<xsl:call-template name="printSessionAndCongressForBills"/>
			<xsl:if test="not(//legis-num/@display = 'no')">
				<xsl:variable name="tempLegisNum" select="//legis-num"/>

				<xsl:choose>
					<xsl:when test="string-length($tempLegisNum) = 16">
						<div style="text-align:center" class="lbexLegisNumLrg">
							<xsl:apply-templates select="//legis-num"/>
						</div>
					</xsl:when>
					<xsl:when
						test="string-length(legis-num) &lt; 16 and string-length($tempLegisNum) &gt; 13">
						<table class="lbexTableStyleThree">
							<tr>
								<td/>
							</tr>
							<tr>
								<td/>
							</tr>
						</table>
						<xsl:if test="not(//legis-num/@display = 'no')">
							<div style="text-align:center">
								<span class="lbexLegisNumLrg" style="margin-left: -.4em;">
									<xsl:apply-templates select="//legis-num"/>
								</span>
							</div>
						</xsl:if>
					</xsl:when>
					<xsl:when
						test="string-length(legis-num) &lt; 14 and string-length($tempLegisNum) &gt; 10">
						<table class="lbexTableStyleFour">
							<tr>
								<td/>
							</tr>
							<tr>
								<td/>
							</tr>
						</table>
						<div style="text-align:center">
							<span class="lbexLegisNumAvg">
								<xsl:apply-templates select="//legis-num"/>
							</span>
						</div>
					</xsl:when>
					<xsl:when test="string-length(legis-num) &lt; 11">
						<table class="lbexTableStyleFour">
							<tr>
								<td/>
							</tr>
							<tr>
								<td/>
							</tr>
						</table>
						<div style="text-align:center">
							<span class="lbexLegisNum">
								<xsl:apply-templates select="//legis-num"/>
							</span>
						</div>
					</xsl:when>
				</xsl:choose>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template name="printLegisNumForBillReports">
		<xsl:call-template name="printSessionAndCongressForBillReports"/>
		<xsl:variable name="tempLegisNum" select="//legis-num"/>
		<xsl:choose>
			<xsl:when test="string-length($tempLegisNum) = 16">
				<span class="lbexLegisNumLrg">
					<xsl:value-of select="$tempLegisNum"/>
				</span>
			</xsl:when>
			<xsl:when
				test="string-length(legis-num) &lt; 16 and string-length($tempLegisNum) &gt; 13">
				<table class="lbexTableStyleThree">
					<tr>
						<td/>
					</tr>
					<tr>
						<td/>
					</tr>
				</table>
				<div style="text-align:center">
					<span class="lbexLegisNumLrg" style="margin-left: -.4em;">
						<xsl:value-of select="$tempLegisNum"/>
					</span>
				</div>
			</xsl:when>
			<xsl:when
				test="string-length(legis-num) &lt; 14 and string-length($tempLegisNum) &gt; 10">
				<table class="lbexTableStyleFour">
					<tr>
						<td/>
					</tr>
					<tr>
						<td/>
					</tr>
				</table>
				<div style="text-align:center">
					<span class="lbexLegisNumAvg">
						<xsl:value-of select="$tempLegisNum"/>
					</span>
				</div>
			</xsl:when>
			<xsl:when test="string-length(legis-num) &lt; 11">
				<table class="lbexTableStyleFour">
					<tr>
						<td/>
					</tr>
					<tr>
						<td/>
					</tr>
				</table>
				<div style="text-align:center">
					<span class="lbexLegisNum">
						<xsl:value-of select="$tempLegisNum"/>
					</span>
				</div>
			</xsl:when>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="printSessionAndCongressForBills">
		<table class="lbexTableStyleSix">
			<tr>
				<td class="lbexTdStyleThree">
					<div style="text-align:center">
						<xsl:if
							test="//congress/@display = 'yes' or (not(//congress/@display) and //congress)">
							<span class="lbexSimplecap">
								<xsl:apply-templates select="//congress"/>
							</span>
						</xsl:if>
						<br/>
						<xsl:if
							test="//session/@display = 'yes' or (not(//session/@display) and //session)">
							<span class="lbexSimplecap">
								<xsl:apply-templates select="//session"/>
							</span>
						</xsl:if>
					</div>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="printSessionAndCongressForBillReports">
		<table class="lbexTableStyleSix">
			<tr>
				<td class="lbexTdStyleThree">
					<div style="text-align:center">
						<span class="lbexSimplecap">
							<xsl:value-of select="//congress"/>
						</span>
						<br/>
						<span class="lbexSimplecap">
							<xsl:value-of select="//session"/>
						</span>
					</div>
				</td>
			</tr>
		</table>
	</xsl:template>
	<!-- ************Committee Report Para *************************************** -->
	<!-- TB May2011 bug fixing #1205 -->
	<xsl:template match="committee-report-para">
		<p style="text-align:left">
			<xsl:choose>
				<xsl:when test="@margin-indent = 'yes'">
					<table class="lbexTableStyleSeven" align="center">
						<tr>
							<td class="lbexIndent">
								<xsl:apply-templates/>
							</td>
						</tr>
					</table>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
		</p>
	</xsl:template>
	<!-- ************Committee Report SubPara *************************************** -->
	<xsl:template match="committee-report-subpara">

		<xsl:choose>
			<xsl:when test="@margin-indent = 'yes'">
				<table class="lbexTableStyleSeven" align="center">
					<tr>
						<td class="lbexIndent">
							<p style="text-align:left">
								<xsl:apply-templates/>
							</p>
						</td>
					</tr>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<table class="lbexTableStyleEight" align="center">
					<tr>
						<td class="lbexIndent">
							<p style="text-align:left">
								<xsl:apply-templates/>
							</p>
						</td>
					</tr>
				</table>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>
	<!-- ************Committee Report Segmnent *************************************** -->
	<!-- TB May2011 bug fixing #1205 -->
	<xsl:template match="committee-report-segment">
		<p style="text-align:left">
			<xsl:choose>
				<xsl:when test="@margin-indent = 'yes'">
					<table class="lbexTableStyleSeven" align="center">
						<tr>
							<td class="lbexIndent">
								<xsl:apply-templates/>
							</td>
						</tr>
					</table>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
		</p>
	</xsl:template>
	<!-- ************************Committee Report Part*********************************** -->
	<xsl:template match="committee-report-part">
		<xsl:apply-templates/>
	</xsl:template>
	<!--**************************Insert Spaces *************************************-->
	<xsl:template name="insertSpaces">
		<xsl:param name="origString"/>
		<xsl:choose>
			<xsl:when test="string-length($origString) > 1">
				<!--Take first letter of the string-->
				<xsl:variable name="firstPasrtString">
					<xsl:value-of select="concat(substring($origString, 1, 1), ' ')"/>
				</xsl:variable>
				<!--generate the reast of the string recursively-->
				<xsl:variable name="generatedString">
					<xsl:call-template name="insertSpaces">
						<xsl:with-param name="origString" select="substring($origString, 2)"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="concat($firstPasrtString, $generatedString)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$origString"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!--**************************Remove Last Spaces *************************************-->
	<xsl:template name="RemoveSpaces">
		<xsl:param name="origString"/>
		<xsl:variable name="cutString">
			<xsl:choose>
				<xsl:when test="substring($origString, string-length($origString), 1) = ' '">
					<xsl:value-of select="substring($origString, 1, string-length($origString) - 1)"
					/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$origString"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="substring($cutString, string-length($cutString), 1) = ' '">
				<xsl:call-template name="RemoveSpaces">
					<xsl:with-param name="origString" select="$cutString"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$cutString"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>


	<!-- ******************Print Section Header by Style Default regardless of Committee ID ********** -->
	<xsl:template name="printReportHeaderByStyle">
		<xsl:param name="aReportHeaderStyle"/>
		<xsl:choose>
			<xsl:when test="parent::amendment-list-item and $committeeID = 'CommitteeCustomization'">
				<!-- for customized presentation of amendment list header and numbering per commiteeID -->
				<!-- the next when clause printing the default presentatin of that. -->
			</xsl:when>
			<xsl:when test="parent::amendment-list-item or parent::toc">
				<span class="lbexNSpace"/>
				<span class="lbexSimplecap">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when
				test="parent::committee-report-title and @display-inline = 'yes-display-inline'">
				<p/>
				<div style="text-align:center">
					<xsl:if test="preceding-sibling::enum">
						<xsl:text>TITLE </xsl:text>
						<xsl:value-of select="preceding-sibling::enum"/>
						<xsl:text>—</xsl:text>
					</xsl:if>
					<xsl:value-of select="translate(., $lower, $upper)"/>
				</div>
				<p/>
			</xsl:when>
			<xsl:when test="parent::committee-report-title">
				<p/>
				<div style="text-align:center">
					<xsl:if test="preceding-sibling::enum">
						<xsl:text>TITLE </xsl:text>
						<xsl:value-of select="preceding-sibling::enum"/>
					</xsl:if>
					<p/>
					<xsl:value-of select="translate(., $lower, $upper)"/>
				</div>
				<p/>
			</xsl:when>
			<xsl:when
				test="parent::committee-report-title and @display-inline = 'no-display-inline'">
				<div style="font-variant: small-caps;text-transform: capitalize;text-align:left">
					<xsl:value-of select="."/>
				</div>
				<p/>
			</xsl:when>
			<xsl:when
				test="$aReportHeaderStyle = 'GPO-head-1' or translate($aReportHeaderStyle, $upper, $lower) = 'caps-small-caps'">
				<div style="font-variant: small-caps;text-transform: capitalize;text-align:left">
					<xsl:value-of select="."/>
				</div>
				<p/>
			</xsl:when>
			<xsl:when test="translate($aReportHeaderStyle, $upper, $lower) = 'all-caps'">
				<div style="font-variant: small-caps;text-transform: capitalize;text-align:left">
					<xsl:value-of select="translate(., $lower, $upper)"/>
				</div>
				<p/>
			</xsl:when>
			<xsl:when
				test="$aReportHeaderStyle = 'GPO-head-2' or translate($aReportHeaderStyle, $upper, $lower) = 'all-small-caps'">
				<div style="font-variant: small-caps;text-align:center">
					<xsl:value-of select="translate(., $lower, $upper)"/>
				</div>
				<p/>
			</xsl:when>
			<xsl:when
				test="$aReportHeaderStyle = 'GPO-head-3' and following-sibling::text/@display-inline = 'yes-display-inline'">
				<p/>
				<!-- TB June2011 - Multiple browsers support -->
				<span style="text-transform:capitalize;text-align:left">
					<i class="lbexTextNeutral">
						<xsl:value-of select="."/>
						<xsl:text>.— </xsl:text>
					</i>
				</span>
			</xsl:when>
			<xsl:when test="$aReportHeaderStyle = 'GPO-head-3'">
				<div style="font:italic;text-transform: capitalize;text-align:left">
					<i class="lbexTextNeutral">
						<xsl:value-of select="."/>
					</i>
				</div>
				<p/>
			</xsl:when>
			<xsl:when
				test="$aReportHeaderStyle = 'GPO-head-3A' and following-sibling::text/@display-inline = 'yes-display-inline'">
				<p/>
				<span style="text-transform: capitalize;text-align:left">
					<xsl:value-of select="."/>
					<xsl:text>.— </xsl:text>
				</span>
			</xsl:when>
			<xsl:when test="$aReportHeaderStyle = 'GPO-head-3A'">
				<div style="text-transform: capitalize;text-align:left">
					<xsl:value-of select="."/>
				</div>
				<p/>
			</xsl:when>
			<xsl:when
				test="translate($aReportHeaderStyle, $upper, $lower) = 'caps-lowercase' and following-sibling::text/@display-inline = 'yes-display-inline'">
				<p/>
				<span style="text-transform: capitalize;text-align:left">
					<xsl:value-of select="."/>
					<xsl:text>.— </xsl:text>
				</span>
			</xsl:when>
			<xsl:when test="translate($aReportHeaderStyle, $upper, $lower) = 'caps-lowercase'">
				<div style="text-transform: capitalize;text-align:left">
					<xsl:value-of select="."/>
				</div>
				<p/>
			</xsl:when>
			<xsl:when
				test="$aReportHeaderStyle = 'GPO-head-4' and following-sibling::text/@display-inline = 'yes-display-inline'">
				<p/>
				<span class="lbexIndent" style="font:italic;text-transform: capitalize;">
					<i class="lbexTextNeutral">
						<xsl:value-of select="."/>
						<xsl:text>.</xsl:text>
					</i>
				</span>

			</xsl:when>
			<xsl:when test="$aReportHeaderStyle = 'GPO-head-4'">
				<div class="lbexIndent" style="font:italic;text-transform: capitalize;">
					<i class="lbexTextNeutral">
						<xsl:value-of select="."/>
					</i>
				</div>
				<p/>
			</xsl:when>
			<xsl:when
				test="$aReportHeaderStyle = 'GPO-head-5' and following-sibling::text/@display-inline = 'yes-display-inline'">
				<p/>
				<span class="lbexIndent" style="text-transform: capitalize;">
					<xsl:value-of select="."/>
					<xsl:text>.</xsl:text>
				</span>
			</xsl:when>
			<xsl:when test="$aReportHeaderStyle = 'GPO-head-5'">
				<div class="lbexIndent" style="text-transform: capitalize;">
					<xsl:value-of select="."/>
				</div>
				<p/>
			</xsl:when>
			<xsl:when test="$aReportHeaderStyle = 'OLC'">
				<div style="text-align:center">
					<xsl:if test="preceding-sibling::enum">
						<xsl:if test="ancestor::committee-report-part">
							<xsl:text>PART </xsl:text>
						</xsl:if>
						<xsl:value-of select="translate(preceding-sibling::enum, $lower, $upper)"/>
						<xsl:text>— </xsl:text>
					</xsl:if>
					<xsl:value-of select="translate(., $lower, $upper)"/>
				</div>
				<p/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="translate(., $lower, $upper)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ************* Committee Vote ************************************************ -->
	<xsl:template match="committee-vote">
		<xsl:variable name="theCommitteeName">
			<xsl:choose>
				<xsl:when test="@committee-vote-type">
					<xsl:value-of select="@committee-vote-type"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text/>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:variable>
		<xsl:call-template name="prinVoiceVoteTitle"/>
		<xsl:apply-templates select="committee-vote-num">
			<xsl:with-param name="voteType" select="@committee-vote-type"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="legis-data/legis-num" mode="committee-vote"/>
		<xsl:apply-templates select="legis-data/legis-desc" mode="committee-vote"/>
		<xsl:apply-templates select="action-date" mode="committee-report"/>

		<xsl:apply-templates select="action-desc" mode="committee-report">
			<xsl:with-param name="voteType" select="$theCommitteeName"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="vote-result">
			<xsl:with-param name="voteType" select="$theCommitteeName"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="vote-data">
			<xsl:with-param name="voteType" select="$theCommitteeName"/>
		</xsl:apply-templates>

		<!--//////////////////////////////-->
		<!--xsl:variable name="theCommitteeName">
			<xsl:choose>
				<xsl:when test="@committee-vote-type">
					<xsl:value-of select="@committee-vote-type"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text></xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			
		</xsl:variable>
		<xsl:apply-templates select="legis-data/legis-num" mode="committee-vote"/>
		<xsl:apply-templates select="legis-data/official-title" mode="committee-vote"/>
		<xsl:apply-templates select="legis-data/short-title" mode="committee-vote"/>
		<xsl:apply-templates select="committee-vote-num">
			<xsl:with-param name="voteType" select="$theCommitteeName"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="action-date" mode="committee-report">
			<xsl:with-param name="voteType" select="$theCommitteeName"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="action-desc" mode="committee-report">
			<xsl:with-param name="voteType" select="$theCommitteeName"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="legis-num" mode="committee-report">
			<xsl:with-param name="voteType" select="$theCommitteeName"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="short-title" mode="committee-vote">
			<xsl:with-param name="voteType" select="$theCommitteeName"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="motion">
			<xsl:with-param name="voteType" select="$theCommitteeName"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="vote-desc">
			<xsl:with-param name="voteType" select="$theCommitteeName"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="vote-result">
			<xsl:with-param name="voteType" select="$theCommitteeName"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="vote-data">
			<xsl:with-param name="voteType" select="$theCommitteeName"/>
		</xsl:apply-templates-->
	</xsl:template>

	<!-- Stabd alone vote printing -->
	<!-- Votes stand alone file -->
	<xsl:template match="legis-num" mode="committee-vote">
		<div style="text-align:center">
			<span style="font-variant: small-caps;">
				<xsl:value-of select="translate(., $upper, $lower)"/>
			</span>
		</div>
	</xsl:template>

	<!-- ************************Voice vote title******************************************** -->
	<xsl:template name="prinVoiceVoteTitle">
		<xsl:variable name="isVoceVote">
			<xsl:choose>
				<xsl:when
					test="contains(vote-result, 'voice vote') or contains(vote-result, 'withdrawn') or contains(vote-result, 'unanimous')">
					<xsl:text>Y</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>N</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="$isVoceVote = 'Y'">
			<div style="text-align:center" class="lbexSimplecap">voice vote</div>
			<br/>
		</xsl:if>
	</xsl:template>


	<xsl:template match="legis-desc" mode="committee-vote">
		<div class="lbexIndent" style="text-align:left">
			<xsl:value-of select="."/>
		</div>
	</xsl:template>


	<!-- ***********************Committee Vote Num ************************************************* -->
	<xsl:template match="committee-vote-num">
		<xsl:param name="voteType"/>
		<!--p/>		
		<xsl:choose>
			<xsl:when test="$voteType='HAP00'">
				<center style="font-variant: small-caps;" >
					<xsl:value-of select="."/>
				</center>
			</xsl:when>
			<xsl:when test="$voteType='PreviousVersionToKeep'">
				<i class="lbexTextNeutral">
					<xsl:text>Rules Committee record vote No.</xsl:text>
				</i>
				<xsl:value-of select="."/>
			</xsl:when>
			<xsl:otherwise>
				< build the committe on Rule vote style and mae it to be default Bug #1235 -->
		<xsl:variable name="isVoceVote">
			<xsl:choose>
				<xsl:when
					test="contains(parent::*/vote-result, 'voice vote') or contains(parent::*/vote-result, 'withdrawn') or contains(parent::*/vote-result, 'unanimous')">
					<xsl:text>Y</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>N</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="$isVoceVote = 'N'">
			<div class="lbexSimplecap" style="text-align:center">
				<xsl:value-of select="translate(., $upper, $lower)"/>
			</div>
		</xsl:if>
		<!--/xsl:otherwise>
		</xsl:choose-->
		<p/>
	</xsl:template>

	<!--************** Vote Action Date ***********************************************-->
	<xsl:template match="action-date" mode="committee-report">
		<xsl:param name="voteType"/>
		<!--xsl:choose>
			<xsl:when test="$voteType='HAP00' or  $voteType='PreviousVersionToKeep'">
				<xsl:call-template name="actualPrintVoteData">
					<xsl:with-param name="aGenLabel">
						<xsl:text></xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise-->
		<div class="lbexIndent" style="text-align:left">
			<xsl:value-of select="."/>
		</div>
		<!--/xsl:otherwise>
		</xsl:choose-->
	</xsl:template>

	<xsl:template match="action-desc" mode="committee-report">
		<xsl:param name="voteType"/>
		<!--xsl:choose>
			<xsl:when test="$voteType='HAP00' or  $voteType='PreviousVersionToKeep'">				
			</xsl:when>
			<xsl:otherwise-->
		<div class="lbexIndent" style="text-align:left">
			<xsl:variable name="sponsorName">
				<xsl:value-of select="sponsor"/>
			</xsl:variable>
			<xsl:variable name="sponsorNameWithSpace">
				<xsl:value-of select="concat(concat('  ', $sponsorName), '  ')"/>
			</xsl:variable>
			<xsl:variable name="textToPrintNoSpace">
				<xsl:value-of select="."/>
			</xsl:variable>
			<xsl:variable name="textToPrintWithSpaces">
				<xsl:value-of
					select="concat(concat(substring-before($textToPrintNoSpace, $sponsorName), $sponsorNameWithSpace), substring-after($textToPrintNoSpace, $sponsorName))"
				/>
			</xsl:variable>
			<xsl:value-of select="$textToPrintWithSpaces"/>

			<xsl:variable name="isVoceVote">
				<xsl:choose>
					<xsl:when
						test="contains(parent::*/vote-result, 'voice vote') or contains(parent::*/vote-result, 'withdrawn') or contains(parent::*/vote-result, 'unanimous')">
						<xsl:text>Y</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>N</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:if test="$isVoceVote = 'Y'">
				<xsl:text> </xsl:text>
				<xsl:value-of select="parent::*/vote-result"/>
			</xsl:if>
		</div>

	</xsl:template>

	<!--***************************** Vote Legis Num **********************************-->
	<xsl:template match="legis-num" mode="committee-report">
		<xsl:param name="voteType"/>
		<div style="font-variant: small-caps;text-align:center">
			<xsl:value-of select="."/>
		</div>
	</xsl:template>

	<!--***************************** short Title Committee Vote **********************************-->
	<xsl:template match="short-title" mode="committee-vote">
		<xsl:param name="voteType"/>
		<xsl:choose>
			<xsl:when test="$voteType = 'HAP00'">
				<xsl:call-template name="actualPrintVoteData">
					<xsl:with-param name="aGenLabel">
						<xsl:text>Measure: </xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- nothing -->
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>
	<!--***************************** Motion  **********************************-->
	<xsl:template match="motion">
		<xsl:param name="voteType"/>
		<xsl:choose>
			<xsl:when test="$voteType = 'HAP00'">
				<xsl:call-template name="actualPrintVoteData">
					<xsl:with-param name="aGenLabel">
						<xsl:text>Motion by:</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- Nothing -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--***************************** Vote Desc **********************************-->
	<xsl:template match="vote-desc">
		<xsl:param name="voteType"/>
		<xsl:choose>
			<xsl:when test="$voteType = 'HAP00'">
				<xsl:call-template name="actualPrintVoteData">
					<xsl:with-param name="aGenLabel">
						<xsl:text>Description of motion: </xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$voteType = 'someOtherCommittee Developed before'">
				<xsl:call-template name="actualPrintVoteData">
					<xsl:with-param name="aGenLabel">
						<xsl:text>Summary of motion:</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- nothing -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--***************************** Vote Result **********************************-->
	<xsl:template match="vote-result">
		<xsl:param name="voteType"/>
		<!--xsl:choose>
			<xsl:when test="$voteType='HAP00' or  $voteType='PreviousVersionToKeep'">
				<xsl:call-template name="actualPrintVoteData">
					<xsl:with-param name="aGenLabel">
						<xsl:text>Results:</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise-->
		<xsl:variable name="isVoceVote">
			<xsl:choose>
				<xsl:when
					test="contains(., 'voice vote') or contains(., 'withdrawn') or contains(., 'unanimous')">
					<xsl:text>Y</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>N</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$isVoceVote = 'Y'">
				<!--xsl:text> </xsl:text>
				<xsl:value-of select="."/-->
			</xsl:when>
			<xsl:otherwise>
				<div class="lbexIndent" style="text-align:left">
					<xsl:value-of select="."/>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--***************************** Vote Data**********************************-->
	<xsl:template match="vote-data">
		<xsl:param name="voteType"/>
		<xsl:variable name="isPrintPresent">
			<xsl:choose>
				<xsl:when test="ancestor::committee-vote/@display-present">
					<xsl:value-of select="ancestor::committee-vote/@display-present"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="isPrintNotVoting">
			<xsl:choose>
				<xsl:when test="ancestor::committee-vote/@display-not-voting">
					<xsl:value-of select="ancestor::committee-vote/@display-not-voting"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="allColSpan">
			<xsl:choose>
				<xsl:when test="$isPrintPresent = 'yes' and $isPrintNotVoting = 'yes'">
					<xsl:text>10</xsl:text>
				</xsl:when>
				<xsl:when test="$isPrintPresent = 'yes' and $isPrintNotVoting != 'yes'">
					<xsl:text>8</xsl:text>
				</xsl:when>
				<xsl:when test="$isPrintPresent != 'yes' and $isPrintNotVoting = 'yes'">
					<xsl:text>8</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>6</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="halfColSpan">
			<xsl:choose>
				<xsl:when test="$isPrintPresent = 'yes' and $isPrintNotVoting = 'yes'">
					<xsl:text>5</xsl:text>
				</xsl:when>
				<xsl:when test="$isPrintPresent = 'yes' and $isPrintNotVoting != 'yes'">
					<xsl:text>4</xsl:text>
				</xsl:when>
				<xsl:when test="$isPrintPresent != 'yes' and $isPrintNotVoting = 'yes'">
					<xsl:text>4</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>3</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="memberColWidth">
			<xsl:choose>
				<xsl:when test="$isPrintPresent = 'yes' and $isPrintNotVoting = 'yes'">
					<xsl:text>26%</xsl:text>
				</xsl:when>
				<xsl:when test="$isPrintPresent = 'yes' and $isPrintNotVoting != 'yes'">
					<xsl:text>32%</xsl:text>
				</xsl:when>
				<xsl:when test="$isPrintPresent != 'yes' and $isPrintNotVoting = 'yes'">
					<xsl:text>32%</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>38%</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="internalMemberColWidth">
			<xsl:choose>
				<xsl:when test="$isStandAloneVote = 'yes'">
					<xsl:choose>
						<xsl:when test="$isPrintPresent = 'yes' and $isPrintNotVoting = 'yes'">
							<xsl:text>50%</xsl:text>
						</xsl:when>
						<xsl:when test="$isPrintPresent = 'yes' and $isPrintNotVoting != 'yes'">
							<xsl:text>62%</xsl:text>
						</xsl:when>
						<xsl:when test="$isPrintPresent != 'yes' and $isPrintNotVoting = 'yes'">
							<xsl:text>63%</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>75%</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$memberColWidth"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<table style="width:100%" class="lbexVotesStyle">
			<tr>
				<td>
					<xsl:attribute name="colspan">
						<xsl:value-of select="$allColSpan"/>
					</xsl:attribute>

					<hr/>
				</td>
			</tr>
			<tr>
				<td style="text-align:center">
					<xsl:attribute name="width">
						<xsl:value-of select="$memberColWidth"/>
					</xsl:attribute>
					<xsl:text>Member</xsl:text>
				</td>
				<td class="lbexTdStyleFour">
					<xsl:text>Yea</xsl:text>
				</td>
				<td class="lbexTdStyleFour">
					<xsl:text>Nay</xsl:text>
				</td>
				<xsl:if test="$isPrintPresent = 'yes'">
					<td class="lbexTdStyleFour">
						<xsl:text>Present</xsl:text>
					</td>
				</xsl:if>
				<xsl:if test="$isPrintNotVoting = 'yes'">
					<td class="lbexTdStyleFour">
						<xsl:text>Not Voting</xsl:text>
					</td>
				</xsl:if>
				<td style="text-align:center;">
					<xsl:attribute name="width">
						<xsl:value-of select="$memberColWidth"/>
					</xsl:attribute>
					<xsl:text>Member</xsl:text>
				</td>
				<td class="lbexTdStyleFour">
					<xsl:text>Yea</xsl:text>
				</td>
				<td class="lbexTdStyleFour">
					<xsl:text>Nay</xsl:text>
				</td>
				<xsl:if test="$isPrintPresent = 'yes'">
					<td class="lbexTdStyleFour">
						<xsl:text>Present</xsl:text>
					</td>
				</xsl:if>
				<xsl:if test="$isPrintNotVoting = 'yes'">
					<td class="lbexTdStyleFour">
						<xsl:text>Not Voting</xsl:text>
					</td>
				</xsl:if>
			</tr>
			<tr>
				<td>
					<xsl:attribute name="colspan">
						<xsl:value-of select="$allColSpan"/>
					</xsl:attribute>
					<hr/>
				</td>
			</tr>
			<tr>
				<td valign="top">
					<xsl:attribute name="colspan">
						<xsl:value-of select="$halfColSpan"/>
					</xsl:attribute>
					<table class="lbexGeneralStyle100" width="100%">
						<xsl:choose>
							<xsl:when
								test="ancestor-or-self::committee-vote/@display-method = 'no-party'">
								<xsl:call-template name="actualInserLeftColumnVotes">
									<xsl:with-param name="isPrintPresent" select="$isPrintPresent"/>
									<xsl:with-param name="isPrintNotVoting"
										select="$isPrintNotVoting"/>
									<xsl:with-param name="committeeName" select="$voteType"/>
									<xsl:with-param name="memberColWidth"
										select="$internalMemberColWidth"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="actualInsertMajorityVotes">
									<xsl:with-param name="isPrintPresent" select="$isPrintPresent"/>
									<xsl:with-param name="isPrintNotVoting"
										select="$isPrintNotVoting"/>
									<xsl:with-param name="committeeName" select="$voteType"/>
									<xsl:with-param name="memberColWidth"
										select="$internalMemberColWidth"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</table>
				</td>
				<td valign="top">
					<xsl:attribute name="colspan">
						<xsl:value-of select="$halfColSpan"/>
					</xsl:attribute>
					<table class="lbexGeneralStyle100" width="100%">
						<xsl:choose>
							<xsl:when
								test="ancestor-or-self::committee-vote/@display-method = 'no-party'">
								<xsl:call-template name="actualInserRightColumnVotes">
									<xsl:with-param name="isPrintPresent" select="$isPrintPresent"/>
									<xsl:with-param name="isPrintNotVoting"
										select="$isPrintNotVoting"/>
									<xsl:with-param name="committeeName" select="$voteType"/>
									<xsl:with-param name="memberColWidth"
										select="$internalMemberColWidth"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="actualInsertMinorityVotes">
									<xsl:with-param name="isPrintPresent" select="$isPrintPresent"/>
									<xsl:with-param name="isPrintNotVoting"
										select="$isPrintNotVoting"/>
									<xsl:with-param name="committeeName" select="$voteType"/>
									<xsl:with-param name="memberColWidth"
										select="$internalMemberColWidth"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</table>
				</td>
			</tr>
			<tr>
				<xsl:call-template name="insertTotalsLine">
					<xsl:with-param name="isPrintPresent" select="$isPrintPresent"/>
					<xsl:with-param name="isPrintNotVoting" select="$isPrintNotVoting"/>
					<xsl:with-param name="memberColWidth" select="$internalMemberColWidth"/>
					<xsl:with-param name="allColSpan" select="$halfColSpan"/>
				</xsl:call-template>
			</tr>
			<tr>
				<td>
					<xsl:attribute name="colspan">
						<xsl:value-of select="$allColSpan"/>
					</xsl:attribute>
					<hr/>
				</td>
			</tr>
		</table>

		<!--/xsl:otherwise>			
		</xsl:choose-->
	</xsl:template>

	<xsl:template name="actualInserLeftColumnVotes">
		<xsl:param name="isPrintPresent"/>
		<xsl:param name="isPrintNotVoting"/>
		<xsl:param name="committeeName"/>
		<xsl:param name="memberColWidth"/>

		<xsl:variable name="votesCount">
			<xsl:value-of select="count(recorded-vote)"/>
		</xsl:variable>

		<xsl:variable name="halfOfTotalVotesCount">
			<xsl:choose>
				<xsl:when test="floor((number($votesCount) div 2)) * 2 = $votesCount">
					<xsl:value-of select="(number($votesCount) div 2)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="floor(number(($votesCount) div 2)) + 1"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:for-each select="recorded-vote">
			<xsl:if
				test="position() &lt; $halfOfTotalVotesCount or position() = $halfOfTotalVotesCount">
				<xsl:call-template name="actualPrintVoteResultForNonRules">
					<xsl:with-param name="isPrintPresent" select="$isPrintPresent"/>
					<xsl:with-param name="isPrintNotVoting" select="$isPrintNotVoting"/>
					<xsl:with-param name="memberColWidth" select="$memberColWidth"/>
					<xsl:with-param name="isPrintNoParty">yes</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="actualInserRightColumnVotes">
		<xsl:param name="isPrintPresent"/>
		<xsl:param name="isPrintNotVoting"/>
		<xsl:param name="committeeName"/>
		<xsl:param name="memberColWidth"/>

		<xsl:variable name="votesCount">
			<xsl:value-of select="count(recorded-vote)"/>
		</xsl:variable>

		<xsl:variable name="halfOfTotalVotesCount">
			<xsl:choose>
				<xsl:when test="floor((number($votesCount) div 2)) * 2 = $votesCount">
					<xsl:value-of select="(number($votesCount) div 2)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="floor(number(($votesCount) div 2)) + 1"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:for-each select="recorded-vote">
			<xsl:if test="position() &gt; $halfOfTotalVotesCount">
				<xsl:call-template name="actualPrintVoteResultForNonRules">
					<xsl:with-param name="isPrintPresent" select="$isPrintPresent"/>
					<xsl:with-param name="isPrintNotVoting" select="$isPrintNotVoting"/>
					<xsl:with-param name="memberColWidth" select="$memberColWidth"/>
					<xsl:with-param name="isPrintNoParty">yes</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="insertTotalsLine">
		<xsl:param name="isPrintPresent"/>
		<xsl:param name="isPrintNotVoting"/>
		<xsl:param name="memberColWidth"/>
		<xsl:param name="allColSpan"/>
		<xsl:variable name="emptyColumnWidth">
			<xsl:choose>
				<xsl:when test="$isPrintPresent = 'yes' and $isPrintNotVoting = 'yes'">
					<xsl:value-of
						select="concat(number(substring-before($memberColWidth, '%')) + 12, '%')"/>
				</xsl:when>
				<xsl:when test="$isPrintPresent = 'yes' or $isPrintNotVoting = 'yes'">
					<xsl:value-of
						select="concat(number(substring-before($memberColWidth, '%')) + 6, '%')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$memberColWidth"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="ancestor::committee-vote/totals-by-vote/@display = 'yes'">
			<tr>
				<!-- First insert the line -->

				<td>
					<xsl:attribute name="width">
						<xsl:value-of select="$emptyColumnWidth"/>
					</xsl:attribute>
					<xsl:attribute name="colspan">
						<xsl:value-of select="number($allColSpan)"/>
					</xsl:attribute>
				</td>
				<td>
					<xsl:attribute name="colspan">
						<xsl:value-of select="number($allColSpan)"/>
					</xsl:attribute>
					<hr class="lbexGeneralStyle100"/>
				</td>
			</tr>
			<!--the actual totals-->

			<tr>
				<td>
					<xsl:attribute name="width">
						<xsl:value-of select="$emptyColumnWidth"/>
					</xsl:attribute>
					<xsl:attribute name="colspan">
						<xsl:value-of select="number($allColSpan)"/>
					</xsl:attribute>
				</td>
				<td style="text-align:left">
					<xsl:attribute name="width">
						<xsl:value-of select="$memberColWidth"/>
					</xsl:attribute>
					<b>
						<xsl:text>Vote Total:</xsl:text>
					</b>
				</td>
				<td class="lbexTdStyleFour">
					<b>
						<xsl:value-of select="ancestor::committee-vote/totals-by-vote/yea-total"/>
					</b>
				</td>
				<td class="lbexTdStyleFour">
					<b>
						<xsl:value-of select="ancestor::committee-vote/totals-by-vote/nay-total"/>
					</b>
				</td>
				<xsl:if test="$isPrintPresent = 'yes'">
					<td class="lbexTdStyleFour">
						<b>
							<xsl:value-of
								select="ancestor::committee-vote/totals-by-vote/present-total"/>
						</b>
					</td>
				</xsl:if>
				<xsl:if test="$isPrintNotVoting = 'yes'">
					<td class="lbexTdStyleFour">
						<b>
							<xsl:value-of
								select="ancestor::committee-vote/totals-by-vote/not-voting-total"/>
						</b>
					</td>
				</xsl:if>
			</tr>
		</xsl:if>
	</xsl:template>

	<xsl:template name="actualInsertMajorityVotes">
		<xsl:param name="isPrintPresent"/>
		<xsl:param name="isPrintNotVoting"/>
		<xsl:param name="committeeName"/>
		<xsl:param name="memberColWidth"/>

		<xsl:for-each select="recorded-vote">
			<xsl:variable name="isTheVoteMajority">
				<xsl:call-template name="isVoteMajority"/>
			</xsl:variable>
			<!-- commented condition that prints rules committee differently -->
			<!--xsl:if test="$isTheVoteMajority='yes' and $committeeName='HRU00'">
				<xsl:call-template name="actualPrintVoteResultForRules"/>
			</xsl:if-->
			<!--xsl:if test="$isTheVoteMajority='yes' and $committeeName !='HRU00'"-->
			<xsl:if test="$isTheVoteMajority = 'yes'">
				<xsl:call-template name="actualPrintVoteResultForNonRules">
					<xsl:with-param name="isPrintPresent" select="$isPrintPresent"/>
					<xsl:with-param name="isPrintNotVoting" select="$isPrintNotVoting"/>
					<xsl:with-param name="memberColWidth" select="$memberColWidth"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="actualInsertMinorityVotes">
		<xsl:param name="isPrintPresent"/>
		<xsl:param name="isPrintNotVoting"/>
		<xsl:param name="committeeName"/>
		<xsl:param name="memberColWidth"/>

		<xsl:for-each select="recorded-vote">
			<xsl:variable name="isTheVoteMajority">
				<xsl:call-template name="isVoteMajority"/>
			</xsl:variable>
			<!-- commented condition that prints Rules Committee differently -->
			<!--xsl:if test="$isTheVoteMajority='no' and $committeeName='HRU00'">
				<xsl:call-template name="actualPrintVoteResultForRules"/>
			</xsl:if-->
			<!--xsl:if test="$isTheVoteMajority='no' and $committeeName !='HRU00'"-->
			<xsl:if test="$isTheVoteMajority = 'no'">
				<xsl:call-template name="actualPrintVoteResultForNonRules">
					<xsl:with-param name="isPrintPresent" select="$isPrintPresent"/>
					<xsl:with-param name="isPrintNotVoting" select="$isPrintNotVoting"/>
					<xsl:with-param name="memberColWidth" select="$memberColWidth"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="convertTheRole">
		<xsl:param name="aRoleValue"/>
		<xsl:choose>
			<xsl:when test="$aRoleValue = 'legislator'">
				<xsl:text>Legislator</xsl:text>
			</xsl:when>
			<xsl:when test="$aRoleValue = 'chairman'">
				<xsl:text>Chairman</xsl:text>
			</xsl:when>
			<xsl:when test="$aRoleValue = 'speaker'">
				<xsl:text>Speaker</xsl:text>
			</xsl:when>
			<xsl:when test="$aRoleValue = 'vice-chairman'">
				<xsl:text>Vice Chairman</xsl:text>
			</xsl:when>
			<xsl:when test="$aRoleValue = 'ranking-member'">
				<xsl:text>Ranking Member</xsl:text>
			</xsl:when>
			<xsl:when test="$aRoleValue = 'ranking'">
				<xsl:text>Ranking Member</xsl:text>
			</xsl:when>
			<xsl:when test="$aRoleValue = 'acting-chair'">
				<xsl:text>Acting Chair</xsl:text>
			</xsl:when>
			<xsl:when test="$aRoleValue = 'acting-vice-chair'">
				<xsl:text>Acting Vice Chair</xsl:text>
			</xsl:when>
			<xsl:when test="$aRoleValue = 'chair'">
				<xsl:text>Chair</xsl:text>
			</xsl:when>
			<xsl:when test="$aRoleValue = 'chair-emeritus'">
				<xsl:text>Chair Emeritus</xsl:text>
			</xsl:when>
			<xsl:when test="$aRoleValue = 'chairperson'">
				<xsl:text>Chairperson</xsl:text>
			</xsl:when>
			<xsl:when test="$aRoleValue = 'chairwoman'">
				<xsl:text>Chairwoman</xsl:text>
			</xsl:when>
			<xsl:when test="$aRoleValue = 'co-chair'">
				<xsl:text>Co-Chair</xsl:text>
			</xsl:when>
			<xsl:when test="$aRoleValue = 'ex-officio'">
				<xsl:text>Ex Officio</xsl:text>
			</xsl:when>
			<xsl:when test="$aRoleValue = 'vice-chair'">
				<xsl:text>Vice Chair</xsl:text>
			</xsl:when>
			<xsl:when test="$aRoleValue = 'vice-chairwoman'">
				<xsl:text>Vice Chairwoman</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$aRoleValue"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="actualPrintVoteResultForNonRules">
		<xsl:param name="isPrintPresent"/>
		<xsl:param name="isPrintNotVoting"/>
		<xsl:param name="memberColWidth"/>
		<xsl:param name="isPrintNoParty"/>

		<xsl:variable name="isTheVoteMajority">
			<xsl:call-template name="isVoteMajority"/>
		</xsl:variable>

		<xsl:variable name="isPrintItalic">
			<xsl:choose>
				<xsl:when test="$isPrintNoParty = 'yes' and $isTheVoteMajority = 'no'">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>


		<tr valign="top">
			<td>
				<xsl:attribute name="width">
					<xsl:value-of select="$memberColWidth"/>
				</xsl:attribute>
				<xsl:if test="$isPrintItalic = 'yes'">
					<xsl:attribute name="style">
						<xsl:text>font-style:italic;</xsl:text>
					</xsl:attribute>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="not(child::*)">
						<xsl:value-of select="legislator"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="legislator"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="legislator/@role != 'legislator'">
						<xsl:text>, </xsl:text>
						<xsl:variable name="theRole">
							<xsl:call-template name="convertTheRole">
								<xsl:with-param name="aRoleValue" select="legislator/@role"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:value-of select="$theRole"/>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="vote != ''">
					<xsl:call-template name="loop">
						<xsl:with-param name="index">
							<xsl:value-of
								select="70 - string-length(legislator) - string-length(legislator/@role)"
							/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</td>
			<xsl:variable name="theColSizeClass">
				<xsl:choose>
					<xsl:when test="$isStandAloneVote = 'yes'">
						<xsl:text>lbexTdStyleFourStAlone</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>lbexTdStyleFour</xsl:text>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:variable>
			<xsl:choose>
				<xsl:when test="translate(vote, $upper, $lower) = 'yea'">
					<td>
						<xsl:attribute name="class">
							<xsl:value-of select="$theColSizeClass"/>
						</xsl:attribute>
						<xsl:text>X</xsl:text>
					</td>
					<!--td class="lbexTdStyleSeven"-->
					<td>
						<xsl:attribute name="class">
							<xsl:value-of select="$theColSizeClass"/>
						</xsl:attribute>
					</td>
					<xsl:if test="$isPrintPresent = 'yes'">
						<!--td class="lbexTdStyleSeven"-->
						<td>
							<xsl:attribute name="class">
								<xsl:value-of select="$theColSizeClass"/>
							</xsl:attribute>
						</td>
					</xsl:if>
					<xsl:if test="$isPrintNotVoting = 'yes'">
						<!--td class="lbexTdStyleSeven" -->
						<td>
							<xsl:attribute name="class">
								<xsl:value-of select="$theColSizeClass"/>
							</xsl:attribute>
						</td>
					</xsl:if>
				</xsl:when>
				<xsl:when test="translate(vote, $upper, $lower) = 'nay'">
					<!--td class="lbexTdStyleSeven"-->
					<td>
						<xsl:attribute name="class">
							<xsl:value-of select="$theColSizeClass"/>
						</xsl:attribute>
					</td>
					<td>
						<xsl:attribute name="class">
							<xsl:value-of select="$theColSizeClass"/>
						</xsl:attribute>
						<xsl:text>X</xsl:text>
					</td>
					<xsl:if test="$isPrintPresent = 'yes'">
						<!--td class="lbexTdStyleSeven" -->
						<td>
							<xsl:attribute name="class">
								<xsl:value-of select="$theColSizeClass"/>
							</xsl:attribute>
						</td>
					</xsl:if>
					<xsl:if test="$isPrintNotVoting = 'yes'">
						<!--td class="lbexTdStyleSeven" -->
						<td>
							<xsl:attribute name="class">
								<xsl:value-of select="$theColSizeClass"/>
							</xsl:attribute>
						</td>
					</xsl:if>
				</xsl:when>
				<xsl:when test="translate(vote, $upper, $lower) = 'present'">
					<!--td class="lbexTdStyleSeven"-->
					<td>
						<xsl:attribute name="class">
							<xsl:value-of select="$theColSizeClass"/>
						</xsl:attribute>
					</td>
					<!--td class="lbexTdStyleSeven"-->
					<td>
						<xsl:attribute name="class">
							<xsl:value-of select="$theColSizeClass"/>
						</xsl:attribute>
					</td>
					<xsl:if test="$isPrintPresent = 'yes'">
						<td>
							<xsl:attribute name="class">
								<xsl:value-of select="$theColSizeClass"/>
							</xsl:attribute>
							<xsl:text>X</xsl:text>
						</td>
					</xsl:if>
					<xsl:if test="$isPrintNotVoting = 'yes'">
						<!--td class="lbexTdStyleSeven"-->
						<td>
							<xsl:attribute name="class">
								<xsl:value-of select="$theColSizeClass"/>
							</xsl:attribute>
						</td>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<!--td class="lbexTdStyleSeven"-->
					<td>
						<xsl:attribute name="class">
							<xsl:value-of select="$theColSizeClass"/>
						</xsl:attribute>
					</td>
					<!--td class="lbexTdStyleSeven"-->
					<td>
						<xsl:attribute name="class">
							<xsl:value-of select="$theColSizeClass"/>
						</xsl:attribute>
					</td>
					<xsl:if test="$isPrintPresent = 'yes'">
						<!--td class="lbexTdStyleSeven"-->
						<td>
							<xsl:attribute name="class">
								<xsl:value-of select="$theColSizeClass"/>
							</xsl:attribute>
						</td>
					</xsl:if>
					<xsl:if test="$isPrintNotVoting = 'yes'">
						<td>
							<xsl:attribute name="class">
								<xsl:value-of select="$theColSizeClass"/>
							</xsl:attribute>
							<xsl:text>X</xsl:text>
						</td>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</tr>
	</xsl:template>


	<xsl:template name="actualPrintVoteResultForRules">
		<tr valign="top">
			<td style="width:80%">
				<xsl:value-of select="legislator"/>
				<xsl:if test="vote != ''">
					<xsl:call-template name="loop">
						<xsl:with-param name="index">30</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</td>
			<td style="width:20%">
				<xsl:value-of select="vote"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template name="getCurrentMajorityParty">
		<!--xsl:variable name="theCongressValueInDoc">
			<xsl:value-of select="translate(//congress,$upper, $lower)"/>
		</xsl:variable>
		<xsl:variable name="congressValue">
			<xsl:choose>
				<xsl:when test="contains($theCongressValueInDoc, 'th')">
					<xsl:value-of select="substring-before($theCongressValueInDoc, 'th')"/>
				</xsl:when>
				<xsl:when test="contains($theCongressValueInDoc, 'nd')">
					<xsl:value-of select="substring-before($theCongressValueInDoc, 'nd')"/>
				</xsl:when>
				<xsl:when test="contains($theCongressValueInDoc, 'rd')">
					<xsl:value-of select="substring-before($theCongressValueInDoc, 'rd')"/>
				</xsl:when>
				<xsl:otherwise>					
					<xsl:value-of select="$theCongressValueInDoc"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable-->
		<!-- TB Jan2015 bug fixing #1373 -->
		<xsl:choose>
			<!--xsl:when test="contains(translate(//current-chamber, $upper,$lower), 'senate')">				
				<xsl:choose>
					<xsl:when test="number($congressValue) &lt;= 113">
						<xsl:text>D</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>R</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				
				</xsl:when-->
			<xsl:when test="//legislator[@role = 'chairman']">
				<xsl:value-of select="//legislator[@role = 'chairman']/@party"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- not it is R for Senate and R for the House - but this case should not happen - the case above must always work -->
				<xsl:text>R</xsl:text>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="isVoteMajority">
		<!-- TB Nov2011 this variable must be set to be R in case if Republican are majority in the House or D - in case if Democrats. -->
		<xsl:variable name="currentMajorityParty">
			<xsl:call-template name="getCurrentMajorityParty"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="legislator/@party = $currentMajorityParty">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--*************Print Legislators and vote of each one************************-->
	<xsl:template name="printLegislators">
		<xsl:variable name="votesTotalNumber" select="count(recorded-vote)"/>
		<xsl:for-each select="recorded-vote">
			<xsl:text>  </xsl:text>
			<xsl:value-of select="legislator"/>
			<xsl:text>— </xsl:text>
			<xsl:value-of select="vote"/>
			<xsl:variable name="isLastLegistlator">
				<xsl:choose>
					<xsl:when test="position() = $votesTotalNumber">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>false</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="$isLastLegistlator = 'true'">
					<xsl:text>.</xsl:text>
					<p/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>; </xsl:text>
				</xsl:otherwise>
			</xsl:choose>


		</xsl:for-each>
	</xsl:template>

	<!-- *******************List of legisltator to be printed in the table ********************* -->
	<xsl:template name="listLegistlators">
		<xsl:param name="voted"/>
		<xsl:for-each select="recorded-vote">
			<xsl:if test="translate(vote, $upper, $lower) = $voted">
				<tr>
					<td style="font-size:13pt">
						<xsl:value-of select="legislator"/>
					</td>
				</tr>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!--*************************General Vote printing by committee ID **********************-->
	<xsl:template name="actualPrintVoteData">
		<xsl:param name="aGenLabel"/>
		<xsl:choose>
			<xsl:when test="$committeeID = 'CommitteeCustomization'">
				<!-- place to insert specific rules by comitee ID -->
			</xsl:when>
			<xsl:otherwise>

				<div class="lbexIndent">
					<xsl:value-of select="$aGenLabel"/>
					<xsl:text>  </xsl:text>
					<xsl:value-of select="."/>
					<xsl:text>.</xsl:text>
				</div>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="IdReferenceExists">
		<xsl:param name="currentID"/>
		<xsl:choose>
			<xsl:when test="//bill">
				<xsl:choose>
					<xsl:when test="/bill/descendant::*/@idref = $currentID">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>no</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="//resolution">
				<xsl:choose>
					<xsl:when test="//resolution/descendant::*/@idref = $currentID">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>no</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="//amendment-doc">
				<xsl:choose>
					<xsl:when test="//amendment-doc/descendant::*/@idref = $currentID">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>no</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="//committee-report">
				<xsl:choose>
					<xsl:when test="//committee-report/descendant::*/@idref = $currentID">
						<xsl:text>yes</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>no</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="ApplyTemplWithSimpleIndentP">
				<p style="text-align:left" class="lbexIndent">
			<xsl:if test="@commented = 'yes' ">
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
			</xsl:if>
							<xsl:if
				test="((contains(@reported-display-style,'brackets')and (not(@changed) or@changed != 'not-changed') and not(contains(ancestor::*/@reported-display-style,'brackets'))) or(not(@reported-display-style) and (not(@changed) or@changed != 'not-changed') and contains(ancestor::*/@reported-display-style,'brackets'))) and local-name() != 'list'">
				<xsl:choose>
						<xsl:when test = "(not(@reported-display-style) and (not(@changed) or@changed != 'not-changed') and contains(ancestor::*/@reported-display-style,'brackets'))and local-name() != 'list' and local-name() ='quoted-block' ">
							<xsl:text></xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="openBracketStyles"/>	
						</xsl:otherwise>
					</xsl:choose>
			</xsl:if>
			<xsl:apply-templates/>
			<xsl:if test="@commented = 'yes'">
				<xsl:choose>
					<xsl:when test="child::text">
						<xsl:text></xsl:text>
					</xsl:when>
				<xsl:otherwise>
						<span class="lbexBrakets">
							<xsl:text>]</xsl:text>
						</span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		<xsl:variable name="isToCloseTheBrackets">
				<xsl:call-template name="toCloseTheBrakets"/>
			</xsl:variable>
			<xsl:if test=" (((contains(@reported-display-style,'brackets') and (not(@changed) or@changed != 'not-changed') and not(contains(ancestor::*/@reported-display-style,'brackets'))) or(not(@reported-display-style) and (not(@changed) or@changed != 'not-changed')  and contains(ancestor::*/@reported-display-style,'brackets') ) and $isToCloseTheBrackets ='yes')) and local-name() != 'list'">
				<xsl:choose>
						<xsl:when test = "(not(@reported-display-style) and (not(@changed) or@changed != 'not-changed') and contains(ancestor::*/@reported-display-style,'brackets'))and local-name() != 'list' and local-name() ='quoted-block' ">
							<xsl:text></xsl:text>
						</xsl:when>
						<xsl:when test="child::text">
					<xsl:text></xsl:text>
				</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="closedBracketStyles"/>		
						</xsl:otherwise>
					</xsl:choose>	
			</xsl:if>
		</p>
	</xsl:template>

	<xsl:template name="printHeaderParagraphAndLower">
		<xsl:variable name="indentLevel">
			<xsl:call-template name="defineIndentation">
				<xsl:with-param name="aLevelElement" select="local-name(parent::*)"/>
				<xsl:with-param name="aUseParent">true</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="firstLetter" select="substring(., 1, 1)"/>
		<xsl:choose>
			<xsl:when test="$indentLevel = 'lbexIndentSubsection'">
				<span class="lbexSectionTitleTrad">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="not(child::*) and not(contains(string($number), $firstLetter))">
				<span style="font-size:110%; text-transform: capitalize ">
					<xsl:value-of select="$firstLetter"/>
				</span>
				<xsl:value-of select="translate(substring(., 2), $lower, $upper)"/>
			</xsl:when>
			<xsl:otherwise>
				<span class="lbexSmallText">
					<!--xsl:apply-templates/-->
					<xsl:call-template name="printCompHeader"/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="printActionDateForBills">
		<xsl:if
			test="(translate($documentStage, $upper, $lower) = 'engrossed-in-senate' or translate($documentStage, $upper, $lower) = 'engrossed-amendment-senate') and (//bill/@public-print = 'yes' or //resolution/@public-print = 'yes')">
			<xsl:for-each select="//form/action">
				<xsl:choose>
					<xsl:when
						test="(position() = last() and count(//form/action) > 1) or (count(//form/action) = 1) or not(@display = 'yes')">
						<!-- nothing - not to print it is printed above -->
					</xsl:when>
					<xsl:otherwise>
						<div style="text-align:center">
							<p/>
							<span class="lbexSimplecap">
								<xsl:value-of
									select="substring-before(., substring-before(substring-after(action-date, '('), ')'))"
								/>
							</span>
							<xsl:value-of
								select="substring-before(substring-after(action-date, '('), ',')"/>
							<span class="lbexSimplecap">
								<xsl:text>, </xsl:text>
								<xsl:value-of
									select="substring-before(substring-after(action-date, ','), ')')"/>
								<xsl:value-of
									select="substring-after(action-date, substring-before(substring-after(action-date, '('), ')'))"
								/>
							</span>
							<p/>
							<xsl:if test="action-desc and not(action-desc/@display = 'no')">
								<p>
									<xsl:value-of select="action-desc"/>
								</p>
							</xsl:if>
						</div>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	<!-- TB 11-Dec-2008 -->
	<xsl:template match="associated-doc">
		<p style="text-align:center" class="lbexSectionlevelOLCBold">
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="associated-doc" mode="Endorsement">
		<div style="text-align:center" class="lbexEndsmtHead">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="quoted-block-continuation-text">
		<xsl:call-template name="ContinuationText"/>
	</xsl:template>

	<!-- Rules implamentation -->
	<xsl:template match="rule">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="rules-clause">
		<xsl:choose>
			<xsl:when test="@display-inline = 'yes-display-inline'">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="preceding-sibling::rules-clause/@display-inline = 'yes-display-inline'">
				<div>
					<xsl:apply-templates/>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="indentLevel">
					<xsl:call-template name="defineIndentForRules">
						<xsl:with-param name="aLevelElement">clause</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<div>

					<xsl:attribute name="class">
						<xsl:value-of select="$indentLevel"/>
					</xsl:attribute>

					<xsl:apply-templates/>

				</div>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!-- new template - bug fixing 1202 TB May2011 -->
	<xsl:template match="rules-clause-header">




		<xsl:choose>
			<xsl:when test="not(following-sibling::*[1]/@display-inline = 'yes-display-inline')">
				<div style="font-weight: bold;text-indent: 0em;">
					<xsl:if
						test="ancestor::quoted-block and not(@display-inline = 'yes-display-inline')">
						<xsl:text>“</xsl:text>
					</xsl:if>
					<xsl:apply-templates/>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<span style="font-weight: bold;">
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>





	</xsl:template>

	<xsl:template match="rules-paragraph">
		<xsl:choose>
			<xsl:when test="@display-inline = 'yes-display-inline'">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::rules-paragraph/@display-inline = 'yes-display-inline'">
				<div>
					<xsl:apply-templates/>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="indentLevel">
					<xsl:call-template name="defineIndentForRules">
						<xsl:with-param name="aLevelElement">paragraph</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<div>
					<xsl:attribute name="class">
						<xsl:value-of select="$indentLevel"/>
					</xsl:attribute>

					<xsl:apply-templates/>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="rules-subparagraph">
		<xsl:choose>
			<xsl:when test="@display-inline = 'yes-display-inline'">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::rules-subparagraph/@display-inline = 'yes-display-inline'">
				<div>
					<xsl:apply-templates/>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="indentLevel">
					<xsl:call-template name="defineIndentForRules">
						<xsl:with-param name="aLevelElement">subparagraph</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<div>
					<xsl:attribute name="class">
						<xsl:value-of select="$indentLevel"/>
					</xsl:attribute>

					<xsl:apply-templates/>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="rules-subdivision">
		<xsl:choose>
			<xsl:when test="@display-inline = 'yes-display-inline'">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when
				test="preceding-sibling::rules-subdivision/@display-inline = 'yes-display-inline'">
				<div>
					<xsl:apply-templates/>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="indentLevel">
					<xsl:call-template name="defineIndentForRules">
						<xsl:with-param name="aLevelElement">subdivision</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<div>
					<xsl:attribute name="class">
						<xsl:value-of select="$indentLevel"/>
					</xsl:attribute>

					<xsl:apply-templates/>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="rules-item">
		<xsl:choose>
			<xsl:when test="@display-inline = 'yes-display-inline'">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="preceding-sibling::rules-item/@display-inline = 'yes-display-inline'">
				<div>
					<xsl:apply-templates/>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="indentLevel">
					<xsl:call-template name="defineIndentForRules">
						<xsl:with-param name="aLevelElement">item</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<div>
					<xsl:attribute name="class">
						<xsl:value-of select="$indentLevel"/>
					</xsl:attribute>

					<xsl:apply-templates/>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="rules-subitem">
		<xsl:choose>
			<xsl:when test="@display-inline = 'yes-display-inline'">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="preceding-sibling::rules-subitem/@display-inline = 'yes-display-inline'">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="indentLevel">
					<xsl:call-template name="defineIndentForRules">
						<xsl:with-param name="aLevelElement">subitem</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<div>
					<xsl:attribute name="class">
						<xsl:value-of select="$indentLevel"/>
					</xsl:attribute>

					<xsl:apply-templates/>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="defineIndentForRules">
		<xsl:param name="aLevelElement"/>
		<xsl:choose>
			<xsl:when test="$aLevelElement = 'clause'">
				<xsl:call-template name="defineIndentationRulesClause"/>
			</xsl:when>
			<xsl:when test="$aLevelElement = 'paragraph'">
				<xsl:call-template name="defineIndentationRulesParagraph"/>
			</xsl:when>
			<xsl:when test="$aLevelElement = 'subparagraph'">
				<xsl:call-template name="defineIndentationRulesSubParagraph"/>
			</xsl:when>
			<xsl:when test="$aLevelElement = 'subdivision'">
				<xsl:call-template name="defineIndentationRulesSubDivision"/>
			</xsl:when>
			<xsl:when test="$aLevelElement = 'item'">
				<xsl:call-template name="defineIndentationRulesItem"/>
			</xsl:when>
			<xsl:when test="$aLevelElement = 'subitem'">
				<xsl:call-template name="defineIndentationRulesSubItem"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="defineIndentationRulesClause">
		<xsl:text>lbexIndentSubsection</xsl:text>
	</xsl:template>

	<xsl:template name="defineIndentationRulesParagraph">
		<xsl:variable name="displayInlineCount">
			<xsl:choose>
				<xsl:when
					test="ancestor::rules-clause/@display-inline = 'yes-display-inline' or preceding-sibling::rules-paragraph/@indent = 'up1' or preceding-sibling::rules-paragraph/@display-inline = 'yes-display-inline'">
					<xsl:text>1</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:variable>
		<xsl:choose>
			<xsl:when test="@indent = 'up1' or $displayInlineCount = '1'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="defineIndentationRulesSubParagraph">
		<xsl:variable name="displayInlineCount">
			<xsl:call-template name="displayInlineRulesCount2"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="@indent = 'up2' or $displayInlineCount = '2'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up1' or $displayInlineCount = '1'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="defineIndentationRulesSubDivision">
		<xsl:variable name="displayInlineCount">
			<xsl:call-template name="displayInlineRulesCount3"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="@indent = 'up3' or $displayInlineCount = '3'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up2' or $displayInlineCount = '2'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up1' or $displayInlineCount = '1'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="defineIndentationRulesItem">
		<xsl:variable name="displayInlineCount">
			<xsl:call-template name="displayInlineRulesCount4"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="@indent = 'up4' or $displayInlineCount = '4'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up3' or $displayInlineCount = '3'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up2' or $displayInlineCount = '2'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up1' or $displayInlineCount = '1'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="defineIndentationRulesSubItem">
		<xsl:variable name="displayInlineCount">
			<xsl:call-template name="displayInlineRulesCount5"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="@indent = 'up5' or $displayInlineCount = '5'">
				<xsl:text>lbexIndentSubsection</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up4' or $displayInlineCount = '4'">
				<xsl:text>lbexIndentParagraph</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up3' or $displayInlineCount = '3'">
				<xsl:text>lbexIndentSubpar</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up2' or $displayInlineCount = '2'">
				<xsl:text>lbexIndentClause</xsl:text>
			</xsl:when>
			<xsl:when test="@indent = 'up1' or $displayInlineCount = '1'">
				<xsl:text>lbexIndentSubclause</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>lbexIndentItem</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="displayInlineRulesCount2">
		<xsl:variable name="anc1_up_level">
			<xsl:choose>
				<xsl:when
					test="ancestor::*[1]/@indent and not(ancestor::*[2]/@display-inline = 'yes-display-inline')">
					<xsl:value-of select="substring-after(ancestor::*[1]/@indent, 'up')"/>
				</xsl:when>
				<xsl:when
					test="ancestor::*[1]/@indent and ancestor::*[2]/@display-inline = 'yes-display-inline'">
					<xsl:value-of select="number(substring-after(ancestor::*[1]/@indent, 'up')) - 1"
					/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="anc2_up_level">
			<xsl:choose>
				<xsl:when
					test="ancestor::*[2]/@indent and not(ancestor::*[3]/@display-inline = 'yes-display-inline')">
					<xsl:value-of select="substring-after(ancestor::*[2]/@indent, 'up')"/>
				</xsl:when>
				<xsl:when
					test="ancestor::*[2]/@indent and ancestor::*[3]/@display-inline = 'yes-display-inline'">
					<xsl:value-of select="number(substring-after(ancestor::*[2]/@indent, 'up')) - 1"
					/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when
				test="
					((ancestor::*[1]/@display-inline = 'yes-display-inline' and not(local-name(ancestor::*[1]) = 'quoted-block')) or
					ancestor::*[1]/preceding-sibling::rules-paragraph/@display-inline = 'yes-display-inline' or
					ancestor::*[1]/preceding-sibling::rules-subparagraph/@display-inline = 'yes-display-inline' or
					ancestor::*[1]/preceding-sibling::rules-subdivision/@display-inline = 'yes-display-inline' or
					ancestor::*[1]/preceding-sibling::rules-item/@display-inline = 'yes-display-inline' or
					ancestor::*[1]/preceding-sibling::rules-subitem/@display-inline = 'yes-display-inline')
					and (ancestor::*[2]/@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::rules-paragraph/@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::rules-subparagraph/@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::rules-subdivision/@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::rules-item/@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::rules-subitem/@display-inline = 'yes-display-inline')">
				<xsl:text>2</xsl:text>
			</xsl:when>
			<xsl:when
				test="
					((ancestor::*[1]/@display-inline = 'yes-display-inline' and not(local-name(ancestor::*[1]) = 'quoted-block')) or
					ancestor::*[1]/preceding-sibling::rules-paragraph/@display-inline = 'yes-display-inline' or
					ancestor::*[1]/preceding-sibling::rules-subparagraph/@display-inline = 'yes-display-inline' or
					ancestor::*[1]/preceding-sibling::rules-subdivision/@display-inline = 'yes-display-inline' or
					ancestor::*[1]/preceding-sibling::rules-item/@display-inline = 'yes-display-inline' or
					ancestor::*[1]/preceding-sibling::rules-subitem/@display-inline = 'yes-display-inline')">
				<xsl:value-of select="1 + number($anc2_up_level)"/>
			</xsl:when>
			<xsl:when
				test="
					((ancestor::*[2]/@display-inline = 'yes-display-inline' and not(local-name(ancestor::*[2]) = 'quoted-block')) or
					ancestor::*[2]/preceding-sibling::rules-paragraph//@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::rules-subparagraph//@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::rules-subdivision//@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::rules-item//@display-inline = 'yes-display-inline' or
					ancestor::*[2]/preceding-sibling::rules-subitem//@display-inline = 'yes-display-inline')">
				<xsl:value-of select="1 + number($anc1_up_level)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="number($anc1_up_level) + number($anc2_up_level)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="displayInlineRulesCount3">
		<xsl:variable name="countMax2">
			<xsl:call-template name="displayInlineRulesCount2"/>
		</xsl:variable>

		<xsl:variable name="anc3_up_level">
			<xsl:choose>
				<xsl:when
					test="ancestor::*[3]/@indent and not(ancestor::*[4]/@display-inline = 'yes-display-inline')">
					<xsl:value-of select="substring-after(ancestor::*[3]/@indent, 'up')"/>
				</xsl:when>
				<xsl:when
					test="ancestor::*[3]/@indent and ancestor::*[4]/@display-inline = 'yes-display-inline'">
					<xsl:value-of select="number(substring-after(ancestor::*[3]/@indent, 'up')) - 1"
					/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>


		<xsl:choose>
			<xsl:when
				test="
					(ancestor::*[3]/@display-inline = 'yes-display-inline' and not(local-name(ancestor::*[3]) = 'quoted-block')) or
					ancestor::*[3]/preceding-sibling::rules-paragraph/@display-inline = 'yes-display-inline' or
					ancestor::*[3]/preceding-sibling::rules-subparagraph/@display-inline = 'yes-display-inline' or
					ancestor::*[3]/preceding-sibling::rules-subdivision/@display-inline = 'yes-display-inline' or
					ancestor::*[3]/preceding-sibling::rules-item/@display-inline = 'yes-display-inline' or
					ancestor::*[3]/preceding-sibling::rules-subitem/@display-inline = 'yes-display-inline'">
				<xsl:value-of select="1 + number($countMax2)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="number($anc3_up_level) + number($countMax2)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="displayInlineRulesCount4">
		<xsl:variable name="countMax3">
			<xsl:call-template name="displayInlineRulesCount3"/>
		</xsl:variable>

		<xsl:variable name="anc4_up_level">
			<xsl:choose>
				<xsl:when
					test="ancestor::*[4]/@indent and not(ancestor::*[5]/@display-inline = 'yes-display-inline')">
					<xsl:value-of select="substring-after(ancestor::*[4]/@indent, 'up')"/>
				</xsl:when>
				<xsl:when
					test="ancestor::*[4]/@indent and ancestor::*[5]/@display-inline = 'yes-display-inline'">
					<xsl:value-of select="number(substring-after(ancestor::*[4]/@indent, 'up')) - 1"
					/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when
				test="
					ancestor::*[4]/@display-inline = 'yes-display-inline' or
					ancestor::*[4]/preceding-sibling::rules-paragraph/@display-inline = 'yes-display-inline' or
					ancestor::*[4]/preceding-sibling::rules-subparagraph/@display-inline = 'yes-display-inline' or
					ancestor::*[4]/preceding-sibling::rules-subdivision/@display-inline = 'yes-display-inline' or
					ancestor::*[4]/preceding-sibling::rules-item/@display-inline = 'yes-display-inline' or
					ancestor::*[4]/preceding-sibling::rules-subitem/@display-inline = 'yes-display-inline'">
				<xsl:value-of select="1 + number($countMax3)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="number($anc4_up_level) + number($countMax3)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="displayInlineRulesCount5">
		<xsl:variable name="countMax4">
			<xsl:call-template name="displayInlineRulesCount4"/>
		</xsl:variable>

		<xsl:variable name="anc5_up_level">
			<xsl:choose>
				<xsl:when
					test="ancestor::*[5]/@indent and not(ancestor::*[6]/@display-inline = 'yes-display-inline')">
					<xsl:value-of select="substring-after(ancestor::*[5]/@indent, 'up')"/>
				</xsl:when>
				<xsl:when
					test="ancestor::*[5]/@indent and ancestor::*[6]/@display-inline = 'yes-display-inline'">
					<xsl:value-of select="number(substring-after(ancestor::*[5]/@indent, 'up')) - 1"
					/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when
				test="
					ancestor::*[5]/@display-inline = 'yes-display-in' or
					ancestor::*[5]/preceding-sibling::rules-paragraph//@display-inline = 'yes-display-inline' or
					ancestor::*[5]/preceding-sibling::rules-subparagraph//@display-inline = 'yes-display-inline' or
					ancestor::*[5]/preceding-sibling::rules-subdivision//@display-inline = 'yes-display-inline' or
					ancestor::*[5]/preceding-sibling::rules-item//@display-inline = 'yes-display-inline' or
					ancestor::*[5]/preceding-sibling::rules-subitem//@display-inline = 'yes-display-inline'">
				<xsl:value-of select="1 + number($countMax4)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="number($anc5_up_level) + number($countMax4)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="capitalizeReplacement">
		<xsl:param name="aText"/>

		<xsl:variable name="theFirstWord">
			<xsl:choose>
				<xsl:when test="normalize-space(substring-after($aText, ' ')) = ''">
					<xsl:value-of select="$aText"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-before($aText, ' ')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="firstLetterPunctuation">
			<xsl:choose>
				<xsl:when test="normalize-space(substring($theFirstWord, 1, 1)) = '['">
					<xsl:value-of select="normalize-space(substring($theFirstWord, 1, 1))"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="theFirstLetter">
			<xsl:choose>
				<xsl:when test="$firstLetterPunctuation != ''">
					<xsl:value-of select="translate(substring($theFirstWord, 2, 1), $lower, $upper)"
					/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="translate(substring($theFirstWord, 1, 1), $lower, $upper)"
					/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="theReastOfTheWord">
			<xsl:choose>
				<xsl:when test="$firstLetterPunctuation != ''">
					<xsl:value-of select="translate(substring($theFirstWord, 3), $upper, $lower)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="translate(substring($theFirstWord, 2), $upper, $lower)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="normalize-space(substring-after($aText, ' ')) != ''">
				<xsl:variable name="trnaslateTheReastOfThePhrase">
					<xsl:call-template name="capitalizeReplacement">
						<xsl:with-param name="aText">
							<xsl:value-of select="substring-after($aText, ' ')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="theFirstWordResult"
					select="concat(concat(concat($firstLetterPunctuation, $theFirstLetter), $theReastOfTheWord), ' ')"/>
				<xsl:value-of select="concat($theFirstWordResult, $trnaslateTheReastOfThePhrase)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of
					select="concat(concat($firstLetterPunctuation, $theFirstLetter), $theReastOfTheWord)"
				/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template match="graphic">
		<xsl:if test="image-data != ''">
			<xsl:choose>
				<xsl:when test="@halign = 'center'">
					<div style="text-align:center">
						<xsl:call-template name="actualShowImage"/>
					</div>
				</xsl:when>
				<xsl:when test="@halign = 'right'">
					<div style="text-align:right">
						<xsl:call-template name="actualShowImage"/>
					</div>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="actualShowImage"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>

	</xsl:template>

	<xsl:template name="printImageCaption">
		<xsl:apply-templates select="graphic-caption"/>
	</xsl:template>

	<xsl:template name="actualShowImage">
		<xsl:if test="graphic-caption/@location = 'above'">
			<xsl:call-template name="printImageCaption"/>
			<br/>
		</xsl:if>

		<img>
			<xsl:attribute name="alt">
				<xsl:value-of select="@graphic-desc"/>
			</xsl:attribute>
			<xsl:attribute name="height">
				<xsl:value-of select="@depth"/>
			</xsl:attribute>
			<xsl:attribute name="src">
				<xsl:text>data:image/png;base64,</xsl:text>
				<xsl:value-of select="image-data"/>
			</xsl:attribute>
		</img>

		<xsl:if test="graphic-caption/@location = 'below' or not(graphic-caption/@location)">
			<br/>
			<xsl:call-template name="printImageCaption"/>
		</xsl:if>

	</xsl:template>

	<!-- TB Feb-2012 Bug #1255 -->
	<xsl:template match="suspension-floor-action" priority="1">
		<xsl:if test="not(//amendment-form) and not(attribute::display = 'no')">
			<div style="text-align:center">
				<b>
					<xsl:value-of select="."/>
				</b>
				<p/>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="suspension-instructions" priority="1">
		<xsl:if test="not(//amendment-form) and not(attribute::display = 'no')">
			<div style="text-align:center">
				<b>
					<xsl:value-of select="."/>
				</b>
				<p/>
			</div>
		</xsl:if>

	</xsl:template>

	<xsl:template match="footnote-ref">
		<xsl:choose>
			<xsl:when test="ancestor::front-matter-back-titlepage and ancestor-or-self::legislator">
				<!--skip - the footnote ref must be enforced after State-->
			</xsl:when>
			<xsl:otherwise>
				<sup>
					<a>
						<xsl:attribute name="href">
							<xsl:text>#footnote-</xsl:text>
							<xsl:value-of select="@idref"/>
						</xsl:attribute>
						<!-- TB Jan-2014  billres clean up obsolete attributes -->
						<!--xsl:attribute name="NAME"-->
						<xsl:attribute name="id">
							<xsl:value-of select="@idref"/>
						</xsl:attribute>

						<xsl:value-of select="."/>
					</a>

					<xsl:text> </xsl:text>
				</sup>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="footnote-ref" mode="enforced">
		<sup>
			<a>
				<xsl:attribute name="href">
					<xsl:text>#footnote-</xsl:text>
					<xsl:value-of select="@idref"/>
				</xsl:attribute>
				<!-- TB Jan-2014  billres clean up obsolete attributes -->
				<!--xsl:attribute name="NAME"-->
				<xsl:attribute name="id">
					<xsl:value-of select="@idref"/>
				</xsl:attribute>

				<xsl:value-of select="."/>
			</a>

			<xsl:text> </xsl:text>
		</sup>
	</xsl:template>

	<xsl:template match="footnote">
		<!-- nothing -->
	</xsl:template>

	<xsl:template name="printFootnotes">
		<xsl:if test="count(//footnote) > 0">
			<hr style="text-align:left;width:100px"/>
		</xsl:if>

		<xsl:for-each select="//footnote">
			<xsl:variable name="refNumber">
				<xsl:call-template name="findFootnoteRef">
					<xsl:with-param name="currRef" select="@id"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:call-template name="actualPrintFootnote">
				<xsl:with-param name="refNumber" select="$refNumber"/>
			</xsl:call-template>

		</xsl:for-each>
	</xsl:template>

	<xsl:template name="findFootnoteRef">
		<xsl:param name="currRef"/>
		<xsl:value-of select="//footnote-ref[@idref = $currRef]"/>
	</xsl:template>

	<xsl:template name="actualPrintFootnote">
		<xsl:param name="refNumber"/>
		<span style="font-size:70%">
			<a>
				<!-- TB Jan-2014  billres clean up obsolete attributes -->
				<!--xsl:attribute name="NAME"-->
				<xsl:attribute name="id">
					<xsl:text>footnote-</xsl:text>
					<xsl:value-of select="@id"/>
				</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:text>#</xsl:text>
					<xsl:value-of select="@id"/>
				</xsl:attribute>
				<sup>
					<xsl:value-of select="$refNumber"/>
				</sup>
			</a>
			<xsl:text> </xsl:text>
			<xsl:apply-templates/>
		</span>
		<br/>
	</xsl:template>

	<xsl:template name="printFrontMatterBackTitlepage">
		<xsl:if test="//front-matter-back-titlepage/@display = 'yes'">
			<p class="lbexBreakHere"/>
			<table align="center" class="lbexTableStyleEight">
				<tr>
					<td colspan="2" class="lbexAllcapnormal" style="text-align:center;height:35px">
						<!-- add word SENATE according to committee ID -->
						<xsl:if test="//committee-name/@committee-id = 'SSCM00'">
							<xsl:text>SENATE </xsl:text>
						</xsl:if>
						<xsl:value-of select="translate(//committee-name, $lower, $upper)"/>

					</td>
				</tr>
				<!-- for senate only - congress and session -->
				<xsl:if test="contains(translate(//current-chamber, $upper, $lower), 'senate')">
					<tr>
						<td class="lbexSmallCapTrad" colspan="2"
							style="text-align:center;height:35px">
							<xsl:if test="not(//congress/@display = 'no')">
								<xsl:variable name="theCongressName">
									<xsl:call-template name="actualPrintCongressNameShort">
										<xsl:with-param name="CNum" select="//congress"/>
										<xsl:with-param name="imageURL">
											<xsl:text>NoImage</xsl:text>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:variable>
								<xsl:value-of select="translate($theCongressName, $upper, $lower)"/>
								<br/>
							</xsl:if>
						</td>
					</tr>
					<tr>
						<td class="lbexSmallCapTrad" colspan="2"
							style="text-align:center;height:35px">
							<xsl:variable name="theSessionText">
								<xsl:call-template name="SessionTextAll">
									<xsl:with-param name="SText" select="//session"/>
								</xsl:call-template>
							</xsl:variable>
							<xsl:value-of select="translate($theSessionText, $upper, $lower)"/>
							<br/>
						</td>
					</tr>
				</xsl:if>

				<!-- Print Chairman -->
				<tr>
					<td colspan="2" style="text-align:center;font-size: 11pt;">

						<xsl:variable name="theChairman">
							<xsl:apply-templates
								select="//front-matter-back-titlepage/legislators/legislator[@role = 'chairman']"
							/>
						</xsl:variable>
						<span class="lbexSmallCapBackTitle">
							<!--xsl:value-of select="translate(//front-matter-back-titlepage/legislators/legislator[@role='chairman']/text(), $lowercase, $uppercase)"/-->
							<xsl:value-of select="translate($theChairman, $lower, $upper)"/>
						</span>
						<xsl:text>, </xsl:text>
						<xsl:call-template name="getStateName">
							<xsl:with-param name="stateShortName"
								select="translate(//front-matter-back-titlepage/legislators/legislator[@role = 'chairman']/@state, $lower, $upper)"
							/>
						</xsl:call-template>

						<i class="lbexTextNeutral">
							<xsl:text>, Chairman</xsl:text>
						</i>

						<xsl:if
							test="//front-matter-back-titlepage/legislators/legislator[@role = 'chairman']/footnote-ref">
							<xsl:apply-templates
								select="//front-matter-back-titlepage/legislators/legislator[@role = 'chairman']/footnote-ref"
								mode="enforced"/>
						</xsl:if>
					</td>
				</tr>
				<!-- legislators-->
				<xsl:variable name="theMajorityParty">
					<xsl:call-template name="getCurrentMajorityParty"/>
				</xsl:variable>
				<tr>
					<td style="vertical-align:text-top;">
						<!-- print legislators of majority party  -->
						<table>
							<tr>
								<td width="30%" style="vertical-align:text-top;"/>


								<td style="vertical-align:text-top;">
									<table>
										<xsl:call-template
											name="printLegislatorsForBackTitlebyParty">
											<xsl:with-param name="theParty"
												select="$theMajorityParty"/>
										</xsl:call-template>
									</table>
								</td>
							</tr>
						</table>
					</td>

					<td style="vertical-align:text-top;">
						<!-- print legislators of minority party -->
						<xsl:variable name="theMinorityParty">
							<xsl:choose>
								<xsl:when test="$theMajorityParty = 'D'">
									<xsl:text>R</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>D</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<table>
							<xsl:call-template name="printLegislatorsForBackTitlebyParty">
								<xsl:with-param name="theParty" select="$theMinorityParty"/>
							</xsl:call-template>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<table align="center">
							<xsl:call-template name="printStaffMembersForBackTitle"/>
						</table>
					</td>
				</tr>
			</table>

			<!-- print other footnotes in case of any -->
			<p class="lbexBreakHere"/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="printLegislatorsForBackTitlebyParty">
		<xsl:param name="theParty"/>
		<xsl:for-each
			select="//front-matter-back-titlepage/legislators/legislator[@role != 'chairman' and @party = $theParty]">
			<tr>
				<td class="lbexTocDivisionOLC">
					<xsl:apply-templates/>
					<xsl:text>, </xsl:text>
					<xsl:call-template name="getStateName">
						<xsl:with-param name="stateShortName"
							select="translate(@state, $lower, $upper)"/>
					</xsl:call-template>
					<xsl:if test="footnote-ref">
						<xsl:apply-templates select="footnote-ref" mode="enforced"/>
					</xsl:if>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="printStaffMembersForBackTitle">
		<xsl:for-each select="//front-matter-back-titlepage/staff/staff-member">
			<tr>
				<td style="text-align:center;">
					<span class="lbexSmallCapBackTitle">
						<xsl:apply-templates select="staff-member-name"/>
					</span>
					<xsl:text>, </xsl:text>
					<i class="lbexTextNeutral">
						<xsl:apply-templates select="staff-member-title"/>
					</i>
				</td>
			</tr>
		</xsl:for-each>

	</xsl:template>


	<xsl:template match="front-matter-back-titlepage/legislators/legislator">
		<xsl:choose>
			<xsl:when test="child::*">
				<xsl:apply-templates/>
				<xsl:for-each select="child::*">
					<xsl:choose>
						<xsl:when test="local-name() = 'footnote-ref'">
							<!--skip-->
						</xsl:when>
						<xsl:when test="local-name() = 'footnote'">
							<!--skip-->
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="getStateName">
		<xsl:param name="stateShortName"/>
		<xsl:choose>
			<xsl:when test="$stateShortName = 'AL'">
				<xsl:text>Alabama</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'AK'">
				<xsl:text>Alaska</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'AZ'">
				<xsl:text>Arizona</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'AR'">
				<xsl:text>Arkansas</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'CA'">
				<xsl:text>California</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'CO'">
				<xsl:text>Colorado</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'CT'">
				<xsl:text>Connecticut</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'DE'">
				<xsl:text>Delaware</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'DC'">
				<xsl:text>District of Columbia</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'FL'">
				<xsl:text>Florida</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'GA'">
				<xsl:text>Georgia</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'HI'">
				<xsl:text>Hawaii</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'ID'">
				<xsl:text>Idaho</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'IL'">
				<xsl:text>Illinois</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'IN'">
				<xsl:text>Indiana</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'IA'">
				<xsl:text>Iowa</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'KS'">
				<xsl:text>Kansas</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'KY'">
				<xsl:text>Kentucky</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'LA'">
				<xsl:text>Louisiana</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'ME'">
				<xsl:text>Maine</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'MD'">
				<xsl:text>Maryland</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'MA'">
				<xsl:text>Massachusetts</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'MI'">
				<xsl:text>Michigan</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'MN'">
				<xsl:text>Minnesota</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'MS'">
				<xsl:text>Mississippi</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'MO'">
				<xsl:text>Missouri</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'MT'">
				<xsl:text>Montana</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'NE'">
				<xsl:text>Nebraska</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'NV'">
				<xsl:text>Nevada</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'NH'">
				<xsl:text>New Hampshire</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'NJ'">
				<xsl:text>New Jersey</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'NM'">
				<xsl:text>New Mexico</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'NY'">
				<xsl:text>New York</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'NC'">
				<xsl:text>North Carolina</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'ND'">
				<xsl:text>North Dakota</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'OH'">
				<xsl:text>Ohio</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'OK'">
				<xsl:text>Oklahoma</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'OR'">
				<xsl:text>Oregon</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'PA'">
				<xsl:text>Pennsylvania</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'RI'">
				<xsl:text>Rhode Island</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'SC'">
				<xsl:text>South Carolina</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'SD'">
				<xsl:text>South Dakota</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'TN'">
				<xsl:text>Tennessee</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'TX'">
				<xsl:text>Texas</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'UT'">
				<xsl:text>Utah</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'VT'">
				<xsl:text>Vermont</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'VA'">
				<xsl:text>Virginia</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'WA'">
				<xsl:text>Washington</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'WV'">
				<xsl:text>West Virginia</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'WI'">
				<xsl:text>Wisconsin</xsl:text>
			</xsl:when>
			<xsl:when test="$stateShortName = 'WY'">
				<xsl:text>Wyoming</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@state"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="isRamseyerGenerateOn">
		<xsl:choose>
			<xsl:when test="not(ancestor::ramseyer)">
				<!-- nothing -->
			</xsl:when>
			<xsl:when test="ancestor::ramseyer and ancestor::ramseyer/@generated-text = 'on'">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="isInCordonGenerateOn">
		<xsl:choose>
			<xsl:when test="not(ancestor::cordon)">
				<!-- nothing -->
			</xsl:when>
			<xsl:when test="ancestor::cordon and ancestor::cordon/@generated-text = 'off'">
				<xsl:text>no</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>yes</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<!-- TB Sep-2016  bug fixing #1437-->
	<xsl:template match="para">
		<xsl:variable name="printingClass">
			<xsl:choose>
				<xsl:when test="@para-indent = '1' or not(@para-indent)">
					<xsl:text>lbexNonIndentSubsection</xsl:text>
				</xsl:when>
				<xsl:when test="@para-indent = '2'">
					<xsl:text>lbexNonIndentParagraph</xsl:text>
				</xsl:when>
				<xsl:when test="@para-indent = '3'">
					<xsl:text>lbexNonIndentSubparagraph</xsl:text>
				</xsl:when>
				<xsl:when test="@para-indent = '4'">
					<xsl:text>lbexNonIndentClause</xsl:text>
				</xsl:when>
				<xsl:when test="@para-indent = '5'">
					<xsl:text>lbexNonIndentSubclause</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>lbexNonIndentSubsection</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="isBracket">
			<xsl:choose>
				<xsl:when
					test="contains(@reported-display-style, 'brackets') or contains(parent::non-statutory-material/@reported-display-style, 'brackets')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:otherwise>no</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="isParenth">
			<xsl:choose>
				<xsl:when
					test="contains(@reported-display-style, 'parentheses') or contains(parent::non-statutory-material/@reported-display-style, 'parentheses')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:otherwise>no</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="additionalClass">
			<xsl:choose>
				<xsl:when
					test="@reported-display-style = 'strikethrough' or parent::non-statutory-material/@reported-display-style = 'strikethrough'">
					<xsl:text>lbexTextStrikethrough</xsl:text>
				</xsl:when>
				<xsl:when
					test="contains(@reported-display-style, 'boldface') or contains(parent::non-statutory-material/@reported-display-style, 'boldface')">
					<xsl:text>lbexBold</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="isItalic">
			<xsl:choose>
				<xsl:when
					test="contains(@reported-display-style, 'italic') or contains(parent::non-statutory-material/@reported-display-style, 'italic')">
					<xsl:text>yes</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>no</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<p/>
		<xsl:choose>
			<xsl:when test="$isItalic = 'yes'">
				<i>
					<xsl:if test="$additionalClass != ''">
						<xsl:attribute name="class">
							<xsl:value-of select="$additionalClass"/>
						</xsl:attribute>
					</xsl:if>

					<xsl:call-template name="actualPrintParaText">
						<xsl:with-param name="isBracket" select="$isBracket"/>
						<xsl:with-param name="isParenth" select="$isParenth"/>
						<xsl:with-param name="printingClass" select="$printingClass"/>
					</xsl:call-template>
				</i>
			</xsl:when>
			<xsl:when test="$additionalClass != ''">
				<span>
					<xsl:attribute name="class">
						<xsl:value-of select="$additionalClass"/>
					</xsl:attribute>
					<xsl:call-template name="actualPrintParaText">
						<xsl:with-param name="isBracket" select="$isBracket"/>
						<xsl:with-param name="isParenth" select="$isParenth"/>
						<xsl:with-param name="printingClass" select="$printingClass"/>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="actualPrintParaText">
					<xsl:with-param name="isBracket" select="$isBracket"/>
					<xsl:with-param name="isParenth" select="$isParenth"/>
					<xsl:with-param name="printingClass" select="$printingClass"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>


	</xsl:template>

	<xsl:template name="actualPrintParaText">
		<xsl:param name="isBracket"/>
		<xsl:param name="isParenth"/>
		<xsl:param name="printingClass"/>
		<xsl:element name="span">
			<xsl:attribute name="class">
				<xsl:value-of select="$printingClass"/>
			</xsl:attribute>

			<xsl:if test="ancestor::quoted-block">
				<xsl:call-template name="openQuotes"/>
			</xsl:if>

			<xsl:if test="$isBracket = 'yes'">
				<span class="lbexBrakets">
					<xsl:text>[</xsl:text>
				</span>
			</xsl:if>
			<xsl:if test="$isParenth = 'yes'">
				<span class="lbexBrakets">
					<xsl:text>(</xsl:text>
				</span>
			</xsl:if>


			<xsl:apply-templates/>

			<xsl:if test="$isBracket = 'yes'">
				<span class="lbexBrakets">
					<xsl:text>]</xsl:text>
				</span>
			</xsl:if>

			<xsl:if test="$isParenth = 'yes'">
				<span class="lbexBrakets">
					<xsl:text>)</xsl:text>
				</span>
			</xsl:if>
		</xsl:element>

	</xsl:template>

	<xsl:template name="PrintStarInLeftCornerForSenate">
		<xsl:variable name="starType" select="/*/@star-print"/>

		<xsl:if
			test="$starType != '' and contains(translate(//current-chamber, $upper, $lower), 'senate')">
			<xsl:choose>
				<xsl:when test="$starType = 'first-star-print'">
					<span>
						<xsl:text>&#x2605;(Star Print)</xsl:text>
					</span>
				</xsl:when>
				<xsl:when test="$starType = 'second-star-print'">
					<span>
						<xsl:text>&#x2605;&#x2605;(Star Print)</xsl:text>
					</span>
				</xsl:when>
				<xsl:when test="$starType = 'third-star-print'">
					<span>
						<xsl:text>&#x2605;&#x2605;&#x2605;(Star Print)</xsl:text>
					</span>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
