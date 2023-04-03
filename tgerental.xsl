<?xml version="1.0" encoding="UTF-8" ?>

<!--tgecustomers.xml is the main file for XSL transformation. The other files are child elements-->

<xsl:stylesheet version="2.0"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:custFunction="http://xsltfuctions" xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <!-- <xsl:variable name="rentdocs" select="document('tgerentals.xml')"/> -->
     
    


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
						
							<img src="tgelogo.png" alt="The Good Earth"/>
						
						
						<h1>Current Rentals</h1>
						<xsl:apply-templates select="customers/customer"/>
					</div>
				
				
				</body>
				</html>
   </xsl:template>
   
    <xsl:function name="custFunction:getDueDate">
    <xsl:param name="startDate"/>
    <xsl:param name="day"/>
    <xsl:param name="week"/>
    <xsl:variable name="date" select="xs:date($startDate) + xs:dayTimeDuration(string-join(('P', $day, 'D'), ''))
    + xs:dayTimeDuration(string-join(('P',string(number($week) * 7), 'D'), ''))"/>
     <xsl:value-of select="format-date($date,'[MNn] [D], [Y]')"/>
  </xsl:function>
  
  
<xsl:function name="custFunction:getTotalCharge">
    <xsl:param name="day"/>
    <xsl:param name="week"/>
    <xsl:param name="dailyRate"/>
    <xsl:param name="weeklyRate"/>
    <xsl:variable name="totalCharge" select="((number($day) * number($dailyRate)) +(number($week) 
    * number($weeklyRate))) "/>
     <xsl:value-of select="$totalCharge"/>
  </xsl:function>  
  
   
   <xsl:template match="customer">
   <table class="head" cellpadding="2">
   <xsl:variable name="IDValue" select="@custID"/>
   <xsl:variable name="custInfo" select="doc('tgecustomers.xml')/customers/customer[@custID=$IDValue]"/>
  <!-- <xsl:variable name="Tinfo" select="$custInfo"/> -->
 
   <xsl:variable name="ToolID" select="doc('tgerentals.xml')/rentals/rental[Customer = $IDValue]"/>
   
   <xsl:variable name="ToolInfo" select="doc('tgetools.xml')/equipment/tool[@toolID = $ToolID/Tool]"/>
   <xsl:variable name="Time" select="$ToolID/Start_Date"/>
   <!--<xsl:variable name="TimeInfo" select="xs:time($Time)"/>-->
   
   
   
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
			
			<td>
				<xsl:value-of select="$ToolID/Tool"/>
			</td>
			
			<td>
				<xsl:value-of select="$ToolInfo/description"/>
			</td>
			
			<td>
				<xsl:value-of select="$ToolInfo/category"/>
			</td>
		</tr>
		
		<tr>
			<td>
			<xsl:value-of select="$custInfo/firstName"/> <br/>
			<xsl:value-of select="$ToolID/Tool"/> <br/>
			<!--<xsl:value-of select="$Tinfo"/> <br/>-->
			<xsl:value-of select="$ToolInfo/description"/> <br/>
			<xsl:value-of select="$ToolInfo/category"/> <br/>
			<xsl:value-of select="format-date($ToolID/Start_Date, '[M]/[D]/[Y]')" /> <br/>
			
			
				
			</td>
		</tr>
		
		<tr>
			<td>
				<xsl:value-of select="custFunction:getDueDate($ToolID/Start_Date, $ToolID/Days, $ToolID/Weeks)"/> <br/>
				
                   <xsl:value-of select="format-number(custFunction:getTotalCharge($ToolID/Days,$ToolID/Weeks,$ToolInfo/dailyRate,$ToolInfo/weeklyRate),'$#,##0')" />     
			</td>
		</tr>
		
				
			</table>
   
   </xsl:template>

</xsl:stylesheet>

