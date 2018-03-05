<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output omit-xml-declaration="no"
				indent="yes"
				doctype-system="master.dtd"/>
    <xsl:strip-space elements="*"/>


	<xsl:template match="objets">
		<master>
			<declaration-intervenants>
				<xsl:for-each select="objet[@type = 'personne']">
					<intervenant id="{@id}">
						<prenom>
							<xsl:value-of select="info[@nom ='prenom']/@value" />
						</prenom>
						<nom>
							<xsl:value-of select="info[@nom = 'nom']/@value"/>
						</nom>
						<mail>
							<xsl:value-of select="info[@nom = 'mail']/@value" />
						</mail>

						<site-web>
                            <xsl:value-of select="replace(lower-case(info[@nom ='prenom']/@value), ' ', '-')"/>
                            <xsl:text>.</xsl:text>
                            <xsl:value-of select="replace(lower-case(info[@nom = 'nom']/@value), ' ', '-')"/>
                            <xsl:text>.perso.luminy.univ-amu.fr</xsl:text>
						</site-web>
					</intervenant>
				</xsl:for-each>
			</declaration-intervenants>

			<declaration-unite>

				<xsl:for-each select="objet[@type = 'enseignement']">
					<unite id="{@id}">
						<nom>
							<xsl:value-of select="info[@nom = 'nom']/@value" />
						</nom>
						<credit>
							<xsl:value-of select="info[@nom = 'nb_credits']/@value" />
						</credit>
						<resume>
							<xsl:copy-of select="info[@nom = 'contenu']/node()" />
						</resume>
						<lieu-enseignement></lieu-enseignement>
						<intervenants>
							<xsl:for-each select="info[@nom='responsables']">
								<ref-intervenant ref="{@value}"/>
							</xsl:for-each>
						</intervenants>
					</unite>
				</xsl:for-each>
			</declaration-unite>
			<declaration-parcours>
				<xsl:for-each select="objet[@type = 'programme']">
					<parcours id="{@id}">
						<nom>
							<xsl:value-of select="info[@nom = 'nom']/@value" />
						</nom>
						<description></description>
						<responsables>
							<xsl:for-each select="info[@nom = 'responsables']">
								<ref-intervenant ref="{@value}"></ref-intervenant>
							</xsl:for-each>
						</responsables>
						<xsl:for-each select="id(info[@nom = 'structure']/@value)">
							<semestre>
								<nom>
									<xsl:value-of select="info[@nom = 'nom']/@value"></xsl:value-of>
								</nom>

								<ens-UE>
                                    <role>obligatoire</role>
                                    <nom>Unités obligatoires</nom>
                                    <xsl:for-each
										select="info[@nom = 'structure' and id(@value)/@type = 'enseignement']">
										<ref-unite ref="{@value}" />
									</xsl:for-each>
								</ens-UE>



								<xsl:for-each
									select="info[@nom = 'structure' and id(@value)/@type != 'enseignement']">
									<ens-UE>
                                        <role>
                                            <xsl:value-of select="id(@value)/@type"/>
                                        </role>
										<nom>
											<xsl:value-of select="id(@value)/info[@nom = 'nom']/@value" />
										</nom>
										<xsl:for-each select="id(@value)/info[@nom = 'structure']">
											<ref-unite ref="{@value}"></ref-unite>
										</xsl:for-each>
									</ens-UE>
								</xsl:for-each>
							</semestre>
						</xsl:for-each>
					</parcours>
				</xsl:for-each>
			</declaration-parcours>
		</master>
	</xsl:template>
</xsl:stylesheet>