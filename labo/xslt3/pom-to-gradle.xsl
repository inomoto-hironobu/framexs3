<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pom="http://maven.apache.org/POM/4.0.0"
                version="2.0">
    <xsl:output method="text"/>
    <xsl:template match="pom:dependency">
        <xsl:text>group:'</xsl:text>
        <xsl:value-of select="pom:groupId"/>
        <xsl:text>', name:'</xsl:text>
        <xsl:value-of select="pom:artifactId"/>
        <xsl:text>', version:'</xsl:text>
        <xsl:value-of select="pom:version"/>
        <xsl:text>'</xsl:text>
    </xsl:template>
</xsl:stylesheet>
