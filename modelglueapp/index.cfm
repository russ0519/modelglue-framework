<cfsilent>	
	<cfset ModelGlue_APP_KEY = "testApp" />
	
	<cfset ModelGlue_LOCAL_COLDSPRING_PATH = "/modelGlueApp/config/testApp/ColdSpring.xml" />
	
	<cfif not isDefined("ModelGlue_APP_KEY") or not isDefined("ModelGlue_LOCAL_COLDSPRING_PATH")>
		<cfthrow message="hey!!!" />
	</cfif>
	
	<cfif not structKeyExists(application,ModelGlue_APP_KEY)>
		<cfsetting requesttimeout="180" />
		<cfset ModelGlue_INITIALIZATION_LOCK_TIMEOUT = 180 />
		<cfdump var="starting #ModelGlue_APP_KEY#" output="console">
	</cfif>
</cfsilent>

<cfinclude template="/ModelGlue/gesture/ModelGlue.cfm" />