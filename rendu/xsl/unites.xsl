<!-- GESTION DES UNITES -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

	<!-- CREATION DES PAGES UNITE -->
    <xsl:template match="declaration-unite">
        <xsl:for-each select="unite">
            <xsl:result-document href="www/{@id}.html">
                <html>
                    <head>
                        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                        <link rel="stylesheet" href="master.css" type="text/css"/>
                        <script src="scripts.js"/>
                        <title>
                            Détail de l'unité d'enseignement
                            <xsl:value-of select="@id"/>
                        </title>
                    </head>
                    <body>
                        <div w3-include-html="menu.html"></div>
                        <script>
                            includeHTML();
                        </script>
                        <div class="article">
                            <h1>
                                <xsl:value-of select="nom"/>
                            </h1>
                            Credit :
                            <xsl:value-of select="credit"/>
                            <br/>
                            Lieu d'enseignement :
                            <xsl:variable name="lieuEnseignement" select="lieu-enseignement"/>

                            <xsl:if test="empty($lieuEnseignement/node())">
                                Non renseigné
                            </xsl:if>

                            <xsl:if test="exists($lieuEnseignement/node())">
                                <xsl:for-each select="$lieuEnseignement">
                                    <xsl:value-of select="lieu"/>
                                    <xsl:text> </xsl:text>
                                </xsl:for-each>
                            </xsl:if>
                            <div class="box">
                                <h3>Description :</h3>
                                <xsl:if test="empty(resume/node())">
                                    Non renseigné
                                </xsl:if>

                                <xsl:if test="exists(resume/node())">
                                    <xsl:copy-of select="resume/node()"/>
                                </xsl:if>
                            </div>

                            <div class="box">
                                <h3>Liste des intervenants</h3>
                                <xsl:if test="empty(intervenants/node())">
                                    Non renseigné
                                </xsl:if>

                                <xsl:if test="exists(intervenants/node())">
                                    <ul class="list">
                                        <xsl:apply-templates select="intervenants"/>
                                    </ul>
                                </xsl:if>
                            </div>
                            <div class="box">
                                <h3>Parcours concerné par l'unité :</h3>
                                <xsl:call-template name="list-parcours-unite">
                                    <xsl:with-param name="id-unite">
                                        <xsl:value-of select="@id"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </div>
                        </div>
                        <div id="menu-list" w3-include-html="unitesMenu.html"></div>
                        <script>
                            includeHTML();
                        </script>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

	<!-- Genere le menu de droite des unites -->
    <xsl:template match="declaration-unite" mode="menu">
        <div id="title">UNITES</div>
        <ul id="list-ul">
            <xsl:apply-templates select="unite" mode="ref">
                <xsl:sort select="nom" order="ascending"/>
            </xsl:apply-templates>
        </ul>
        <input type="text" id="searchMenu" onkeyup="searchMenu()" placeholder="Recherche"/>
    </xsl:template>

	<!-- Genere la liste des unites dans la page unites.html -->
    <xsl:template match="unite" mode="ref">
        <li>
            <a href="{@id}.html">
                <xsl:value-of select="nom"/>
            </a>
        </li>
    </xsl:template>

    <!-- Genere la liste des parcours possédant l'unité d'id "id-unite" -->
    <xsl:template name="list-parcours-unite">
        <xsl:param name="id-unite"/>
        <ul class="list">
            <xsl:for-each select="//parcours[semestre [ ens-UE [ref-unite[ @ref = $id-unite]]]]">
                <xsl:sort select="nom"/>
                <li>
                    <a href="{@id}.html">
                        <xsl:value-of select="nom"/>
                    </a>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>


</xsl:stylesheet>