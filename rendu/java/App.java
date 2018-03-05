import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;


public class App 
{
    private static Document resultDoc;
    private static Element root;

    /**
     * Parse une unite pour en recuperer son nom
     * @param unite
     */
    private static void parseUnite(Node unite){
        NodeList uniteProperties = unite.getChildNodes();
        Node node;

        for(int i = 0 ; i < uniteProperties.getLength() ; i++){
            node = uniteProperties.item(i);

            if(node.getNodeType() != Node.ELEMENT_NODE) continue;

            if(!node.getNodeName().equals("nom")) continue;

            resultDoc.adoptNode(node);
            root.appendChild(node);
        }
    }

    /**
     * Parcours toutes les unites
     * @param unites
     */
    private static void parseUnites(Node unites){
        NodeList listUnites = unites.getChildNodes();
        Node node;

        for(int i = 0 ; i < listUnites.getLength() ; i++){
            node = listUnites.item(i);

            if(node.getNodeType() != Node.ELEMENT_NODE) continue;

            if(!node.getNodeName().equals("unite")) continue;

            parseUnite(node);
        }
    }

    /**
     * Parse le document pour acceder à la déclaration des unites
     * @param document
     */
    private static void parse(Document document){
        Node node;

        NodeList nodeList = document.getElementsByTagName("master");
        Node master = nodeList.item(0);

        nodeList = master.getChildNodes();


        for(int i = 0 ; i < nodeList.getLength() ; i++){
            node = nodeList.item(i);

            if(node.getNodeType() != Node.ELEMENT_NODE) continue;

            if(!node.getNodeName().equals("declaration-unite")) continue;

            parseUnites(node);
        }

    }

    public static void main(String[] args) throws Exception {
        if(args.length != 1){
            System.out.println("Aucun nom de fichier");
        }

        String fileName = args[0];

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document document = builder.parse(new File(fileName));

        resultDoc = builder.newDocument();

        root = resultDoc.createElement("nomUnites");

        resultDoc.appendChild(root);

        parse(document);

        // sérialisation
        TransformerFactory myFactory = TransformerFactory.newInstance();
        Transformer transformer = myFactory.newTransformer();

        transformer.setOutputProperty(OutputKeys.ENCODING, "utf-8");
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");

        transformer.transform(new DOMSource(resultDoc), new StreamResult(System.out));

    }
}

