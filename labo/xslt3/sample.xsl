<?xml version="1.1" encoding="UTF-8"?>
<?xml-stylesheet type="text/css" href="../../../css/ns/xslt.css"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:s="urn:sample">

	<xsl:output method="text" indent="yes" omit-xml-declaration="yes"/>

	<xsl:param name="hoge">test</xsl:param>
	
	<xsl:key name="tets" match="s:sample" use="@test"></xsl:key>
	
	<xsl:template match="/">
		document-uri(/):<xsl:value-of select="document-uri(/)"/>
		base-uri:<xsl:value-of select="base-uri(/)"></xsl:value-of>
		element:<xsl:value-of select="node-name(*)"/>
		<xsl:value-of select="key('tets', *)"/>
		<xsl:apply-templates/>
		<xsl:variable name="entries">abcde</xsl:variable>
        <xsl:variable name="i" select="4"></xsl:variable>
        <xsl:variable name="x">!</xsl:variable>
		<xsl:message><xsl:value-of select="substring($entries,$i,1)"></xsl:value-of></xsl:message>
        <xsl:message>
            <xsl:for-each select="random-number-generator()['next']?permute(1 to $i)">
                <xsl:message><xsl:value-of select="."></xsl:value-of></xsl:message>
            </xsl:for-each>
            <xsl:value-of select="random-number-generator()['next']?permute(1 to 7)"></xsl:value-of>
        </xsl:message>
	</xsl:template>
	
	<xsl:template match="s:test">
		<div>

		</div>
	</xsl:template>
	<xsl:template match="s:*[framexs:*]">
		
	</xsl:template>
	<xsl:template match="*">
		&lt;<xsl:value-of select="name()"/>&gt;
		<xsl:for-each select="@*">
			<xsl:if test="not(name() = 'href')">
			<xsl:variable name="name" select="name()"></xsl:variable>
			<xsl:value-of select="name()"/>
		 	<xsl:text>="</xsl:text>
		 	<xsl:value-of select="current()"/>
		 	<xsl:text>" </xsl:text>
			</xsl:if>
		</xsl:for-each>
		<xsl:choose>
          <xsl:when test="@href">
            <a href="">
				<xsl:apply-templates></xsl:apply-templates>
			</a>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates></xsl:apply-templates>
          </xsl:otherwise>
        </xsl:choose>
		
		<xsl:apply-templates select="@*"  mode="att"></xsl:apply-templates>
		<xsl:apply-templates></xsl:apply-templates>
		&lt;/<xsl:value-of select="name()"/>&gt;
	</xsl:template>
</xsl:stylesheet>
