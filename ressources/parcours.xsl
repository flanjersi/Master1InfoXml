<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">


    <xsl:template match="declaration-parcours">
        <xsl:for-each select="parcours">
            <xsl:result-document href="www/parcours/{nom}.html">
                <html>
                    <head>
                    	<link rel="stylesheet" href="master.css" type="text/css"/>
                        <script src="scripts.js"/>
                        <title>Détail d'un parcours</title>
                    </head>
                    <body>
                    	<div class="article">
	                        <h1>
	                            <xsl:value-of select="nom"/>
	                        </h1>
							<div class="box">
	                        <h2>Présentation</h2>
	                        <p>
	                            <xsl:copy-of select="description/node()"/>
	                        </p>
							</div>
							<div class="box">
	                        <h2>Programme des enseignements</h2>
	
	                        <h3>Programme du S1</h3>
	                        <xsl:apply-templates select="semestre[1]"/>
	
	                        <h3>Programme du S2</h3>
	                        <xsl:apply-templates select="semestre[2]"/>
	                        </div>
	                    </div>
                        <div w3-include-html="parcours.html"></div> 
						<script>
						includeHTML();
						</script>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="semestre">
        <ul>
            <xsl:for-each select="ens-UE">
                <li>
                    <xsl:value-of select="role"/>
                    <ul>
                        <xsl:for-each select="ref-unite">
                            <li>
                                <a href="{@ref}.html">
                                    <xsl:value-of select='id(@ref)/nom'/>
                                    (
                                    <xsl:value-of select='id(@ref)/credit'/>
                                    crédits)
                                </a>
                            </li>
                        </xsl:for-each>
                    </ul>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    
    <xsl:template match="declaration-parcours" mode="menu">
	    <div id="menu-list">
	        <div id="title">PARCOURS</div>
	        <ul id="list-ul">
	            <xsl:apply-templates select="parcours" mode="ref">
	            	<xsl:sort select="nom" order="ascending"/>
	            </xsl:apply-templates>
	        </ul>
	        <input type="text" id="searchMenu" onkeyup="searchMenu()" placeholder="Recherche"/>
	    </div>
	</xsl:template>

	<xsl:template match="parcours" mode="ref">
	    <li>
	        <a href="{@id}.html">
	            <xsl:value-of select="nom"/>
	        </a>
	    </li>
	</xsl:template>
</xsl:stylesheet>


