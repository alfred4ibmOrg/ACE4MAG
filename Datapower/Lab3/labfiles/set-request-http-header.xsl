<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dp="http://www.datapower.com/extensions"
	xmlns:dpconfig="http://www.datapower.com/param/config"
	exclude-result-prefixes="dp dpconfig"
	extension-element-prefixes="dp"
	version="2.0">
	
	<!-- Written by Elad Ben-Matityahu -->
	
	<xsl:param name="dpconfig:headerName" />
	<dp:param name="dpconfig:headerName" type="dmString" xmlns="">
		<display>HTTP Header Name</display>
		<default>sample-name</default>
		<description>The HTTP header name that should be set</description>
	</dp:param>
	
	<xsl:param name="dpconfig:headerValue" />
	<dp:param name="dpconfig:headerValue" type="dmString" xmlns="">
		<display>HTTP Header Value</display>
		<default>sample-value</default>
		<description>The HTTP header value that should be set.</description>
	</dp:param>
	
	<xsl:template match="/">
		<dp:set-http-request-header name="$dpconfig:headerName" value="$dpconfig:headerValue"/>
	</xsl:template>

</xsl:stylesheet>
