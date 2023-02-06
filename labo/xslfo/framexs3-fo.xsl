<?xml version="1.0"?>
<!-- XHTMLからXSL-FOを生成する -->
<xsl:stylesheet
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xh="http://www.w3.org/1999/xhtml"
		xmlns:f="urn:framexs"
		version="3.0">
	<xsl:output media-type="application/xml"/>
	<xsl:param name="template_location"/>
	<xsl:param name="template_string"/>
	<xsl:param name="template" select="f:template()" as="node()"/>
	<xsl:variable name="content" select="/"/>
	<xsl:template match="/xh:*">
		<xsl:message select="'debug message'"/>
		<x>
		<xsl:if test="$template">
			<xsl:apply-templates select="$template/fo:root"></xsl:apply-templates>
		</xsl:if>
		</x>
	</xsl:template>
	<xsl:template match="fo:*">
		<xsl:element name="{name()}">
			<xsl:apply-templates></xsl:apply-templates>
		</xsl:element>
	</xsl:template>
	<xsl:template match="f:for[@target]" mode="#default">
		<xsl:if test="@target">
			<xsl:for-each select="*">
				
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	<xsl:function name="f:template" as="node()">
		<xsl:choose>
			<xsl:when test="$template_string">
				<xsl:sequence select="parse-xml($template_string)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$template_location">
					<xsl:sequence select="document($template_location)"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
</xsl:stylesheet>