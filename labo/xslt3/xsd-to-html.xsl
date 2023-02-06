<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xs="http://www.w3.org/2001/XMLSchema"
        xmlns:xh="http://www.w3.org/1999/xhtml"
        xmlns:framexs="urn:framexs"
        version="3.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html"/>                                        
    <xsl:param name="skeleton_loc" select="/processing-instruction('framexs.template')"/>
	<xsl:variable name="content" select="/"/>
	<xsl:variable name="xhns" select="'http://www.w3.org/1999/xhtml'"/>
	<xsl:variable name="xsns" select="'http://www.w3.org/2001/XMLSchema'"/>
    <xsl:template match="/">
    	<xsl:variable name="skeleton" select="document($skeleton_loc)"></xsl:variable>
    	<xsl:choose>                                           
			<xsl:when test="$skeleton_loc and namespace-uri($skeleton/*[1]) = $xhns">
				<xsl:message>content</xsl:message>
				<xsl:apply-templates select="document($skeleton_loc)/*"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message>一般XML</xsl:message>
				<html>
					<head>
						<title>エラー</title>
					</head>
					<body>
						<p>テンプレートは名前空間(<xsl:value-of select="$xhns"/>)を持ったXHTMLを指定してください</p>
					</body>
				</html>
			</xsl:otherwise>
		</xsl:choose>
    </xsl:template>

	<xsl:template match="xh:*">
		<xsl:element name="{name()}">
			<xsl:for-each select="@*">
				<xsl:copy-of select="."/>
			</xsl:for-each>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="xh:*[@framexs:name]" mode="for">
		<xsl:apply-templates select="ancestor::xs:*[@name]"></xsl:apply-templates>
	</xsl:template>

	<xsl:template match="xh:*" mode="for">
		<xsl:param name="to"/>
		<xsl:element name="{name()}">
			<xsl:for-each select="@*">
				<xsl:copy-of select="."/>
			</xsl:for-each>
			<xsl:apply-templates mode="for">
				<xsl:with-param name="to" select="$to"/>
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>

	<xsl:function name="framexs:fetch">

	</xsl:function>
	<xsl:template match="framexs:group">
		<xsl:apply-templates select="$content/xs:schema/xs:group"></xsl:apply-templates>
	</xsl:template>
	<xsl:template match="framexs:attrGroup">
		<xsl:apply-templates select="$content/xs:schema/xs:attributeGroup"></xsl:apply-templates>
	</xsl:template>
	<xsl:template match="framexs:for-top">
		<xsl:for-each select="$content/xs:*[name() = @elem]">
			<xsl:apply-templates mode="in-for-top">
				<xsl:with-param name="target" select="." as="node()"></xsl:with-param>
			</xsl:apply-templates>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="framexs:item">
		item
	</xsl:template>
	<xsl:template match="xh:*" mode="in-for-top">
		<xsl:param name="target" as="node()"></xsl:param>
		<xsl:element name="{name()}">
			<xsl:apply-templates>
				<xsl:with-param name="target" select="$target"></xsl:with-param>
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>

    <xsl:template match="xs:include">
    	<xsl:element name="a">
    		<xsl:attribute name="href"><xsl:value-of select="@schemaLocation"/></xsl:attribute>
    	</xsl:element>
    </xsl:template>

    <xsl:template match="xs:schema/xs:complexType">
    	[ct]<xsl:value-of select="@name"/>_
    </xsl:template>

    <xsl:template match="xs:schema/xs:attributeGroup">
        @<xsl:value-of select="@name"/>_
    </xsl:template>

    <xsl:template match="xs:schema/xs:simpleType">
        [t]<xsl:value-of select="@name"/>_
    </xsl:template>

    <xsl:template match="xs:schema/xs:element">
        [e]<xsl:value-of select="@name"/>_
    </xsl:template>

    <xsl:template match="xs:attribute">
        <xsl:if test="@name">
            <xsl:value-of select="@name"/>
            :
            <xsl:value-of select="@type"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="xs:group[@ref]">
        <xsl:text>%</xsl:text>
        <a href="#{@ref}">
            <xsl:value-of select="@ref"/>
        </a>
        <xsl:text>;</xsl:text>
        <xsl:if test="@maxOccurs='unbounded'">
            <xsl:text>*</xsl:text>
        </xsl:if>
    </xsl:template>


    <xsl:template match="xs:attributeGroup[@ref]">
        <a href="#{@ref}">
            <xsl:value-of select="@ref"/>
        </a>
    </xsl:template>

    <xsl:template match="xs:choice | xs:sequence | xs:all">
        <xsl:variable name="count" select="count(*)"/>
        <xsl:variable name="name" select="local-name()"/>
        <xsl:text>(</xsl:text>
        <xsl:for-each select="*">
            <xsl:apply-templates select="."/>
            <xsl:if test="$count - position()">
                <xsl:if test="$name = 'choice'">
                    <xsl:text>|</xsl:text>
                </xsl:if>
                <xsl:if test="$name = 'sequence'">
                    <xsl:text>,</xsl:text>
                </xsl:if>
                <xsl:if test="$name = 'all'">
                    <xsl:text>&amp;</xsl:text>
                </xsl:if>
            </xsl:if>
        </xsl:for-each>
        <xsl:if test="@maxOccurs='unbounded'">
            <xsl:text>*</xsl:text>
        </xsl:if>
        <xsl:text>)</xsl:text>
    </xsl:template>

    <xsl:template match="xs:complexContent">
    	<div class="complexContent">
    		<xsl:apply-templates/>
    	</div>
    </xsl:template>

    <xsl:template match="xs:simpleContent">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="xs:restriction">
        <a href="#{@base}">
            <xsl:value-of select="@base"/>
        </a>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="xs:extension">
        <a href="#{@base}">
            <xsl:value-of select="@base"/>
        </a>
        <div class="extension">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <!-- xs:annotation -->
    <xsl:template match="xs:annotation">
        <div class="annotation">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="xs:documentation">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="xs:*">
        [<xsl:value-of select="name()"/>]<xsl:value-of select="@name"></xsl:value-of>_
    </xsl:template>                                                         
</xsl:stylesheet>
