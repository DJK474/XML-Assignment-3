<?xml version="1.0" encoding="UTF-8" ?>



<xsl:stylesheet version="2.0"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	
   <xsl:output method="html"
      doctype-system="about:legacy-compat"
      encoding="UTF-8"
      indent="yes" />

   <xsl:template match="/">
	   <html>
			<head>
				<title>Rentals</title>
				<link href="style.css" rel="stylesheet" type="text/css"/>
			</head>
			
			
				<body>
					<div id="wrap">
						<header>
							<img src="brlogo.png" alt="The Good Earth"/>
						</header>
						
						<h1>Current Rentals</h1>
						<xsl:apply-templates select="customers/customer"/>
					</div>
				
				
				</body>
				</html>
   </xsl:template>
   
   <xsl:template match="customer">
   <table class="head" cellpadding="2">
   document("tgerentals.xml")
   <xsl:variable name="Tool" select="document('tgerentals.xml')/>

		<tr>
			<th>Customer</th>
			<th>Tool ID</th>
			<th>Tool</th>
			<th>Category</th>
			<th>Due Back</th>
			<th>Charge</th>
			
		</tr>
		
		<tr>
			<td>
			<xsl:value-of select="firstName"/><xsl:text> </xsl:text> <xsl:value-of select="lastName"/> <br/>  
			<xsl:value-of select="street"/> <br/>
			<xsl:value-of select="city"/>, <xsl:value-of select="state"/> <xsl:text> </xsl:text> <xsl:value-of select="ZIP"/>
			</td>
		</tr>
			
			<td>
				<xsl:variable name="Tool" select="document(tgerentals.xml)/Tool"/>
			</td>
				
			</table>
   
   </xsl:template>

</xsl:stylesheet>

