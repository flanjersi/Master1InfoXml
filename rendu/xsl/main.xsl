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
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                    <link rel="stylesheet" href="master.css" type="text/css"/>
                    <script src="scripts.js"/>
                    <title>Table of Contents</title>
                </head>
                <body>
                    <div w3-include-html="menu.html"></div>
                    <script>
                        includeHTML();
                    </script>
                </body>
            </html>
        </xsl:result-document>

        <!-- CREATION PAGE MENU DES UNITES -->
        <xsl:result-document href="www/unitesMenu.html" method="html">
            <xsl:apply-templates select="//declaration-unite" mode="menu"/>
        </xsl:result-document>

        <!-- CREATION PAGE MENU DES INTERVENANTS -->
        <xsl:result-document href="www/intervenantsMenu.html" method="html">
            <xsl:apply-templates select="//declaration-intervenants" mode="menu"/>
        </xsl:result-document>

        <!-- CREATION PAGE MENU DES PARCOURS -->
        <xsl:result-document href="www/parcoursMenu.html" method="html">
            <xsl:apply-templates select="//declaration-parcours" mode="menu"/>
        </xsl:result-document>

        <!-- CREATION PAGE DES UNITES -->
        <xsl:result-document href="www/unites.html" method="html">
            <html>
                <head>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                    <link rel="stylesheet" href="master.css" type="text/css"/>
                    <script src="scripts.js"/>
                    <title>Table of Contents</title>
                </head>
                <body>
                    <div w3-include-html="menu.html"></div>
                    <script>
                        includeHTML();
                    </script>
                    <div class="article">
                        <ul class="list">
                            <xsl:apply-templates select="//unite" mode="ref">
                                <xsl:sort select="nom" order="ascending"/>
                            </xsl:apply-templates>
                        </ul>
                    </div>
                </body>
            </html>
        </xsl:result-document>

        <!-- CREATION PAGE DES INTERVENANTS -->
        <xsl:result-document href="www/intervenants.html" method="html">
            <html>
                <head>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                    <link rel="stylesheet" href="master.css" type="text/css"/>
                    <script src="scripts.js"/>
                    <title>Table of Contents</title>
                </head>
                <body>
                    <div w3-include-html="menu.html"></div>
                    <script>
                        includeHTML();
                    </script>
                    <div class="article">
                        <ul class="list">
                            <xsl:apply-templates select="//intervenant" mode="ref">
                                <xsl:sort select="nom" order="ascending"/>
                            </xsl:apply-templates>
                        </ul>
                    </div>
                </body>
            </html>
        </xsl:result-document>

        <!-- CREATION PAGE DES PARCOURS -->
        <xsl:result-document href="www/parcours.html" method="html">
            <html>
                <head>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                    <link rel="stylesheet" href="master.css" type="text/css"/>
                    <script src="scripts.js"/>
                    <title>Table of Contents</title>
                </head>
                <body>
                    <div w3-include-html="menu.html"></div>
                    <script>
                        includeHTML();
                    </script>
                    <div class="article">
                        <ul class="list">
                            <xsl:apply-templates select="//parcours" mode="ref">
                                <xsl:sort select="nom" order="ascending"/>
                            </xsl:apply-templates>
                        </ul>
                    </div>
                </body>
            </html>
        </xsl:result-document>

        <!--  CREATION PAGE MENU HAUT -->
        <xsl:result-document href="www/menu.html" method="html">
            <ul class="topnav">
                <li>
                    <a href="index.html">Home</a>
                </li>
                <li>
                    <a href="parcours.html">Parcours</a>
                </li>
                <li>
                    <a href="unites.html">Unites</a>
                </li>
                <li>
                    <a href="intervenants.html">Intervenants</a>
                </li>
            </ul>
        </xsl:result-document>

    </xsl:template>

</xsl:stylesheet>