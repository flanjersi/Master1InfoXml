<!-- GESTION DES UNITES -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">


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
                            <xsl:value-of select="lieu-enseignement"/>
                            <div class="box">
                                <h3>Description :</h3>
                                <xsl:copy-of select="resume/node()"/>
                            </div>

                            <div class="box">
                                <h3>Liste des intervenants</h3>
                                <ul class="list">
                                    <xsl:apply-templates select="intervenants"/>
                                </ul>
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


    <xsl:template match="declaration-unite" mode="menu">
		<div id="title">UNITES</div>
		<ul id="list-ul">
		    <xsl:apply-templates select="unite" mode="ref">
		    	<xsl:sort select="nom" order="ascending"/>
		    </xsl:apply-templates>
		</ul>
		<input type="text" id="searchMenu" onkeyup="searchMenu()" placeholder="Recherche"/>
    </xsl:template>


    <xsl:template name="unites">
        ---------------------------------------------------
        <h1>Unités</h1>
        <xsl:apply-templates select="//unite"/>
        ---------------------------------------------------
        <br/>
    </xsl:template>

    <xsl:template match="unite">
        <br/>
        ---------------------
        <h2 id="{@id}">
            <xsl:value-of select="nom"/>
        </h2>
        Credit :
        <xsl:value-of select="credit"/>
        <br/>
        Lieu d'enseignement :
        <xsl:value-of select="lieu-enseignement"/>
        <br/>
        <p>
            Résumé :
            <br/>
            <xsl:value-of select="resume"/>
        </p>
        <p>
            Plan :
            <br/>
            <xsl:value-of select="plan"/>
        </p>
        <h3>Liste des intervenants</h3>
        <ul class="list">
            <xsl:apply-templates select="intervenant" mode="ref"/>
        </ul>
    </xsl:template>

    <xsl:template match="unite" mode="ref">
        <li>
            <a href="{@id}.html">
                <xsl:value-of select="nom"/>
            </a>
        </li>
    </xsl:template>


</xsl:stylesheet>