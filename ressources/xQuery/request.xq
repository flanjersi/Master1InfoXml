<html>
<head>
<title>Requête XQuery</title>
</head>

<body>
<p> Résultat de la requête XQuery </p>
<ul>
{
    for $intervenant in doc("../donnees-master/data.xml")/master/declaration-intervenants/intervenant
    order by $intervenant/nom
    return
        <li>
            <p style="font-weight: bold;">{$intervenant/prenom/text()}&#x20;{$intervenant/nom/text()}</p>
            <p style="text-decoration: underline;" >Liste d'enseignements assurés</p>

            {
                let $seq := (
                        for $unite in doc("../donnees-master/data.xml")/master/declaration-unite/unite[ intervenants [ref-intervenant [ @ref = $intervenant/@id ]]]
                        order by $unite/nom
                        return $unite/nom/text()
                )

                return if( not( empty( $seq ) )) then (
                    <ul>
                        {
                            for $item in $seq
                            order by $item
                            return <li> {$item} </li>
                        }
                    </ul>
                ) else ( <p> Aucun </p> )
            }

            <p style="text-decoration: underline;">Intervient dans les parcours : </p>
            {
                let $seqParcours := (
                    for $parcours in doc("../donnees-master/data.xml")/master/declaration-parcours/parcours
                    order by $parcours/nom

                        for $semestre in $parcours/semestre

                            for $ensUe in $semestre/ens-UE

                                for $refUe in $ensUe/ref-unite
                                let $uniteParcours := doc("../donnees-master/data.xml")/id(string($refUe/@ref))

                                    for $enseignantParcours in $uniteParcours/intervenants/ref-intervenant
                                    where ($enseignantParcours/@ref = $intervenant/@id)
                                    return $parcours/nom/text()
                )

                let $distinctParcours := distinct-values($seqParcours)

                return if( not( empty( $distinctParcours ) )) then (
                    <ul>
                        {
                            for $itemParcours in $distinctParcours
                            order by $itemParcours
                            return <li> {$itemParcours} </li>
                        }
                    </ul>
                ) else ( <p> Aucun </p> )
            }
        </li>
}
</ul>

</body>

</html>
