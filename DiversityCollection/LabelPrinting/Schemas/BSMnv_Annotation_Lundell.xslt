<?xml version="1.0" encoding="utf-16"?>
<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="utf-16"/>

  <xsl:include href="Templates/LabelTemplates.xslt"/>

  <!--Fonts-->
  <xsl:variable name="FontDefault">  font-size: 7pt; font-family: Arial</xsl:variable>
  <xsl:variable name="FontSmall">    font-size:  7pt; font-family: Arial</xsl:variable>
  <xsl:variable name="FontTiny">     font-size:  1pt; font-family: Arial</xsl:variable>
  <xsl:variable name="FontTitle">    font-size: 8pt; font-family: Arial</xsl:variable>
  <xsl:variable name="FontTaxonName">font-size: 8pt; font-family: Arial</xsl:variable>
  <xsl:variable name="FontType">     font-size: 8pt; font-family: Arial; text-transform:uppercase</xsl:variable>
  <xsl:variable name="FontBarcode">  font-size: 15pt; font-family: Code 39</xsl:variable>
  <xsl:variable name="FontCountry">  font-size:  9pt; font-family: Arial; text-transform:uppercase</xsl:variable>
  <xsl:variable name="FontPage">	   font-size: 5pt; font-family: Arial</xsl:variable>
  
  <!--Printing options-->
  <xsl:variable name="ReportHeader">Header of report</xsl:variable>
  <xsl:variable name="PrintReportHeader">0</xsl:variable>
  <xsl:variable name="PrintCollectionOwner">0</xsl:variable>
  <xsl:variable name="PrintReportTitle">1</xsl:variable>
  <xsl:variable name="PrintBarcode">0</xsl:variable>
  <xsl:variable name="AddSpaceAtButtom">1</xsl:variable>

  <!--Page format-->
  <xsl:variable name="LabelWidth">340</xsl:variable>
  <xsl:variable name="Space">
    <xsl:text> </xsl:text>
  </xsl:variable>

  <xsl:template match="/LabelPrint">
    <html>
      <body>
        <xsl:if test="$PrintCollectionOwner = 1">
          <table cellspacing="0" cellpadding="0" width="{$LabelWidth}" border="0" style="{$FontTitle}">
            <tr height ="0">
              <td>
                <xsl:value-of select="/LabelPrint/LabelList/Label/Collection/CollectionOwner"/>
              </td>
            </tr>
          </table>
        </xsl:if>
        <xsl:if test="$PrintReportHeader = 1">
          <span style="{$FontTitle}">
            <xsl:value-of select="$ReportHeader"/>
          </span>
        </xsl:if>
        <xsl:apply-templates select="LabelList/Label"/>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="Label">
    <table cellspacing="0" cellpadding="0" width="{$LabelWidth}" border="0" style="{$FontDefault}">
      <tr height ="0">
        <!--th width="{$LabelWidth}*3/4" ></th>
        <th width="{$LabelWidth}/4"></th-->
        <th width="20"></th>
        <th width="70"></th>
        <th width="230" ></th>
        <th width="20"></th>
      </tr>
      <tr height ="10" valign="top">
        <td align ="left">-</td>
        <td align ="left"></td>
        <td align ="left"></td>
        <td align ="right">-</td>
      </tr>
      <tr height ="16" valign="bottom">
        <td align ="left"></td>
        <td align ="left" valign="bottom">
          <xsl:if test="./CollectionSpecimen/AccessionNumber != ''">
            <xsl:value-of select="./CollectionSpecimen/AccessionNumber"/>
          </xsl:if>
        </td>
        <td align ="right"  valign="bottom">
          <xsl:value-of select="./CollectionSpecimen/LabelTitle"/>
        </td>
        <td align ="left"></td>
      </tr>
      <tr height ="2">
        <td></td>
        <td style="border-top:1px solid black" colspan ="2">
          <font color="#ffffff"> .</font>
        </td>
        <td></td>
      </tr>
      <tr style="{$FontTaxonName}">
          <td></td>
          <td colspan ="2">
            <xsl:for-each select="./Units/MainUnit/Identifications/Identification">
              <xsl:if test="position()=1">
                <xsl:for-each select="./Taxon/TaxonPart">
                  <xsl:call-template name="TaxonPart"/>
                </xsl:for-each>
                <!--xsl:call-template name="TaxonomicName"/-->
              </xsl:if>
            </xsl:for-each>
        </td>
      </tr>
      <tr style="{$FontSmall}">
        <td></td>
        <td colspan ="2">
        <xsl:call-template name="Event"/>
        <xsl:call-template name="Altitude"/>
        </td>
      </tr>
      <xsl:if test="./Units/MainUnit/Identifications/Identification/ResponsibleName != ''">
        <tr style="{$FontSmall}">
          <td></td>
          <td align ="left">
            det./rev./conf./vid.<xsl:text> </xsl:text>
          </td>
          <td colspan ="1" align ="right">
            <xsl:if test="./Units/MainUnit/Identifications/Identification/Agent/FirstNameAbbreviation != ''">
              <xsl:value-of select="./Units/MainUnit/Identifications/Identification/Agent/FirstNameAbbreviation"/>
              <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:value-of select="./Units/MainUnit/Identifications/Identification/Agent/SecondName"/>
            , Seeheim
          </td>
        </tr>
      </xsl:if>
      </table>
      <xsl:if test="./Counter mod 15 = 0">
      <div align="right" style="{$FontPage}">
        <xsl:value-of select="./Counter div 15"/>
      </div>
		<h1 style="page-break-before:left"></h1>
      </xsl:if>
  </xsl:template>
  
  <xsl:template name="Event">
    <span style= "{$FontCountry}">
      <xsl:if test="./CollectionEvent/CountryCache != ''">
          <xsl:value-of select="./CollectionEvent/CountryCache"/>.
      </xsl:if>
    </span> <xsl:value-of select="./CollectionEvent/LocalityDescription"/>
    <xsl:if test="./CollectionEvent/HabitatDescription != ''">
      <xsl:text> </xsl:text>
      <xsl:value-of select="./CollectionEvent/HabitatDescription"/>
    </xsl:if>

  </xsl:template>
  
  <xsl:template match="text"></xsl:template>

</xsl:stylesheet>