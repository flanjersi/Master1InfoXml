
all: dtd xsd web xq java

#tidy xq

makeDir:
	mkdir -p www

dtd:
	xmllint --valid --noout donnees-master/data.xml

xsd:
	xmllint --noout --schema donnees-master/data.xsd donnees-master/data.xml

web: makeDir
	java -jar saxon/saxon9he.jar -xsl:main.xsl donnees-master/data.xml

#tidy:


xq: makeDir
	java -cp saxon/saxon9he.jar net.sf.saxon.Query "-q:xQuery/request.xq" > www/xq.html


java:
    - javac App.java
    - java App.class