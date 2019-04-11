<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="/">
		<rss version="2.0">
			<channel>
				<title>Producto 3</title>
				<link>http://localhost/result.rss</link>
				<description>RSS Feed del producto 3</description>
				<xsl:for-each select="contenido/tema">
					<item>
						<title><xsl:value-of select="./@titulo" /></title>
						<xsl:variable name="ancla"><xsl:value-of select="./@ancla" /></xsl:variable>
				    	<link>./result.htm#<xsl:value-of select="$ancla" /></link>
				    	<description/>
					</item>
					<xsl:if test = "subtema">
						<xsl:for-each select="subtema">
							<item>
								<title><xsl:value-of select="./@titulo" /></title>
								<xsl:variable name="ancla2"><xsl:value-of select="./@ancla" /></xsl:variable>
						    	<link>./result.htm#<xsl:value-of select="$ancla2" /></link>
						    	<description/>
							</item>
							<xsl:if test = "subsubtema">
								<xsl:for-each select="subsubtema">
									<item>
										<title><xsl:value-of select="./@titulo" /></title>
										<xsl:variable name="ancla3"><xsl:value-of select="./@ancla" /></xsl:variable>
								    	<link>./result.htm#<xsl:value-of select="$ancla3" /></link>
								    	<description/>
									</item>
								</xsl:for-each>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
				</xsl:for-each>
			</channel>
		</rss>
	</xsl:template>
</xsl:stylesheet>