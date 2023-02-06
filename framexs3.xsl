<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xh="http://www.w3.org/1999/xhtml"
	xmlns:f="urn:framexs"
	xmlns:fp="urn:framexs-properties"
	xmlns:fc="urn:framexs-commands"
	xmlns:fr="urn:framexs-resource"
	version="3.0">
	<xsl:output encoding="UTF-8" media-type="text/html" method="xml"/>

	<!-- skeleton_locが指定されればXHTMLテンプレート処理を行う -->
	<xsl:param name="skeleton_loc" select="/processing-instruction('framexs.skeleton')"/>
	<xsl:param name="properties_loc" select="/processing-instruction('framexs.properties')"/>
	<xsl:param name="commands_loc" select="/processing-instruction('framexs.commands')"/>
    <xsl:variable name="contents" as="" select="/"/>
	<xsl:param name="skeleton">
		<xsl:choose>
			<xsl:when test="$skeleton_loc">
				<xsl:value-of select="$skeleton_loc"></xsl:value-of>
			</xsl:when>
			<xsl:when test="$commands_loc">
				<xsl:value-of select="document($commands_loc)/fc:commands/fc:skeleton/text()"></xsl:value-of>
			</xsl:when>
		</xsl:choose>
	</xsl:param>
    <xsl:variable name="version" as="" select="'0.1'"/>
    <!-- 処理を始める -->
	<xsl:template match="/">
		<xsl:message select="'debug message'"/>
		<xsl:choose>
			<xsl:when test="$skeleton">
				<xsl:apply-templates select="$skeleton/f:fsml/f:skeleton/*[1]"></xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message>スケルトンが指定されていません。</xsl:message>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- 一般要素の処理　ただ単に同じ -->
	<xsl:template match="*">
		<xsl:element name="{name()}" namespace="{namespace-uri(.)}">
			<xsl:copy-of select="@*"/>
			<xsl:for-each select="f:attribute">
				<xsl:attribute name="{@name}">
				</xsl:attribute>
			</xsl:for-each>
			<xsl:apply-templates></xsl:apply-templates>
		</xsl:element>
	</xsl:template>
	
	<!-- スタイルシートからの呼び出しタグ -->
	
	<xsl:template match="f:version">
		<xsl:value-of select="$version"/>
	</xsl:template>
    <xsl:template match="f:id" mode="#default">
        
    </xsl:template>
    <xsl:template match="f:fetch" mode="#default">
        <xsl:evaluate as="" context-item="$contents" xpath="{@xpath}"></xsl:evaluate>
    </xsl:template>
    <xsl:template match="f:*" mode="#default">
        
    </xsl:template>
</xsl:stylesheet>