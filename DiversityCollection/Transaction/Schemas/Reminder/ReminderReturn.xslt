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
          <xsl:call-template name="Header"/>
          <xsl:call-template name="HeaderAddress"/>
          <xsl:call-template name="ReturnAddress"/>
          <xsl:call-template name="Address"/>
          <xsl:call-template name="Text"/>
          <xsl:call-template name="FooterLabels"/>
          <!--h1 style="page-break-before:left"></h1>
          <xsl:call-template name="Header"/>
          <xsl:call-template name="LoanBalance"/>
          <xsl:call-template name="SpecimenList"/-->
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="Text">
    <table cellspacing="0" cellpadding="1" width="{$PageWidth}" border="0" style="{$FontDefault}">
		<!-->tr height="50" valign="bottom">
			<td align="right" style="{$FontDefault}">
			  <xsl:value-of select="./From/Collection/CollectionAddress/City"/>, <xsl:value-of select="./Date"/>
			</td>
		</tr-->
		<tr height="50" valign="bottom">
			<td align="right" style="{$FontDefault}">
				<xsl:value-of select="./From/Address/City"/>,
				<xsl:value-of select="./Date"/>
				<!--xsl:choose>
					<xsl:when test="./BeginDate">
						<xsl:value-of select="./BeginDate"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="./Date"/>
					</xsl:otherwise>
				</xsl:choose-->
			</td>
		</tr>
		<tr height="50" valign="bottom">
			<td align="left" style="{$FontDefault}">
				<b>Reminder of return</b>
			</td>
		</tr>
		<!--tr height="50" valign="bottom">
			<td align="left" style="{$FontDefault}">
				Dear
				<xsl:choose>
				<xsl:when test="./To/Address/PersonName != ''">
					<xsl:value-of select="./Address/To/PersonName"/>
				</xsl:when>
					<xsl:otherwise>
						Director
					</xsl:otherwise>
				</xsl:choose>,
			</td>
		</tr-->
		<tr height="50" valign="bottom">
			<td align="left" style="{$FontDefault}">
				This is to kindly remind you, that the time granted for the
			</td>
		</tr>
		<!--tr height="50" valign="bottom">
        <td align="left" style="{$FontDefault}">
          The <xsl:value-of select="./From/Collection/CollectionOwner"/> sent you as a loan
          the herbarium specimen(s) specified in the list attached.
        </td>
      </tr-->
      <xsl:if test="./From/FromTransactionNumber != ''">
        <tr height="50" valign="bottom">
          <td align="left">
            Loan no. <xsl:value-of select="./From/FromTransactionNumber"/> (<xsl:value-of select="./NumberOfSpecimenInitial"/>)
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="./Investigator != ''">
        <tr height="15" valign="bottom">
          <td align="left">
            For study by: <xsl:value-of select="./Investigator"/>
          </td>
        </tr>
      </xsl:if>
		<tr height="15" valign="bottom">
        <td align="left">
          Number of specimens returned: <xsl:value-of select="./NumberOfSpecimenReturned"/>
        </td>
      </tr>
		<tr height ="15" valign="bottom">
			<td align="left">
				Number of still outstanding specimens: <xsl:value-of select="./NumberOfSpecimenOnLoan"/>
			</td>
		</tr>
		<tr height ="30" valign="bottom">
			<td align="left">
				has expired in  <xsl:value-of select="./AgreedEndDate"/>.
		</td>
		</tr>
		<tr height="30">
        <td align="left">
          This material is still out an we would appreciate the return of the specimens.
        </td>
      </tr>
		<tr height="30">
			<td align="left">
				Thank you for your cooperation in this matter.
			</td>
		</tr>
		<tr height ="20">
			<td align="left">
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
			Secretarial office
		</td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="LoanBalance">
    <table cellspacing="0" cellpadding="1" width="{$PageWidth}" border="0" style="{$FontDefault}">
      <tr>
      <td height="40" valign="bottom" colspan="2">
        <b>
          Loan no. <xsl:value-of select="./FromTransactionNumber"/>: <xsl:value-of select="./NumberOfSpecimenOnLoan"/> specimen(s) [
          <xsl:text> </xsl:text>
          <xsl:call-template name="Balance"/> ]
        </b>
      </td>
    </tr>
    </table>
  </xsl:template>

	<xsl:template name="FooterLabels">
		<table cellspacing="0" cellpadding="1" width="{$PageWidth}" border="0" style="{$FontSmall}">
			<tr height="50" valign="bottom">
				<td align="left" colspan="2">
					Re: Determinavit labels, written in permanent ink or typed and signed, should be added to each collection return.
				</td>
			</tr>
			<tr>
				<td align="left" colspan="2">
					Any information which might be of value to future researchers should be provided.
				</td>
			</tr>
		</table>
	</xsl:template>




	<xsl:template match="text"></xsl:template>
</xsl:stylesheet>