<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:f="urn:function" version="3.0">

	<xsl:output method="text"/>
	<xsl:variable name="strs" as="item()*">
		<xsl:sequence>testd</xsl:sequence>
		<xsl:sequence><f:test/></xsl:sequence>
		<xsl:sequence>dd</xsl:sequence>
	</xsl:variable>
	<xsl:template match="/xsl:stylesheet">
		<xsl:for-each select="['t','s']">
			e
		</xsl:for-each>
		<xsl:for-each select="$strs">
			n
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>