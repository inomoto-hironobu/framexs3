<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xb="http://www.python.org/topics/xml/xbel/"
	xmlns="http://www.w3.org/1999/xhtml"
	version="2.0">
	<xsl:param name="comx" select="/processing-instruction('comx')"/>
   <!-- xsd:schema -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="xb:xbel">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="xb:root" mode="comx">
		<xsl:apply-templates mode="comx"/>
	</xsl:template>
	
	<xsl:template match="xb:folder" mode="comx">
		<div>
			<div><xsl:value-of select="@name"/></div>
			<xsl:apply-templates mode="comx"/>
		</div>
	</xsl:template>
	
	<xsl:template match="xb:root" mode="export">
		<dl>          
			<dt><xsl:apply-templates/></dt>
		</dl>
	</xsl:template>
	
	<xsl:template match="xb:folder" mode="export">
		<h3><xsl:value-of select="@name"/></h3>
		<dl>
			<dt><xsl:apply-templates/></dt>
		</dl>
	</xsl:template>
	
	<xsl:template match="xb:ref" mode="export">
		<a href="{text()}"><xsl:value-of select="key('bookmarks', text())"/></a>
	</xsl:template>
	
	<xsl:key match="/xb:xbel/xb:bookmarks/xb:bookmark" name="bookmarks" use="@uri"/>
	
	<xsl:template match="xb:bookmarks" mode="export"></xsl:template>
</xsl:stylesheet>
