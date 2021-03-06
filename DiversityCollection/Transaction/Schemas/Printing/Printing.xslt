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
			<xsl:choose>
				<xsl:when test="./TransactionType = 'embargo' or ./TransactionType = 'exchange' or ./TransactionType = 'gift' or ./TransactionType = 'purchase'">
					<xsl:call-template name="TextEmbargo"/>
					<xsl:call-template name="SpecimenNameListWithType"/>
				</xsl:when>
				<xsl:when test="./TransactionType = 'inventory'">
					<xsl:call-template name="TextInventory"/>
					<xsl:call-template name="Header"/>
					<xsl:call-template name="SpecimenListInventory"/>
				</xsl:when>
				<xsl:when test="./TransactionType = 'permit'">
					<xsl:call-template name="TextPermit"/>
					<h1 style="page-break-before:left"></h1>
					<span style="{$FontHeader}">Involved specimen:</span>
					<xsl:call-template name="SpecimenList"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="Text"/>
					<xsl:call-template name="Footer"/>
					<h1 style="page-break-before:left"></h1>
					<xsl:call-template name="Header"/>
					<xsl:call-template name="SpecimenList"/>
				</xsl:otherwise>
			</xsl:choose>
			<!--xsl:call-template name="AddressInstitution"/>
          <xsl:call-template name="FrontLabel"/>
          <xsl:call-template name="Text"/>
          <xsl:call-template name="SpecimenNameListWithType"/-->
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="FrontLabel">
    <table cellspacing="0" cellpadding="1" width="400" border="0" style="{$FontDefault}">
      <tr height="30" valign="bottom">
        <td align="left" style="{$FontBig}; border-top:1px solid black">
          <b>
            <xsl:value-of select="./To/Collection/CollectionName"/>
          </b>
        </td>
      </tr>
      <!--xsl:if test="./BeginDate != ''">
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
      <tr height="30" valign="bottom">
        <td align="left">
          Inv.-Nr.: <xsl:value-of select="./To/ToTransactionNumber"/>
        </td>
      </tr-->
    </table>
  </xsl:template>

  <xsl:template name="Text">
    <table cellspacing="0" cellpadding="1" width="{$PageWidth}" border="0" style="{$FontBig}">
      <!--tr valign="bottom">
        <td align="left">
          <b><xsl:value-of select="./TransactionTitle"/></b>
        </td>
      </tr-->
      <tr valign="bottom">
        <td align="left">
          Inv.-Nr.: <xsl:value-of select="./To/ToTransactionNumber"/>
          <xsl:if test="./BeginDate = ''">
            <xsl:text>,   </xsl:text> Eingang: <xsl:value-of select="./BeginDate"/>
          </xsl:if>
        </td>
      </tr>
      <xsl:if test="./BeginDate != ''">
        <tr height="30" valign="bottom">
          <td align="left" style="{$FontDefault}">
            zugegangen am:  <xsl:value-of select="./BeginDate"/>
          </td>
        </tr>
      </xsl:if>
      <tr height="40" valign="bottom">
        <td align="left">
          <xsl:if test="./ReportingCategory != ''">
            Zugang: <xsl:value-of select="./ReportingCategory"/>:
          </xsl:if>
          <xsl:text> </xsl:text>
          <xsl:text> </xsl:text>
          <xsl:value-of select="./NumberOfSpecimenInitial"/>
          <xsl:text> </xsl:text>Belege           
          <xsl:if test="./MaterialDescription != ''">
            -<xsl:text> </xsl:text>
            <xsl:value-of select="./MaterialDescription"/>
          </xsl:if>
        </td>
      </tr>
      <tr height="40" valign="bottom">
        <td align="left">
            <xsl:call-template name="TransactionType_DE"/>
        </td>
      </tr>
      <xsl:if test="./From/FromTransactionPartnerAddress/PersonName != ''">
        <tr valign="bottom">
          <td align="left">
              Geber: <xsl:value-of select="./From/FromTransactionPartnerAddress/PersonName"/>
            <xsl:if test="./From/FromTransactionPartnerAddress/PersonName = ''">
              <xsl:value-of select="./From/Collection/CollectionOwner"/>
            </xsl:if>
            <xsl:text>, </xsl:text>
            <xsl:if test="./From/FromTransactionPartnerAddress/City != ''">
              <xsl:value-of select="./From/FromTransactionPartnerAddress/City"/>
            </xsl:if>
            <xsl:if test="./From/FromTransactionPartnerAddress/City = ''">
              <xsl:value-of select="./From/Collection/CollectionAddress/City"/>
            </xsl:if>
          </td>
        </tr>
      </xsl:if>
    </table>
  </xsl:template>

	
	<xsl:template name="TextEmbargo">
		<table cellspacing="0" cellpadding="1" width="{$PageWidth}" border="0" style="{$FontDefault}">
			<tr height="50" valign="bottom">
				<td align="left" style="{$FontDefault}">
					<b><xsl:value-of select="./TransactionType"/>: <u><xsl:value-of select="./TransactionTitle"/></u></b>
				</td>
			</tr>
			<xsl:if test="./BeginDate">
				<tr valign="bottom">
					<td align="left" style="{$FontDefault}">
							from: <xsl:value-of select="./BeginDate"/>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="./AgreedEndDate">
				<tr valign="bottom">
					<td align="left" style="{$FontDefault}">
							until: <xsl:value-of select="./AgreedEndDate"/>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>

	<xsl:template name="TextPermit">
		<table cellspacing="0" cellpadding="1" width="{$PageWidth}" border="0" style="{$FontDefault}">
			<tr height="50" valign="bottom">
				<td align="left" style="{$FontDefault}">
					<b>
						Permit: <u>
							<xsl:value-of select="./TransactionTitle"/>
						</u>
						<xsl:value-of select="./From/FromTransactionNumber"/>
					</b>
				</td>
			</tr>
			<xsl:if test="./BeginDate">
				<tr valign="bottom">
					<td align="left" style="{$FontDefault}">
						from: <xsl:value-of select="./BeginDate"/>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="./AgreedEndDate">
				<tr valign="bottom">
					<td align="left" style="{$FontDefault}">
						until: <xsl:value-of select="./AgreedEndDate"/>
					</td>
				</tr>
			</xsl:if>
			<tr height="50" valign="bottom">
				<td align="left" style="{$FontDefault}">
					<u>Granted by:</u>
				</td>
			</tr>
			<tr>
				<td><xsl:call-template name="AddressFrom"/></td>
			</tr>
			<tr height="50" valign="bottom">
				<td align="left" style="{$FontDefault}">
					<u>Granted to:</u>
				</td>
			</tr>
			<xsl:if test="./Investigator">
				<tr valign="bottom">
					<td align="left" style="{$FontDefault}">
						<xsl:value-of select="./Investigator"/>
					</td>
				</tr>
			</xsl:if>
			<tr>
				<td>
					<xsl:call-template name="Address"/>
				</td>
			</tr>
		</table>
	</xsl:template>


	<xsl:template name="TextInventory">
		<table cellspacing="0" cellpadding="1" width="{$PageWidth}" border="0" style="{$FontDefault}">
			<tr height="50" valign="bottom">
				<td align="left" style="{$FontDefault}">
					<b>
						Inventory: <u>
							<xsl:value-of select="./TransactionTitle"/>
						</u>
					</b>
					<xsl:if test="./BeginDate or ./AgreedEndDate">
						(
						<xsl:if test="./BeginDate"><xsl:value-of select="./BeginDate"/>
							</xsl:if>
						<xsl:if test="./BeginDate and ./AgreedEndDate"> - </xsl:if>
						<xsl:if test="./AgreedEndDate">
							<xsl:value-of select="./AgreedEndDate"/>
						</xsl:if>
						)
					</xsl:if>
				</td>
			</tr>
		</table>
	</xsl:template>


	<xsl:template match="text"></xsl:template>
</xsl:stylesheet>