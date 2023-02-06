<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="application/xml" href="vendor.xsl"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" media-type="text/plain"/>
	<xsl:template match="/">
		<xsl:value-of select="system-property('xsl:vendor')"></xsl:value-of>
	</xsl:template>
</xsl:stylesheet>
