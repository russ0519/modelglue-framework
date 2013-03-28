<cfcomponent output="false">
	
	<cfset this.name = "test" />
	<cfset this.applicationTimeout = createTimeSpan(5,0,0,0) />
	<cfset this.clientManagement = false />
	<cfset this.setClientCookies = false />
	<cfset this.sessionManagement = true />
	<cfset this.mappings = structNew()>
	<cfset this.mappings['/modelGlueApp'] = "#getDirectoryFromPath(GetCurrentTemplatePath())#modelglueapp" />
	<cfset this.mappings['/ModelGlue'] = "#getDirectoryFromPath(GetCurrentTemplatePath())#ModelGlue" />
	<cfset this.mappings['/coldspring'] = "#getDirectoryFromPath(GetCurrentTemplatePath())#components/coldspring" />
	<cfset this.mappings['/config'] = "#getDirectoryFromPath(GetCurrentTemplatePath())#config" />
	
</cfcomponent>