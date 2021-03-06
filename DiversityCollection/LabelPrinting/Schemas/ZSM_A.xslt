<?xml version="1.0" encoding="utf-16"?>
<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="utf-16"/>

  <xsl:include href="Templates/LabelTemplates.xslt"/>

  <!--Fonts-->
  <xsl:variable name="Font8">  font-size: 8pt; font-family: Times</xsl:variable>
  <xsl:variable name="Font5">  font-size: 5pt; font-family: Arial</xsl:variable>
	<xsl:variable name="Font9">  font-size: 9pt; font-family: Arial</xsl:variable>
	<xsl:variable name="Font12">  font-size: 12pt; font-family: Times; text-transform:uppercase</xsl:variable>
  <xsl:variable name="Font7">  font-size: 7pt; font-family: Times</xsl:variable>
  <xsl:variable name="Font6">  font-size: 6pt; font-family: Times</xsl:variable>


  <xsl:variable name="FontDefault">  font-size: 5pt; font-family: Arial</xsl:variable>
  <xsl:variable name="FontSmall">    font-size:  6pt; font-family: Arial</xsl:variable>
  <xsl:variable name="FontTiny">     font-size:  1pt; font-family: Arial</xsl:variable>
  <xsl:variable name="FontTitle">    font-size: 7pt; font-family: Arial</xsl:variable>
  <xsl:variable name="FontTaxonName">font-size: 7pt; font-family: Arial</xsl:variable>
  <xsl:variable name="FontType">     font-size: 7pt; font-family: Arial; text-transform:uppercase</xsl:variable>
  <xsl:variable name="FontBarcode">  font-size: 14pt; font-family: Code 39</xsl:variable>
  <xsl:variable name="FontCountry">  font-size:  6pt; font-family: Arial; text-transform:uppercase</xsl:variable>
  <xsl:variable name="FontPage">	   font-size: 10pt; font-family: Arial</xsl:variable>
  
  <!--Printing options-->
  <xsl:variable name="ReportHeader">Header of report</xsl:variable>
  <xsl:variable name="PrintReportHeader">0</xsl:variable>
  <xsl:variable name="PrintCollectionOwner">0</xsl:variable>
  <xsl:variable name="PrintReportTitle">1</xsl:variable>
  <xsl:variable name="PrintBarcode">0</xsl:variable>
  <xsl:variable name="AddSpaceAtButtom">1</xsl:variable>

  <!--Page format-->
  <xsl:variable name="LabelWidth">100</xsl:variable>
	<xsl:variable name="RowHeight">9</xsl:variable>
	<xsl:variable name="Space">
    <xsl:text> </xsl:text>
  </xsl:variable>

  <xsl:template match="/LabelPrint">
    <html>
		<head>
			<style>
				.mehrspaltig {-moz-column-count:    7;
				-webkit-column-count: 7;
				column-count:         7;}
			</style>
		</head>
		<body>
			<!--<table cellspacing="0" cellpadding="0" width="{$LabelWidth}" border="0" style="{$Font5}; overflow:hidden; table-layout:fixed; white-space: nowrap">
				<xsl:for-each select="LabelList/Label">
					<xsl:choose>
						<xsl:when test="./Counter mod 5 = 0">
							<tr></tr>
						</xsl:when>
						<xsl:when test="./Counter mod 3 = 0">

						</xsl:when>
						<xsl:when test="./Counter = 0">

						</xsl:when>
					</xsl:choose>
					<xsl:apply-templates select="Label"/>
					<xsl:choose>
						<xsl:when test="./Counter mod 5 = 0">
							
						</xsl:when>
						<xsl:when test="./Counter mod 3 = 0">

						</xsl:when>
						<xsl:when test="./Counter = 0">

						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</table>-->
			<xsl:apply-templates select="./LabelList/Label"/>
		</body>
    </html>
  </xsl:template>
  
  <xsl:template match="Label">
	  <!--<div class="mehrspaltig">-->
	  <div >
    <table cellspacing="0" cellpadding="0" width="{$LabelWidth}" border="0" style="{$Font5}; overflow:hidden; table-layout:fixed; white-space: nowrap">
		<tr height ="29" valign="top">
			<td align="left">
				<xsl:value-of select="./Units/MainUnit/Identifications/Identification/TaxonomicName"/>
				<xsl:choose>
					<xsl:when test="./Units/MainUnit/Gender='male'">
						&#9794;
					</xsl:when>
					<xsl:when test="./Units/MainUnit/Gender='female'">
						&#9792;
					</xsl:when>
				</xsl:choose>
			</td>
		</tr>
	  <tr  height ="{$RowHeight}">
		  <td align="left">
			  <xsl:value-of select="./Units/MainUnit/FamilyCache"/>
		  </td>
	  </tr>
		<tr  height ="{$RowHeight}">
			<td align="left">
				<xsl:value-of select="./Units/MainUnit/OrderCache"/>
			</td>
	</tr>
		<tr  height ="{$RowHeight}">
			<td align="left">
				det. <xsl:value-of select="./Units/MainUnit/Identifications/Identification/ResponsibleName"/>
			</td>
		</tr>
		<tr  height ="{$RowHeight}">
			<td align="left">
				<xsl:value-of select="./Units/MainUnit/Identifications/Identification/IdentificationDay"/>.<xsl:value-of select="./Units/MainUnit/Identifications/Identification/IdentificationMonth"/>.<xsl:value-of select="./Units/MainUnit/Identifications/Identification/IdentificationYear"/>
			</td>
		</tr>
		<tr height ="20" valign="bottom">
        <td align="left">
          <xsl:value-of select="./CollectionSpecimen/AccessionNumber"/>
        </td>
	  </tr>
		<tr height ="30">
			<td align="left">
				<xsl:value-of select="./CollectionEvent/LocalityDescription"/>
			</td>
		</tr>
		<tr  height ="{$RowHeight}">
			<td align="left">
				<xsl:value-of select="./CollectionEvent/CollectionDay"/>.
				<xsl:value-of select="./CollectionEvent/CollectionMonth"/>.
				<xsl:value-of select="./CollectionEvent/CollectionYear"/>
			</td>
		</tr>
		<tr height ="{$RowHeight}">
			<td align="left">
				leg. <xsl:value-of select="./Collectors/Collector/CollectorsName"/>
			</td>
		</tr>
		<tr height ="30" valign="top">
			<td align="left">
				70% Ethanol
			</td>
		</tr>
	</table>
	  </div>
	  <!--<xsl:if test="./Counter mod 3 = 0">
		  <div align="center" style="{$FontPage}; clear:both"></div>
		  <br/>
		  <br/>
	  </xsl:if>
	  <xsl:if test="./Counter mod 3 = 0">
		  <div align="center" style="{$FontPage}; clear:both"></div>
		  <h1 style="page-break-before:left"></h1>
	  </xsl:if>-->
  </xsl:template>
   
  <xsl:template match="text"></xsl:template>

</xsl:stylesheet>