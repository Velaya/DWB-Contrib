<?xml version="1.0" encoding="utf-16"?>
<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="utf-16"/>

  <xsl:include href="Templates/LabelTemplates.xslt"/>

  <!--Fonts-->
  <xsl:variable name="FontDefault">  font-size: 10pt; font-family: Arial</xsl:variable>
  <xsl:variable name="FontSmall">    font-size: 8pt; font-family: Arial</xsl:variable>
  <xsl:variable name="FontTiny">     font-size:  1pt; font-family: Arial</xsl:variable>
  <xsl:variable name="FontHidden">   font-size:  1pt; font-family: Arial colour: white</xsl:variable>
  <xsl:variable name="FontTitle">    font-size: 12pt; font-family: Arial</xsl:variable>
  <xsl:variable name="FontTaxonName">font-size: 12pt; font-family: Arial</xsl:variable>
  <xsl:variable name="FontTaxonNameAuthors">font-size: 12pt; font-family: Arial</xsl:variable>
  <xsl:variable name="FontType">     font-size: 12pt; font-family: Arial; text-transform:uppercase</xsl:variable>
  <xsl:variable name="FontBarcode">  font-size: 22pt; font-family: Code 39</xsl:variable>
  <xsl:variable name="FontCountry">  font-size: 12pt; font-family: Arial; text-transform:uppercase</xsl:variable>
  <!--Printing options-->
  <xsl:variable name="ReportHeader">Header of report</xsl:variable>
  <xsl:variable name="PrintReportHeader">0</xsl:variable>
  <xsl:variable name="PrintHeader">0</xsl:variable>
  <xsl:variable name="PrintReportTitle">1</xsl:variable>
  <xsl:variable name="PrintCountryCache">0</xsl:variable>
  <xsl:variable name="PrintLabelImage">1</xsl:variable>
  <xsl:variable name="PrintEvent">0</xsl:variable>
  <xsl:variable name="PrintIdentifications">0</xsl:variable>
  <xsl:variable name="PrintCollectors">0</xsl:variable>
  <!--Page format-->
  <xsl:variable name="LabelWidth">400</xsl:variable>
  <xsl:variable name="Space"> </xsl:variable>
  
  <xsl:template match="/LabelPrint">
    <html>
		<body>
        <!--xsl:value-of select="/CollectionSpecimens/CollectionSpecimen/Storages/Storage/CollectionOwner"/-->
        <xsl:if test="$PrintHeader = 1">
          <xsl:call-template name="Header"/>
        </xsl:if>
        <xsl:if test="$PrintReportHeader = 1">
          <hr/>
          <span style="{$FontTitle}">
            <xsl:value-of select="$ReportHeader"/>
          </span>
        </xsl:if>
        <xsl:apply-templates select="LabelList/Label"/>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template name="Header">
    <!--table cellspacing="0" cellpadding="0" width="{$LabelWidth}" border="0">
      <tr height ="60" valign="buttom">
        <td align="center" style="{$FontDefault}">
          <xsl:value-of select="/CollectionSpecimens/CollectionSpecimen/Storages/Storage/CollectionOwner"/>
        </td>
      </tr>
      <tr>
        <td align="center" style="{$FontTitle}">
          <b><xsl:value-of select="/CollectionSpecimens/CollectionSpecimen/DepositorsName"/></b>
        </td>
      </tr>
      <tr>
        <td align="center" style="{$FontSmall}">
          zugegangen am <xsl:value-of select="/CollectionSpecimens/CollectionSpecimen/AccessionDay"/>.<xsl:value-of select="/CollectionSpecimens/CollectionSpecimen/AccessionMonth"/>.<xsl:value-of select="/CollectionSpecimens/CollectionSpecimen/AccessionYear"/>
          <xsl:value-of select="/CollectionSpecimens/CollectionSpecimen/LabelTitle"/>
        </td>
      </tr>
      <tr>
        <td align="center" height ="0" valign ="top">
          _________________________________________________________________________________
        </td>
      </tr>
    </table-->
  </xsl:template>
  
  <xsl:template match="Label">
    <xsl:if test="position() mod 2 = 0">
      <h1 style="page-break-after:allways"></h1>
    </xsl:if>
      <table cellspacing="1" cellpadding="1" width="{$LabelWidth}" border="0" style="page-break-after:allways">
        <tr height ="20">
          <th width="{$LabelWidth}/2" ></th>
          <th width="{$LabelWidth}/2"></th>
          <!--th width="1"></th-->
        </tr>
        <!--tr height ="20">
          <td align="center" colspan="2">
          </td>
          <td align="center" rowspan="8">
            <img>
              <xsl:attribute name="width">
                <xsl:value-of select="1" />
              </xsl:attribute>
              <xsl:attribute name="height">
                <xsl:value-of select="400" />
              </xsl:attribute>
              <xsl:attribute name="src">
                <xsl:value-of select="/CollectionSpecimens/CollectionSpecimen/Labels/Label/URI" />
              </xsl:attribute>
            </img>
          </td>
        </tr-->
        <tr>
          <td align="center" colspan="2" style="{$FontDefault}">
            <xsl:value-of select="/Collection/CollectionOwner"/>
          </td>
        </tr>
        <tr>
          <td align="center" style="{$FontTitle}" colspan="2">
            <b>
              <xsl:value-of select="/CollectionSpecimen/DepositorsName"/>
            </b>
          </td>
        </tr>
        <tr>
          <td align="center" colspan="2" style="{$FontSmall}" valign ="buttom">
            zugegangen am <xsl:value-of select="./CollectionSpecimen/AccessionDay"/>.<xsl:value-of select="./CollectionSpecimen/AccessionMonth"/>.<xsl:value-of select="/CollectionSpecimens/CollectionSpecimen/AccessionYear"/>, <xsl:value-of select="/CollectionSpecimens/CollectionSpecimen/LabelTitle"/>
          </td>
        </tr>
        <tr>
          <td align ="right" colspan="2" style="{$FontDefault}; border-bottom:1px solid black" valign ="buttom">
            <xsl:value-of select="./CollectionSpecimen/AccessionNumber"/>
          </td>
        </tr>
        <!--tr>
        <td align ="center" colspan="2" style="{$FontDefault}" valign ="buttom">
          <u>
            <xsl:text>_________________________________________</xsl:text><xsl:value-of select="./AccessionNumber"/></u>
        </td>
      </tr>
        <tr height ="0" style="{$FontTiny}">
          <td width="{$LabelWidth}/2" colspan="2" valign="top" align="center">
            _______________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
          </td>
        </tr-->
        <xsl:if test="$PrintIdentifications = 1">
          <tr height ="40" style="{$FontTaxonName}">
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
        </xsl:if>
        <tr style="{$FontSmall}">
          <td colspan ="2">
            <xsl:call-template name="Event"/>
          </td>
        </tr>
        <tr style="{$FontSmall}" height ="100">
          <td colspan ="2" align="center" style="padding-bottom:20px; border-bottom:1px dashed #CCCCCC" >
            <xsl:apply-templates select ="ImagesOfLabels"/>
          </td>
        </tr>
        <!--tr style="{$FontHidden}" height ="20">
          <td colspan ="2" style="border-bottom:1px solid grey">_
          </td>
        </tr>
        <tr style="{$FontSmall}">
          <td colspan ="1" align ="left" valign ="top">
            <xsl:call-template name="CollectionDate"/>
          </td>
          <td colspan ="1" align ="right">
            <xsl:apply-templates select ="Collectors"/>
          </td>
        </tr>
        <xsl:if test="$PrintIdentifications = 1">
          <xsl:if test="./Units/MainUnit/Identifications/Identification/ResponsibleName != ''">
            <tr style="{$FontSmall}">
              <td > </td>
              <td colspan ="1" align ="right">
                det.
                <xsl:if test="./Units/MainUnit/Identifications/Identification/Agent/FirstNameAbbreviation != ''">
                  <xsl:value-of select="./Units/MainUnit/Identifications/Identification/Agent/FirstNameAbbreviation"/>
                  <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:value-of select="./Units/MainUnit/Identifications/Identification/Agent/SecondName"/>
                <xsl:call-template name="IdentificationDate"/>
              </td>
            </tr>
          </xsl:if>
        </xsl:if-->
        <!--/table>
    <table cellspacing="1" cellpadding="1" width="{$LabelWidth}" border="0" style="{$FontDefault}">
      <tr height ="0">
        <th width="{$LabelWidth}" ></th>
      </tr>
      <tr>
        <td align ="center" colspan="2" style="{$FontDefault}">
          <xsl:value-of select="./AccessionNumber"/>
        </td>
      </tr>
      <tr height ="20" style="{$FontBarcode}">
        <td colspan ="2" align="center" valign ="bottom">
          *<xsl:value-of select="./AccessionNumber"/>*
        </td>
      </tr-->
      </table>
    <!--hr/-->
  </xsl:template>

  <xsl:template match="ImagesOfLabels">
    <xsl:if test="./ImageOfLabel/URI != ''">
    <img>
      <!--xsl:attribute name="width">
        <xsl:value-of select="$LabelWidth" />
      </xsl:attribute-->
      <xsl:attribute name="height">
        <xsl:value-of select="215" />
      </xsl:attribute>
      <xsl:attribute name="src">
        <xsl:value-of select="./ImageOfLabel/URI" />
      </xsl:attribute>
    </img>      
    </xsl:if>
  </xsl:template>

  <xsl:template name="Event">
    <xsl:if test="$PrintEvent = 1">
      <xsl:if test="$PrintCountryCache = 1">
      <xsl:if test="./CollectionEvent/CountryCache != ''">
      <span style= "{$FontCountry}">
      <xsl:value-of select="./CollectionEvent/CountryCache"/>.
      </span> 
    </xsl:if>
    </xsl:if>
    <xsl:value-of select="./CollectionEvent/LocalityDescription"/> 
    <xsl:if test="./CollectionEvent/HabitatDescription != ''">
      <xsl:text> </xsl:text>
      <xsl:value-of select="./CollectionEvent/HabitatDescription"/>
    </xsl:if>
      </xsl:if>
  </xsl:template>
    
  <xsl:template match="text"></xsl:template>
</xsl:stylesheet>