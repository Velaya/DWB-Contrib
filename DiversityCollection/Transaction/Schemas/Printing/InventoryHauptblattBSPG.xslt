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
        <xsl:call-template name="InventoryHeader"/>
        <xsl:call-template name="TransactionList"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="InventoryHeader">
    <table cellspacing="0" cellpadding="1" width="630" border="0" style="{$FontDefault}">
      <tr height="30" valign="top">
        <td align="center" style="{$FontBig}">
          <b>
            <xsl:value-of select="./Transaction/TransactionTitle"/>
          </b>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="TransactionList">
    <table cellspacing="0" cellpadding="1" width="630" border="0" style="{$FontDefault}">
      <xsl:for-each select="./Transaction">
        <xsl:if test="position() != 1">
          <tr height="30">
            <td></td>
          </tr>
          <tr height="30" valign="top">
            <td align="left">
              <xsl:choose>
                <xsl:when test="./HierarchyLevel = '2'">
                  <b><xsl:value-of select="./TransactionTitle"/></b>
                </xsl:when>
                <xsl:when test="./HierarchyLevel = '3'">
                  <xsl:value-of select="./TransactionTitle"/>
                </xsl:when>
              </xsl:choose> 
            </td>
            <td width="10%">
          </td>
          <td align="left" style="{$FontDefault}" width="90%">
            <xsl:value-of select="./MaterialDescription"/>
          </td>
        </tr>
        </xsl:if>
      </xsl:for-each>
    </table>
  </xsl:template>

  <xsl:template match="text"></xsl:template>
</xsl:stylesheet>