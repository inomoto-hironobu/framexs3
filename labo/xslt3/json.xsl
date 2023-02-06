<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array"
    version="3.0">
    <xsl:param name="command">default</xsl:param>
    <xsl:param name="input" select="'sample.json'"></xsl:param>
    <xsl:variable as="map(*)" name="jsonMap" select="fn:json-doc($input)"/>
    
    <xsl:template match="/xsl:stylesheet">
    	<xsl:variable name="json" select="fn:unparsed-text($input) => fn:json-to-xml()"></xsl:variable>
    	<xsl:choose>
    		<xsl:when test="$command = 'default'">
    			<xsl:value-of select="map:get($jsonMap, 'test') => map:get('array') => array:head()" />
    		</xsl:when>
    		<xsl:when test="$command = 'toxml'">
    			<xsl:variable as="node()" name="json-text" select="fn:unparsed-text($input) => fn:json-to-xml()"/>
    			<xsl:result-document href="dest.txt" method="xml">
    				<xsl:copy-of select="$json-text"/>
    			</xsl:result-document>
    			
    		</xsl:when>
    		<xsl:otherwise>
    			<xsl:apply-templates select="$json/*"/>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>
    <xsl:template match="fn:string[@key='name']">
    	<name><xsl:value-of select="."/></name>
    </xsl:template>
    <xsl:template match="fn:*">
    	<xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>