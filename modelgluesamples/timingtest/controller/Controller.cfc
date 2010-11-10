<cfcomponent output="false" hint="I am a Model-Glue controller." extends="ModelGlue.gesture.controller.Controller">

	<cffunction name="init" access="public" output="false" hint="Constructor">
		<cfargument name="framework" />
		
		<cfset super.init(framework) />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="doSomething" access="public" output="false" returntype="void" >
	   <cfargument name="event" type="any" required="true" />
	   
	   <cfset arguments.event.setValue( "foo", "bar" ) />
	   
	</cffunction>
	
</cfcomponent>
	
