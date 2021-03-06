<?xml version="1.0" encoding="utf-16"?>
<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="utf-16"/>

  <xsl:include href="../TransactionTemplates.xslt"/>

  <xsl:template match="/TransactionList">
    <style type="text/css">
      body { margin-left:20px; }
    </style>
    <html>
      <body>
        <xsl:for-each select="./Transaction">
			<br/>
			<br/>
			<br/>
			<xsl:choose>
				<xsl:when test="./TransactionType = 'loan'">
					<xsl:call-template name="Header"/>
					<xsl:call-template name="HeaderAddress"/>
					<xsl:call-template name="ReturnAddress"/>
					<xsl:call-template name="Address"/>
					<xsl:call-template name="Text"/>
					<xsl:call-template name="Footer"/>
					<!--<div align="center" style="{$FontSmall}">
						<br/>
						1
					</div>-->
					<h1 style="page-break-before:left"></h1>
					<xsl:call-template name="HeaderSpecimenList"/>
					<xsl:call-template name="SpecimenList"/>
					<br/>
				</xsl:when>
				<xsl:when test="./TransactionType = 'exchange'">
					<xsl:call-template name="Header"/>
					<xsl:call-template name="HeaderAddress"/>
					<xsl:call-template name="ReturnAddress"/>
					<xsl:call-template name="Address"/>
					<xsl:call-template name="TextExchange"/>
				</xsl:when>
			</xsl:choose>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>

	<xsl:template name="TextExchange">
		<table cellspacing="0" cellpadding="1" width="{$PageWidth}" border="0" style="{$FontDefault}">
			<tr height="50" valign="bottom">
				<td align="right" style="{$FontDefault}">
					<xsl:choose>
						<xsl:when test="./Administration/CollectionAdministrativeContact/Address/City">
							<xsl:value-of select="./Administration/CollectionAdministrativeContact/Address/City"/>,
						</xsl:when>
						<xsl:when test="./Administration/CollectionOwner/Address/City">
							<xsl:value-of select="./Administration/CollectionOwner/Address/City"/>,
						</xsl:when>
					</xsl:choose>
					<xsl:value-of select="./Date"/>
				</td>
			</tr>
			<!--<tr height="50" valign="bottom">
				<td align="left" style="{$FontDefault}">
					Dear Madame/Sir,
				</td>
			</tr>-->
			<tr height="70" valign="bottom">
				<td align="left" style="{$FontDefault}">
					The
					<xsl:choose>
						<xsl:when test="./From/Address/AgentName">
							<xsl:value-of select="./From/Address/AgentName"/>
						</xsl:when>
						<xsl:when test="./From/CollectionOwner/Name">
							<xsl:value-of select="./From/CollectionOwner/Name"/>
						</xsl:when>
					</xsl:choose>
					is sending you as a continuation of exchange specimen(s) <xsl:call-template name="Balance"/> specified below.  
				</td>
			</tr>
			<tr height="50" valign="bottom">
				<td align="left" style="{$FontDefault}">
					Number of specimens: <xsl:value-of select="./NumberOfUnits"/>
				</td>
			</tr>
			<tr>
				<td align="left" style="{$FontDefault}">
					Description of specimens: <xsl:value-of select="./MaterialDescription"/>
				</td>
			</tr>
			<tr height="50" valign="bottom">
				<td align="left">
					Yours sincerely,
				</td>
			</tr>
			<tr height="50" valign="top">
				<td align="left">
					The Curator
				</td>
			</tr>
			<xsl:if test="./TransactionComment">
				<tr>
					<td align="left" colspan="2">
						<xsl:value-of select="./TransactionComment"/>
					</td>
				</tr>
			</xsl:if>
			<tr>
				<td align="left" style="padding-bottom:10px; border-top:1px dotted #000000" colspan="2">
					Please verify the contents and acknowledge receipt by duplicate form.
				</td>
			</tr>
			<tr>
				<td align="left" style="{$FontDefault}" colspan="2">
					Received the above specimens in good order.
				</td>
			</tr>
			<tr height="50" valign="bottom">
				<td align="left" style="{$FontDefault}">
					Signed ...............................
				</td>
				<td align="right" style="{$FontDefault}">
					Date .................................
				</td>
			</tr>

		</table>
	</xsl:template>

	<xsl:template name="Text">
    <table cellspacing="0" cellpadding="1" width="{$PageWidth}" border="0" style="{$FontDefault}">
      <tr height="50" valign="bottom">
        <td align="right" style="{$FontDefault}">
          <xsl:value-of select="./From/Address/City"/>,
			<xsl:choose>
				<xsl:when test="./BeginDate">
					<xsl:value-of select="./BeginDate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="./Date"/>
				</xsl:otherwise>
			</xsl:choose>
		</td>
      </tr>
		<tr height="110" valign="center">
			<td align="left" style="{$FontDefault}">
				<b>Shipment form</b>
			</td>
		</tr>
		<tr height="50" valign="bottom">
        <td align="left" style="{$FontDefault}">
			The
			<xsl:choose>
				<xsl:when test="./From/Address/AgentName">
					<xsl:value-of select="./From/Address/AgentName"/>
				</xsl:when>
				<xsl:when test="./From/CollectionOwner/Name">
					<xsl:value-of select="./From/CollectionOwner/Name"/>
				</xsl:when>
			</xsl:choose>
			is sending you as a loan
			the herbarium specimen(s) (<xsl:call-template name="TaxonomicGroups"/>) specified in the list attached.
        </td>
      </tr>
      <xsl:if test="./From/FromTransactionNumber != ''">
        <tr height="50" valign="bottom">
          <td align="left">
            Loan no. <xsl:value-of select="./From/FromTransactionNumber"/>
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="./Investigator != ''">
        <tr height="50" valign="bottom">
          <td align="left">
            For study by: <xsl:value-of select="./Investigator"/>
          </td>
        </tr>
      </xsl:if>
      <tr>
        <td align="left">
          Number of specimens: <xsl:value-of select="./NumberOfSpecimenOnLoan"/>
			<xsl:if test="./NumberOfSpecimenOnLoan != ./NumberOfStockOnLoan">
			  (in <xsl:value-of select="./NumberOfStockOnLoan"/> parts)
			</xsl:if>
        </td>
      </tr>
      <tr>
        <td align="left">
          Loan granted for <xsl:value-of select="./DurationInMonths"/> months.
          Return of material expected by  <xsl:value-of select="./AgreedEndDate"/>.
        </td>
      </tr>
      <tr>
        <td align="left">
          <xsl:value-of select="./TransactionComment"/>
        </td>
      </tr>
      <tr height="50" valign="bottom">
        <td align="left">
          Yours sincerely,
        </td>
      </tr>
      <tr height="70" valign="bottom">
        <td align="left">
          The Curator
        </td>
      </tr>
	</table>
  </xsl:template>

  <xsl:template name="LoanBalance">
    <table cellspacing="0" cellpadding="1" width="{$PageWidth}" border="0" style="{$FontDefault}">
      <tr>
      <td height="40" valign="top" colspan="2">
        <b>
          Loan no. <xsl:value-of select="./From/FromTransactionNumber"/>: <xsl:value-of select="./NumberOfSpecimenOnLoan"/> specimen(s) [
          <xsl:text> </xsl:text>
          <xsl:call-template name="Balance"/> ]
        </b>
      </td>
    </tr>
    </table>
  </xsl:template>

  <xsl:template match="text"></xsl:template>
</xsl:stylesheet>