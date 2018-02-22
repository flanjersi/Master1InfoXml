<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">


    <xsl:template match="declaration-parcours">
        <xsl:for-each select="parcours">
            <xsl:result-document href="{nom}.html">
                <html>
                    <head>
                        <title>Détail d'un intervenant</title>
                    </head>
                    <body>
                        <h1>
                            <xsl:value-of select="nom"/>
                        </h1>

                        <h2>Présentation</h2>
                        <p>
                            <xsl:copy-of select="description/node()"/>
                        </p>

                        <h2>Programme des enseignements</h2>

                        <h3>Programme du S1</h3>
                        <xsl:apply-templates select="semestre[1]"/>

                        <h3>Programme du S2</h3>
                        <xsl:apply-templates select="semestre[2]"/>
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
</xsl:stylesheet>