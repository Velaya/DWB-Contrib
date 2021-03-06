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
          <xsl:call-template name="Footer"/>
          <h1 style="page-break-before:left"></h1>
          <xsl:call-template name="Header"/>
          <xsl:call-template name="LoanBalance"/>
          <xsl:call-template name="SpecimenList"/>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="Text">
    <table cellspacing="0" cellpadding="1" width="{$PageWidth}" border="0" style="{$FontDefault}">
      <tr height="50" valign="bottom">
        <td align="right" style="{$FontDefault}">
          <xsl:value-of select="./From/Collection/CollectionAddress/City"/>, <xsl:value-of select="./Date"/>
        </td>
      </tr>
      <tr height="50" valign="bottom">
        <td align="left" style="{$FontDefault}">
          The <xsl:value-of select="./From/Collection/CollectionOwner"/> is sending you as a loan
          the herbarium specimen(s) specified in the list attached.
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
      <tr height="50" valign="bottom">
        <td align="left">
          The Curator
        </td>
      </tr>
    </table>
  </xsl:template>

  <!--xsl:template name="Footer">
    <table cellspacing="0" cellpadding="1" width="{$PageWidth}" border="0" style="{$FontSmall}">
      <tr height="50" valign="bottom">
        <td align="left" colspan="2">
          Re: Determinavit labels, written in permantne ink or typed and signed, should be added to each collection return.
        </td>
      </tr>
      <tr>
        <td align="left" style="padding-bottom:10px; border-bottom:1px dotted #000000" colspan="2">
          Any information which might be of value to furture researchers should be provided.
        </td>
      </tr>
      <tr>
        <td align="left" style="{$FontDefault}" colspan="2">
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
      <tr height="150" valign="bottom">
        <td align="center" style="{$FontDefault}" colspan="2">
          1
        </td>
      </tr>
    </table>
  </xsl:template-->

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

  <xsl:template match="text"></xsl:template>
</xsl:stylesheet>