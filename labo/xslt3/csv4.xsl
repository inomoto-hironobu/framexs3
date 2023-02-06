<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:csv="urn:csv">
  <xsl:import href="csv3.xsl" />
  <xsl:param name="encoding" select="'windows-31j'"></xsl:param>
    <xsl:template name="xsl:initial-template">
        <xsl:analyze-string select="unparsed-text('sample.csv')" regex="(&quot;[^&quot;]|(&quot;&quot;)+&quot;)|[^,\n\r]+">
                <xsl:matching-substring>
                    <xsl:message><xsl:value-of select="."></xsl:value-of></xsl:message>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:message><xsl:value-of select="."/></xsl:message>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
    </xsl:template>
</xsl:stylesheet>