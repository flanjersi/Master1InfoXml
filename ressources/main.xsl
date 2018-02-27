<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
                method="html"/>

    <xsl:include href="unites.xsl"/>
    <xsl:include href="intervenants.xsl"/>
    <xsl:include href="parcours.xsl"/>

    <xsl:template match="master">
        <xsl:apply-templates select="declaration-intervenants"/>
        <xsl:apply-templates select="declaration-unite"/>
        <xsl:apply-templates select="declaration-parcours"/>

        <!-- CREATION PAGE ACCEUIL -->
        <xsl:result-document href="www/index.html" method="html">
            <html>
                <head>
                    <title>Table of Contents</title>
                </head>
                <body>
                    <p>Test</p>
                </body>
            </html>
        </xsl:result-document>

        <!-- CREATION PAGE LISTE DES UNITES -->
        <xsl:result-document href="www/unites.html" method="html">
			<xsl:apply-templates select="//declaration-unite" mode="menu"/>
        </xsl:result-document>

        <!-- CREATION PAGE LISTE DES INTERVENANTS -->
        <xsl:result-document href="www/intervenants.html" method="html">
            <xsl:apply-templates select="//declaration-intervenants" mode="menu"/>
        </xsl:result-document>
        
        <!-- CREATION PAGE LISTE DES PARCOURS -->
        <xsl:result-document href="www/parcours.html" method="html">
            <xsl:apply-templates select="//declaration-parcours" mode="menu"/>
        </xsl:result-document>
    </xsl:template>

</xsl:stylesheet>