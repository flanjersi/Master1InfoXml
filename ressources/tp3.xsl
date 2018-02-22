<?xml version="1.0" encoding="utf-8" ?>

<xsl:stylesheet
        version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
		method="html" />

	<xsl:template match="master">
		<xsl:apply-templates select="declaration-intervenants" />
		<xsl:apply-templates select="declaration-unite" />
		<xsl:apply-templates select="declaration-parcours" />

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
						<xsl:apply-templates select="//unite" mode="ref" />
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
							<xsl:sort select="nom" order="ascending" />
						</xsl:apply-templates>
					</ul>
				</body>
			</html>
		</xsl:result-document>
	</xsl:template>




	<!-- TEMPLATE UTILITAIRES -->



	<!-- GESTION DES INTERVENANTS -->
	<xsl:template name="intervenants">
		<xsl:apply-templates select="//intervenant" />
	</xsl:template>

	<xsl:template match="intervenant">
		---------------------
		<h2 id="{@id}">
			<xsl:value-of select="nom" />
		</h2>
		Mail :
		<xsl:choose>
			<xsl:when test="mail/text()">
				<xsl:value-of select="mail" />
			</xsl:when>
			<xsl:otherwise>
				Non renseigné
			</xsl:otherwise>
		</xsl:choose>
		<br />
		Site web :
		<xsl:choose>
			<xsl:when test="site-web/text()">
				<xsl:value-of select="site-web" />
			</xsl:when>
			<xsl:otherwise>
				Non renseigné
			</xsl:otherwise>
		</xsl:choose>
		<br />
	</xsl:template>

	<xsl:template match="intervenant" mode="ref">
		<li>
			<a href="{@id}.html">
				<xsl:value-of select="nom" />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="ref-intervenant">
		<li>
			<a href="{@ref}.html">
				<xsl:value-of select="id(@ref)/nom" />
				<xsl:text />
				<xsl:value-of select="id(@ref)/prenom" />
			</a>
		</li>
	</xsl:template>


	<!-- GESTION DES UNITES -->
	<xsl:template name="unites">
		---------------------------------------------------
		<h1>Unités</h1>
		<xsl:apply-templates select="//unite" />
		---------------------------------------------------
		<br />
	</xsl:template>

	<xsl:template match="unite">
		<br />
		---------------------
		<h2 id="{@id}">
			<xsl:value-of select="nom" />
		</h2>
		Credit :
		<xsl:value-of select="credit" />
		<br />
		Lieu d'enseignement :
		<xsl:value-of select="lieu-enseignement" />
		<br />
		<p>
			Résumé :
			<br />
			<xsl:value-of select="resume" />
		</p>
		<p>
			Plan :
			<br />
			<xsl:value-of select="plan" />
		</p>
		<h3>Liste des intervenants</h3>
		<ul>
			<xsl:apply-templates select="intervenants" />
		</ul>
	</xsl:template>

	<xsl:template match="unite" mode="ref">
		<li>
			<a href="{@id}.html">
				<xsl:value-of select="nom" />
			</a>
		</li>
	</xsl:template>

	<xsl:template match="semestre">
		<ul>
			<xsl:for-each select="ens-UE">
				<li>
					<xsl:value-of select="role" />
					<ul>
						<xsl:for-each select="ref-unite">
							<li>
								<a href="{@ref}.html">
									<xsl:value-of select='id(@ref)/nom' />
									(
									<xsl:value-of select='id(@ref)/credit' />
									crédits)
								</a>
							</li>
						</xsl:for-each>
					</ul>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>


	<!-- CREATION DES PAGES INTERVENANTS -->
	<xsl:template match="declaration-intervenants">
		<xsl:for-each select="intervenant">
			<xsl:result-document href="{@id}.html">
				<html>
					<head>
						<link rel="stylesheet" href="master.css" type="text/css"/>
						 <script src="scripts.js"/>
						<title>Détail d'un intervenant</title>
					</head>
					<body>
						<div class="article">
						<img src="random.jpg" width="512" height="512"/>
						<h1>
							<xsl:value-of select="prenom"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="nom" />
						</h1>
						<div class="box">
						<p>
						<img class="logo" src="email.svg" alt-text="Email : "/> 
						<xsl:choose>
							<xsl:when test="mail/text()">
								<xsl:value-of select="mail" />
							</xsl:when>
							<xsl:otherwise>
								Non renseigné
							</xsl:otherwise>
						</xsl:choose>
						<br />
						<img class="logo" src="site.svg" alt-text="Site web : "/> 
						<xsl:choose>
							<xsl:when test="site-web/text()">
								<xsl:value-of select="site-web" />
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
							<xsl:with-param name="id-enseignant"><xsl:value-of select="@id"/></xsl:with-param>
						</xsl:call-template>
						</div>
						<div class="box">
						<h3>Responsable de(s) parcours</h3>
						<xsl:call-template name="responsable-parcours">
							<xsl:with-param name="id-enseignant"><xsl:value-of select="@id"/></xsl:with-param>
						</xsl:call-template>
						</div>
						</div>
						<xsl:apply-templates select="//declaration-intervenants" mode="menu"/>
					</body>
				</html>
			</xsl:result-document>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="declaration-intervenants" mode="menu">
		<div id="menu-list">
		<div id="title">INTERVENANTS</div>
		<ul id="list-ul">
		<xsl:for-each select="intervenant">
			<li>
			<a href="{@id}.html">
				<img class="head" src="random.jpg"/>
				<xsl:value-of select="prenom"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="nom" />
			</a>
			</li>
		</xsl:for-each>
		</ul>
		<input type="text" id="searchMenu" onkeyup="searchMenu()" placeholder="Recherche"/>
		</div>
	</xsl:template>

	<xsl:template match="declaration-unite">
		<xsl:for-each select="unite">
			<xsl:result-document href="{@id}.html">
				<html>
					<head>
						<link rel="stylesheet" href="master.css" type="text/css"/>
						 <script src="scripts.js"/>
						<title>
							Détail de l'unité d'enseignement
							<xsl:value-of select="@id" />
						</title>
					</head>
					<body>
						<div class="article">
							<h1><xsl:value-of select="nom" /></h1>
							Credit :
							<xsl:value-of select="credit" />
							<br />
							Lieu d'enseignement :
							<xsl:value-of select="lieu-enseignement" />
							<div class="box">
								<h3>Description :</h3>
								<xsl:copy-of select="resume/node()" />
							</div>
							<div class="box">
								<h3>Liste des intervenants</h3>
								<ul>
									<xsl:apply-templates select="intervenants" />
								</ul>
							</div>
						</div>
						<xsl:apply-templates select="//declaration-unite" mode="menu"/>
					</body>
				</html>
			</xsl:result-document>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="declaration-unite" mode="menu">
		<div id="menu-list">
		<div id="title">UNITES</div>
		<ul id="list-ul">
		<xsl:for-each select="unite">
			<li>
			<a href="{@id}.html">
				<xsl:value-of select="nom" />
			</a>
			</li>
		</xsl:for-each>
		</ul>
		<input type="text" id="searchMenu" onkeyup="searchMenu()" placeholder="Recherche"/>
		</div>
	</xsl:template>

	<xsl:template match="declaration-parcours">
		<xsl:for-each select="parcours">
			<xsl:result-document href="{nom}.html">
				<html>
					<head>
						<title>Détail d'un intervenant</title>
					</head>
					<body>
						<h1>
							<xsl:value-of select="nom" />
						</h1>

						<h2>Présentation</h2>
						<p>
							<xsl:copy-of select="description/node()" />
						</p>

						<h2>Programme des enseignements</h2>

						<h3>Programme du S1</h3>
						<xsl:apply-templates select="semestre[1]" />

						<h3>Programme du S2</h3>
						<xsl:apply-templates select="semestre[2]" />
					</body>
				</html>
			</xsl:result-document>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="enseignements-assure">
		<xsl:param name="id-enseignant"/>
		<ul>
			<xsl:for-each select="//unite[ intervenants [ref-intervenant [ @ref = $id-enseignant ]]]">
				<li><a href="{@id}.html"><xsl:value-of select="nom"/></a></li>
			</xsl:for-each>
		</ul>
	</xsl:template>

	<xsl:template name="responsable-parcours">
		<xsl:param name="id-enseignant"/>
		<ul>
			<xsl:for-each select="//parcours[ responsables [ref-intervenant [ @ref = $id-enseignant ]]]">
				<li><a href="{nom}.html"><xsl:value-of select="nom"/></a></li>
			</xsl:for-each>
		</ul>
	</xsl:template>


	<xsl:template name="menu">



	</xsl:template>




</xsl:stylesheet>