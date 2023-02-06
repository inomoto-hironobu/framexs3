<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:f="urn:function" version="3.0">
	<xsl:template match="/">
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:function name="f:helloworld">
	</xsl:function>
	<xsl:param name="a"/>
    <xsl:param name="b"/>
    <xsl:template match="/">
        <xsl:value-of select="nf:add($a,$b)"></xsl:value-of>
    </xsl:template>
    <xsl:function name="nf:add" as="xs:integer">
    	<xsl:param name="a"/>
    	<xsl:param name="b"/>
        <xsl:value-of select="$a + $b"></xsl:value-of>
    </xsl:function>
</xsl:stylesheet>