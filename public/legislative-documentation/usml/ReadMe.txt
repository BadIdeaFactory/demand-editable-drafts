<!--************Billres release January 2014***********

billres.xsl file was divided by two files: billres.xsl and billres-details.xsl

billres.xsl is still the main file for users other than Library of Congress and the XML database files will be pointing to this file as it has in the past

billres.xsl will provide just main wrapping tags for the HTML file, while the actual work for displaying documents is now processed in billres-details.xsl

billres.xsl points to billres-details.xsl, so both files must be placed in the same directory. 

If you want to place billres-details.xsl in different folder than billres.xsl, you need to change the reference in billres.xsl

*************************************************************-->