<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:csv="urn:csv">
    
    <xsl:function name="csv:parse-csv" as="node()">
        <xsl:param name="text" as="item()"></xsl:param>
        <csv xmlns="urn:csv">
            <xsl:analyze-string select="$text" regex="&quot;(([^&quot;]|&quot;&quot;)*)&quot;">
                <xsl:matching-substring>
                    <xsl:message><xsl:value-of select="."></xsl:value-of></xsl:message>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:message>test:<xsl:value-of select="."/></xsl:message>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </csv>
    </xsl:function>
</xsl:stylesheet>