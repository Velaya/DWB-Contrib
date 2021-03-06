<?xml version="1.0" encoding="utf-16"?>
<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="utf-16"/>

  <xsl:include href="../TransactionTemplates.xslt"/>


	<xsl:template match="/TransactionList">
    <style type="text/css">
      body { margin-left:70px; }
    </style>
    <html>
      <body>
        <xsl:for-each select="./Transaction">
          <!--xsl:call-template name="FrontLabel"/>
          <h1 style="page-break-before:left"></h1-->
          <xsl:call-template name="Text"/>
			<xsl:call-template name="SpecimenListTaxa"/>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="FrontLabel">
    <table cellspacing="0" cellpadding="1" width="400" border="0" style="{$FontDefault}">
      <tr height="30" valign="bottom">
        <td align="left" style="{$FontBig}">
          <b>
            <xsl:value-of select="./To/Collection/CollectionOwner"/>
          </b>
        </td>
      </tr>
      <xsl:if test="./BeginDate != ''">
      <tr height="30" valign="bottom">
        <td align="left" style="{$FontDefault}">
          zugegangen am:  <xsl:value-of select="./BeginDate"/>
        </td>
      </tr>
      </xsl:if>
      <xsl:if test="./ReportingCategory != '' or ./MaterialDescription != ''">
        <tr height="30" valign="bottom">
          <td align="center">
            <xsl:value-of select="./NumberOfSpecimenInitial"/>
            <xsl:text> </xsl:text>
            <xsl:if test="./ReportingCategory != ''">
              <xsl:value-of select="./ReportingCategory"/>:
            </xsl:if>
            <xsl:text> </xsl:text>
            <xsl:value-of select="./MaterialDescription"/>
          </td>
        </tr>
      </xsl:if>
      <tr height="30" valign="bottom">
        <td align="left">
          <xsl:call-template name="TransactionType_DE"/>
        </td>
      </tr>
      <!--tr height="30" valign="bottom">
        <td align="left">
          Inv.-Nr.: <xsl:value-of select="./To/ToTransactionNumber"/>
        </td>
      </tr-->
    </table>
  </xsl:template>
	
	<!--
	Titel
	Zugangsart
	Inv.-Nr.
	Zugangsdatum
	Anzahl
	Material
	Sammler
	Herbar
	und eine Auflistung aller Barcodes
	-->

  <xsl:template name="Text">
    <table cellspacing="2" cellpadding="1" width="{$PageWidth}" border="0" style="{$FontDefault}">
		<tr>
			<th width="100"></th>
			<th></th>
		</tr>
	<!--Titel-->
	<tr valign="bottom">
		<td align="left" colspan="2">
		  <b><xsl:value-of select="./TransactionTitle"/></b>
			<br/>
		</td>
	</tr>
	<tr height="16">
		<td colspan="2">
			<xsl:text> </xsl:text>
		</td>
	</tr>

			<!--Zugangsart-->
	<tr valign="bottom">
		<td align="left">
			Zugangsart:
		</td>
		<td align="left">
			<xsl:text> </xsl:text><xsl:call-template name="TransactionType_DE"/></td>
	</tr>
		<tr height="16">
			<td>
				<xsl:text> </xsl:text>
			</td>
			<td></td>
		</tr>

		<!--Inv.-Nr.-->
		<xsl:if test="./To/ToTransactionNumber != ''">
			<tr valign="bottom">
				<td align="left">
					Inv.-Nr.:
				</td>
				<td align="left">
					<xsl:text> </xsl:text>
					<xsl:value-of select="./To/ToTransactionNumber"/>
				</td>
			</tr>
			<tr height="16">
				<td>
					<xsl:text> </xsl:text>
				</td>
				<td></td>
			</tr>
		</xsl:if>

		<!--Zugangsdatum-->
		<xsl:if test="./BeginDate != ''">
        <tr valign="bottom">
          <td align="left">
			  Zugangsdatum:
          </td>
			<td align="left"><xsl:text>  </xsl:text> <xsl:value-of select="./BeginDate"/></td>
        </tr>
			<tr height="16">
				<td>
					<xsl:text> </xsl:text>
				</td>
				<td></td>
			</tr>
		</xsl:if>

		<!--Anzahl-->
		<tr valign="bottom">
        <td align="left">
          Anzahl:           
        </td>
			<td align="left"><xsl:text> </xsl:text> <xsl:value-of select="./NumberOfSpecimenInitial"/>
          <xsl:if test="./ReportingCategory != ''">
			  <xsl:text> </xsl:text>
			  <xsl:value-of select="./ReportingCategory"/>
          </xsl:if></td>
      </tr>
		<tr height="16">
			<td>
				<xsl:text> </xsl:text>
			</td>
			<td></td>
		</tr>

		<!--Material-->
		<xsl:if test="./MaterialDescription != ''">
		<tr valign="top">
			<td align="left">
					Material:
			</td>
			<td>
					<xsl:value-of select="./MaterialDescription"/></td>
		</tr>
		<tr height="16">
			<td>
				<xsl:text> </xsl:text>
			</td>
			<td></td>
		</tr>
				</xsl:if>

		<!--Herbar-->
		<xsl:if test="./From/CollectionOwner/Name != ''">
        <tr valign="bottom">
          <td align="left">
              Herbar:
          </td>
			<td> <xsl:value-of select="./From/CollectionOwner/Name"/></td>
        </tr>
			<tr height="16">
				<td>
					<xsl:text> </xsl:text>
				</td>
				<td></td>
			</tr>
		</xsl:if>
    </table>
  </xsl:template>

  <xsl:template match="text"></xsl:template>
</xsl:stylesheet>