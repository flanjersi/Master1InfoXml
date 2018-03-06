XML_FILE=master.xml

DTD_FILE=master.dtd
XSD_FILE=master.xsd



all: dtd xsd web tidy xq javaLunch


makeDir:
	mkdir -p www

dtd:
	xmllint --valid --noout $(XML_FILE)

xsd:
	xmllint --noout --schema $(XSD_FILE) $(XML_FILE)

web: makeDir
	java -jar saxon/saxon9he.jar -xsl:xsl/main.xsl $(XML_FILE)

tidy:
	chmod +x tidyFolder.sh;./tidyFolder.sh

xq: makeDir
	java -cp saxon/saxon9he.jar net.sf.saxon.Query "-q:xq.txt" > www/xq.html


javaLunch:
	cd java; javac App.java; java App ../$(XML_FILE); cd ..

clear:
	cd www; rm *.html ; cd ..
