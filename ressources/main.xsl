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
        <xsl:result-document href="index.html" method="html">
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
        <xsl:result-document href="unites.html" method="html">
            <html>
                <head>
                    <title>Liste des unites</title>
                </head>
                <body>
                    <h1>Liste des unités</h1>
                    <ul>
                        <xsl:apply-templates select="//unite" mode="ref">
                        	<xsl:sort select="nom" order="ascending"/>
                        </xsl:apply-templates>
                    </ul>
                </body>
            </html>
        </xsl:result-document>

        <!-- CREATION PAGE LISTE DES INTERVENANTS -->
        <xsl:result-document href="intervenants.html" method="html">
            <html>
                <head>
                    <title>Listes des intervenants</title>
                </head>
                <body>
                    <h1>Liste des intervenants</h1>
                    <ul>
                        <xsl:apply-templates select="declaration-intervenants/intervenant"
                                             mode="ref">
                            <xsl:sort select="nom" order="ascending"/>
                        </xsl:apply-templates>
                    </ul>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="menu">


    </xsl:template>

</xsl:stylesheet>