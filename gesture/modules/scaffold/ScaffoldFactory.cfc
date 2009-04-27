<cfcomponent output="false">

	<cffunction name="init" access="public" returntype="ScaffoldFactory">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="new" output="false" access="public" returntype="any" hint="I make a new instance of a specific scaffold bean">
		<cfargument name="type" />
		<cfreturn createobject("component", "beans.#arguments.type#") />
	</cffunction>


</cfcomponent>