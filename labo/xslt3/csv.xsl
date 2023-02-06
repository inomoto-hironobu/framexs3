<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:scsv="urn:scsv">
  <xsl:param name="url" select="'https://www.nsgd.co.jp/nsd/NSDGoods/mswin_tl/Kojiky5/CsvSample2.csv'"></xsl:param>
  <xsl:param name="encoding" select="'windows-31j'"></xsl:param>
    <xsl:template match="/">
    	<xsl:message>download from ...<xsl:value-of select="$url"/></xsl:message>
    	<!--生CSVから改行をタグに変換する-->
        <xsl:variable name="r1">
        	<xsl:text>&lt;tr&gt;</xsl:text>
            <xsl:analyze-string select="unparsed-text($url,$encoding)" regex="(\r)?\n">
                <xsl:matching-substring>
                	<xsl:text>&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td&gt;</xsl:text>
				</xsl:matching-substring>
                <xsl:non-matching-substring>
                	<xsl:value-of select="."/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
            <xsl:text>&lt;/tr&gt;</xsl:text>
        </xsl:variable>
        <!--r1からコンマをタグに変換する-->
         <xsl:variable name="r2">
        	<xsl:analyze-string select="$r1" regex=",">
               <xsl:matching-substring>
            	   <xsl:text>&lt;/td&gt;&lt;td&gt;</xsl:text>
               </xsl:matching-substring>
                <xsl:non-matching-substring>
                	<xsl:value-of select="."/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:variable>
        <!-- r2を出力 -->
        <xsl:result-document method="text" href="dest.txt">
            <xsl:value-of select="$r2"></xsl:value-of>
        </xsl:result-document>
    </xsl:template>
    <xsl:function name="scsv:parse-scsv">
        
    </xsl:function>
</xsl:stylesheet>