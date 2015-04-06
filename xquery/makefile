#requires libxml2-utils
XQFILE=query.xquery

all: ${XQFILE}
	java -cp ./lib/saxon/saxon9ee.jar net.sf.saxon.Query -q:"${XQFILE}" | xmllint --format -

base: ${XQFILE}
	java -cp ./lib/saxon/saxon9ee.jar net.sf.saxon.Query -q:"${XQFILE}" | xmllint --format -



