<!--  ===========================================================  -->
<!--  MODULE:    Legislative Branch Bills  XSLT                    -->
<!--                                                               -->
<!--  DATE:      December 4, 2013                                  -->
<!--  First version                                                -->
<!-- ============================================================= -->
<!-- details and actual transformation extracted to				   -->
<!--	the billres_details.xsl file							   -->		
<!-- Current file just a wrapper - envelope for the actual one	   -->
<!-- It was a request by Library of Congress – to remove from 	   -->
<!-- the actual document transformation result the main HTML tags  -->
<!-- as html, title, head, body. But also we wanted to keep 	   -->
<!-- backwards compatibility for the existing XML database. 	   -->
<!-- Two files – billres.xsl and billres_details.xsl – at the 	   -->
<!-- same folder will replace the previous billres.xsl			   -->
<!-- Cascading style sheet file BillResStyle.xsl may be extracted  -->
<!-- or not – according to the client requirements. 				   -->
<!-- ============================================================= -->
<!--                                                               -->
<!--                                                               -->
<!-- ========================== END ============================== -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ms="urn:schemas-microsoft-com:xslt" xmlns:dc="http://purl.org/dc/elements/1.1/">
	<xsl:include href="billres-details.xsl"/>
	<xsl:output method="html"/>

	<xsl:template match="/">
		<html encoding="utf-8">
			<head>

				<!-- Added meta tag to request IE to use the most recent version of it's rendering engine-->
				<!--http://stackoverflow.com/questions/4966952/ie-not-rendering-css-properly-when-the-site-is-located-at-networkdrive-->
				<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>

				<title>
					<xsl:call-template name="printDocumentTitle"/>
				</title>
				<xsl:call-template name="defineDocumentStyle"/>
			</head>
			<body class="lbexBody">
				<xsl:call-template name="prePrintWebDocument"/>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
