
all: dtd xsd web xq javaLunch

#tidy xq

makeDir:
	mkdir -p www

dtd:
	xmllint --valid --noout master.xml

xsd:
	xmllint --noout --schema master.xsd master.xml

web: makeDir
	java -jar saxon/saxon9he.jar -xsl:xsl/main.xsl master.xml

#tidy:


xq: makeDir
	java -cp saxon/saxon9he.jar net.sf.saxon.Query "-q:xq.txt" > www/xq.html


javaLunch:
	cd java; javac App.java; java App ../master.xml; cd ..

clear:
	cd www; rm *.html ; cd ..
