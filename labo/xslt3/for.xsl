<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:nf="https://nandaka-furari.github.io/">
    <xsl:output method="text" encoding="UTF-8"/>
    <xsl:param name="a"/>
    <xsl:param name="b"/>
    <xsl:template match="/">
        <xsl:value-of select="nf:forplus($a,$b)"></xsl:value-of>
    </xsl:template>

    <xsl:function name="nf:forplus" as="xs:integer">
    	<xsl:param name="a" as="xs:integer"/>
    	<xsl:param name="b" as="xs:integer"/>
    	<xsl:choose>
    		<xsl:when test="$b > 0">
    			<xsl:value-of select="nf:helloworld($a + $a, $b - 1)"></xsl:value-of>
    		</xsl:when>
    		<xsl:otherwise>
    			<xsl:value-of select="$a"></xsl:value-of>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:function>
</xsl:stylesheet>