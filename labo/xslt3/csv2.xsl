<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="urn:test" xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xsl:param name="url" select="'https://www.nsgd.co.jp/nsd/NSDGoods/mswin_tl/Kojiky5/CsvSample2.csv'"></xsl:param>
  <xsl:param name="encoding" select="'utf-8'"></xsl:param>
    <xsl:template match="/">
    	<!-- 2*3の配列になるはずが,ならない-->
    	<xsl:variable name="arr" select="(1,2,3),(2,3,4)"></xsl:variable>
    	
    	<!-- 2*3の配列になるはずが,ならない -->
    	<xsl:variable name="arr2" as="item()*">
    		<xsl:sequence select="(1,2,3)"/>
    		<xsl:sequence select="(2,3,4)"/>
    	</xsl:variable>
    	
    	<!-- 配列からメッセージを出す -->
    	<xsl:for-each select="$arr2">
    		<!-- 配列からコンマ区切りの文字列を生成 -->
    		<xsl:variable name="seq">
				<xsl:for-each select=".">
					<xsl:value-of select="."/>
					<xsl:text>,</xsl:text>
				</xsl:for-each>
    		</xsl:variable>
    		<xsl:message>[<xsl:value-of select="$seq"/>]</xsl:message>
    	</xsl:for-each>
    	<!-- サンプル生CSV -->
    	<xsl:variable name="csv">番号,名前
1,太郎
2,花子</xsl:variable>
    	<xsl:message>sequence...</xsl:message>
    	<xsl:apply-templates select="t:sample-seq($csv)"></xsl:apply-templates>
    	<xsl:message>sequence...</xsl:message>
    	<xsl:for-each select="t:sample-seq($csv)">
    		<xsl:for-each select="tr">
    			<xsl:message>
    			<xsl:for-each select="td">
    				<xsl:value-of select="."/>
    			</xsl:for-each>
    			</xsl:message>
    		</xsl:for-each>
    	</xsl:for-each>
    </xsl:template>
    <xsl:template match="table">
    	<xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tr">
    	<xsl:message>[<xsl:apply-templates>
    		<xsl:with-param name="len" select="count(*)"></xsl:with-param>
    	</xsl:apply-templates>]</xsl:message>
    </xsl:template>
    <xsl:template match="td">
    	<xsl:param name="len"></xsl:param>
    	<xsl:value-of select="."/>
    	<xsl:if test="position() != $len">
    	<xsl:text>|</xsl:text>
    	</xsl:if>
    </xsl:template>
    
    <!-- サンプル配列を生成する -->
    <xsl:function name="t:sample-seq" as="node()">
    	<xsl:param name="rawcsv"/>
    	<table>
    	<xsl:analyze-string select="$rawcsv" regex="(\r)?\n">
    		<xsl:non-matching-substring>
    			<xsl:sequence select="t:data(.)">
    			</xsl:sequence>
    		</xsl:non-matching-substring>
    	</xsl:analyze-string>
    	</table>
    </xsl:function>
    
    <xsl:function name="t:data" as="node()*">
    	<xsl:param name="data" as="xs:string"/>
    	<tr>
    	<xsl:analyze-string select="$data" regex=",">
			<xsl:non-matching-substring>
				<xsl:sequence>
					<td><xsl:value-of select="."/></td>
				</xsl:sequence>
			</xsl:non-matching-substring>
		</xsl:analyze-string>
		</tr>
    </xsl:function>
</xsl:stylesheet>