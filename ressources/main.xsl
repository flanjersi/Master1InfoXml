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
					<div class="article">
						<p>
						Le master « informatique » a pour vocation la formation de professionnels de l'informatique au niveau bac+5. L'objectif est d'offrir aux étudiants une large palette de compétences et de savoirs afin de rendre accessible des emplois de haut niveau dans le monde de la recherche, dans celui de l'entreprise ou dans d'autres organisations. Notre ambition est de former des étudiants dont les compétences sont tout à fait comparables à celles acquises dans les meilleurs écoles d'ingénieurs.
						Le Master informatique repose sur plus de 25 ans d'expérience d'enseignement d'informatique sur l'Université d'Aix-Marseille (maîtrise, DEA et DESS en informatique) et s'est structuré lors du passage au LMD. Si vous n'êtes pas familier des formations organisées suivant le schéma Licence/Master/Doctorat, nous vous conseillons de lire cette petite introduction.
						Le Master Informatique s'appuie principalement sur les compétences de deux laboratoires reconnus :
						</p>
						<ul>
						    <li><a href="http://www.lif.univ-mrs.fr/">Laboratoire d'Informatique Fondamentale de Marseille (LIF)</a></li>
						    <li><a href="http://www.lsis.org/">Laboratoire des Sciences de l'Information et des Systèmes (LSIS)</a></li>
						</ul>
						<p>La master est enseigné à Marseille sur le campus de Luminy (site sud) et sur le campus de l'Étoile (site nord) qui regroupe Château-Gombert et Saint-Jérôme.</p>
						Notre offre de formation au niveau Bac+5 est organisée autour de deux axes forts :<br/>
						<ul>
						    <li>Le master est structuré sous la forme d'une première année commune (M1) et dupliquée sur les sites sud et nord, suivie d'une deuxième année de spécialisation (M2).</li>
						    <li>La deuxième année est composée de sept spécialités. Deux à finalité recherche, et cinq à finalité professionnelle. Certaines spécialités sont ensuite déclinées en plusieurs parcours. Ces spécialités sont localisées à Luminy ou à Saint-Jérôme en fonction des compétences locales.</li>
						</ul>
					</div>
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
				<li><a href="index.html">Home</a></li>
				<li><a href="parcours.html">Parcours</a></li>
				<li><a href="unites.html">Unites</a></li>
				<li><a href="intervenants.html">Intervenants</a></li>
			</ul>
        </xsl:result-document>
        
    </xsl:template>

</xsl:stylesheet>