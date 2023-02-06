<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:pom="http://maven.apache.org/POM/4.0.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text"></xsl:output>
	<xsl:template match="pom:dependency">
		<dependency>
			<xsl:attribute name="org">
				<xsl:value-of select="pom:groupId"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="name">
				<xsl:value-of select="pom:artifactId"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="rev">latest.integration</xsl:attribute>
		</dependency>
		<dependency org="{pom:groupId}" name="{pom:artifactId}" rev="{pom:version}"/>
	</xsl:template>
</xsl:stylesheet>