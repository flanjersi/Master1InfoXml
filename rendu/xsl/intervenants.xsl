<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

	<!-- Genere la liste des enseignants dans la page intervenants.html -->
    <xsl:template match="intervenant" mode="ref">
        <li>
            <a href="{@id}.html">
                <xsl:value-of select="nom"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="prenom"/>
            </a>
        </li>
    </xsl:template>

	<!-- Genere la liste des enseignants qui enseigne une unite x -->
    <xsl:template match="ref-intervenant">
        <li>
            <a href="{@ref}.html">
                <xsl:value-of select="id(@ref)/nom"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="id(@ref)/prenom"/>
            </a>
        </li>
    </xsl:template>


    <!-- CREATION DES PAGES INTERVENANTS -->
    <xsl:template match="declaration-intervenants">
        <xsl:for-each select="intervenant">
            <xsl:result-document href="www/{@id}.html">
                <html>
                    <head>
                        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                        <link rel="stylesheet" href="master.css" type="text/css"/>
                        <script src="scripts.js"/>
                        <title>Détail d'un intervenant</title>
                    </head>
                    <body>
                        <div w3-include-html="menu.html"></div>
                        <script>
                            includeHTML();
                        </script>
                        <div class="article">
                            <h1>
                                <xsl:value-of select="prenom"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="nom"/>
                            </h1>
                            <div class="box">
                                <p>
                                    <img class="logo" src="img/email.svg"/>
                                    <xsl:choose>
                                        <xsl:when test="mail/text()">
                                            <xsl:value-of select="mail"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            Non renseigné
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <br/>
                                    <img class="logo" src="img/site.svg"/>
                                    <xsl:choose>
                                        <xsl:when test="site-web/text()">
                                            <a href="http://{site-web/text()}">
                                                <xsl:value-of select="site-web"/>
                                            </a>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            Non renseigné
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </p>
                            </div>
                            <div class="box">
                                <h3>Enseignements</h3>
                                <xsl:call-template name="enseignements-assure">
                                    <xsl:with-param name="id-enseignant">
                                        <xsl:value-of select="@id"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </div>
                            <div class="box">
                                <h3>Responsable de(s) parcours</h3>
                                <xsl:call-template name="responsable-parcours">
                                    <xsl:with-param name="id-enseignant">
                                        <xsl:value-of select="@id"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </div>
                        </div>
                        <div id="menu-list" w3-include-html="intervenantsMenu.html"></div>
                        <script>
                            includeHTML();
                        </script>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

	<!-- Genere le menu de droite des enseignants -->
    <xsl:template match="declaration-intervenants" mode="menu">
        <div id="title">INTERVENANTS</div>
        <ul id="list-ul">
            <xsl:for-each select="intervenant">
                <li>
                    <a href="{@id}.html">
                        <xsl:value-of select="prenom"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="nom"/>
                    </a>
                </li>
            </xsl:for-each>
        </ul>
        <input type="text" id="searchMenu" onkeyup="searchMenu()" placeholder="Recherche"/>
    </xsl:template>

	<!-- Genere la liste des unite qu'un enseignant enseigne -->
    <xsl:template name="enseignements-assure">
        <xsl:param name="id-enseignant"/>
        <ul class="list">
            <xsl:for-each select="//unite[ intervenants [ref-intervenant [ @ref = $id-enseignant ]]]">
                <li>
                    <a href="{@id}.html">
                        <xsl:value-of select="nom"/>
                    </a>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>

	<!-- Genere la liste des responsables des parcours pour un enseignant -->
    <xsl:template name="responsable-parcours">
        <xsl:param name="id-enseignant"/>
        <ul class="list">
            <xsl:for-each select="//parcours[ responsables [ref-intervenant [ @ref = $id-enseignant ]]]">
                <li>
                    <a href="{@id}.html">
                        <xsl:value-of select="nom"/>
                    </a>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>

</xsl:stylesheet>