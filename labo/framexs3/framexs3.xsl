<?xml version="1.0"?>
<!-- XHTMLからXSL-FOを生成する -->
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xh="http://www.w3.org/1999/xhtml"
	xmlns:f="urn:framexs"
	version="3.0">
	<xsl:output media-type="application/xml" method="xml" />
	<xsl:variable name="version" as="xs:string" select="'0.1'"/>
	<xsl:param name="skeleton_location"/>
	<xsl:param name="skeleton_string"/>
	<xsl:param name="skeleton" select="f:skeleton()" as="node()?"/>
	<xsl:param name="commands"/>
	<xsl:variable name="content" select="/"/>
	<!-- 処理を始める -->
	<xsl:template match="/">
		<xsl:message select="'debug message'"/>
		<xsl:choose>
			<xsl:when test="$skeleton">
				<xsl:apply-templates select="$skeleton/xh:html"></xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message>スケルトンが指定されていません。</xsl:message>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="xh:*">
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
	
	<!-- コンテンツからの呼び出しタグ -->
	<xsl:template match="f:title">
		<xsl:value-of select="$content/xh:html/xh:head/xh:title"/>
	</xsl:template>
	<xsl:template match="f:script">
		<xsl:for-each select="$content/xh:html/xh:head/xh:script">
			<xsl:copy-of select="."/>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="f:style">
		<xsl:for-each select="$content/xh:html/xh:head/xh:style">
			<xsl:copy-of select="."/>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="f:link">
		<xsl:for-each select="$content/xh:html/xh:head/xh:link">
			<xsl:copy-of select="."/>
		</xsl:for-each>
	</xsl:template>
	<!-- id="contents"の要素の子供要素をコピーする -->
	<xsl:template match="f:contents">
		<xsl:copy-of select="($content//*[@id = 'contents'])[1]/*"/>
	</xsl:template>

	<!-- 指定したid属性の要素の子供をコピーする -->
	<xsl:template match="f:id[@name]" mode="#default">
		<xsl:copy-of select="($content//*[@id = @name])[1]/*"/>
	</xsl:template>

	<!-- XPathの実行を試し、trueなら中身を反映する -->
	<xsl:template match="f:if" mode="#default">
		<xsl:variable name="result" as="xs:boolean">
			<xsl:try>
				<xsl:evaluate as="xs:boolean" xpath="@xpath" context-item="$content" xpath-default-namespace="http://www.w3.org/1999/xhtml"></xsl:evaluate>
				<xsl:catch>
					<xsl:message select="'XPath実行に失敗しました。'"/>
					<xsl:sequence select="false()"/>
				</xsl:catch>
			</xsl:try>
		</xsl:variable>
		<xsl:if test="$result">
			<xsl:apply-templates/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="f:meta[@name]" mode="#default">
		<xsl:value-of select="$content/xh:html/xh:head/xh:meta[@name = @name]/@content"/>
	</xsl:template>

	<xsl:template match="f:for[@target]" mode="#default">
		<xsl:if test="@target">
			<xsl:for-each select="*">
				t
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	
	<!-- コンテンツをコンテキストとしてXPathを実行する -->
	<xsl:template match="f:xpath" mode="#default">
		<xsl:evaluate xpath="@value" context-item="$content" xpath-default-namespace="http://www.w3.org/1999/xhtml"></xsl:evaluate>
	</xsl:template>
	<!-- 定義されていないFramexs要素をチェックし、ログに残す -->
	<xsl:template match="f:*" mode="#default">
		<xsl:message select="concat('定義されていない',name(.),'が検出されました。')"/>
	</xsl:template>
	<!-- テンプレートをDOMとして取る -->
	<xsl:function name="f:skeleton" as="node()?">
		<xsl:choose>
			<xsl:when test="$skeleton_string">
				<xsl:sequence select="parse-xml($skeleton_string)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$skeleton_location">
						<xsl:sequence select="document($skeleton_location)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:sequence>
						</xsl:sequence>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
</xsl:stylesheet>