<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text"/>
	<xsl:template match="/">
		<xsl:text>&#010;current-time=</xsl:text>
		<xsl:value-of select="current-time()"/>
		
		<xsl:text>&#010;base-uri=</xsl:text>
		<xsl:value-of select="base-uri()"/><xsl:text>&#010;</xsl:text>
		
		<xsl:text>&#010;document-uri=</xsl:text>
		<xsl:value-of select="document-uri(.)"/>
		
		<xsl:text>&#010;document-uri=</xsl:text>
		<xsl:value-of select="document-uri(/*)"/>
		
		<xsl:text>&#010;boolean(doc('./sample.xsl'))=</xsl:text>
		<xsl:value-of select="boolean(doc('./sample.xsl'))"/>
		
		<xsl:text>&#010;document('./sample.xsl')=</xsl:text>
		<xsl:value-of select="boolean(document('./sample.xsl'))"/>
		
		<xsl:text>&#010;resolve-uri=</xsl:text>
		<xsl:value-of select="resolve-uri('./test')"/>
		
		<xsl:text>&#010;</xsl:text>
		<xsl:value-of select="document-uri(root())"/>
		<!--        
		<xsl:text>&#010;</xsl:text>
		<xsl:value-of select=""/>
		-->
		<xsl:apply-templates></xsl:apply-templates>
	</xsl:template>
	<xsl:template match="*">
		<xsl:text>&#010;base-uri()=</xsl:text>
		<xsl:value-of select="base-uri()"/>
		<xsl:text>&#010;document-uri()=</xsl:text>
		<xsl:value-of select="document-uri(.)"/>
		
	</xsl:template>
</xsl:stylesheet>