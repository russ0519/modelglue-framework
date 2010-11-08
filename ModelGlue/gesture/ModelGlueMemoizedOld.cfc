<cfcomponent output="false" extends="ModelGlue.gesture.AbstractModelGlue"
	hint="The core of the Model-Glue framework.  Extends the MG3 ModelGlue.cfc and adds memoization."
> 
<cfset variables.ModuleLoaderArray = arrayNew(1) />
<cffunction name="init" output="false" hint="Constructor.">
	<cfset super.init() />
	<cfreturn this />
</cffunction>

<cffunction name="getController" output="false" returntype="any" hint="Gets a controller by id.">
	<cfargument name="controllerID" type="string" />
	<cfset variables.loader =  getInternalBean("modelglue.ModuleLoaderFactory").create("XML") />
	<cfif structKeyExists( this.controllers, arguments.controllerID ) IS false AND controllerWasDefined( arguments.controllerId ) IS true>
		<cfset variables.loader.locateAndMakeController( this, arguments.controllerID ) />
	</cfif>	
	<cfreturn this.controllers[arguments.controllerId] />
</cffunction>

<cffunction name="controllerIsAlreadyLoaded" output="false" returntype="boolean" hint="I look for a specific controller in the Model Glue scope">
	<cfargument name="controllerID" type="string" required="true"/>
	<cfreturn structKeyExists( this.controllers, arguments.controllerId ) />
</cffunction>

<cffunction name="controllerWasDefined" output="false" access="private" returntype="boolean" hint="I look for a specific controller in the registered module loaders">
	<cfargument name="controllerID" type="string" required="true"/>
	<cfset var NumberOfLoaders = arrayLen( variables.ModuleLoaderArray ) />
	<cfset var i = "" />
	<!--- Try to find the controller definition in the registered modules  --->
	<cfloop from="1" to="#NumberOfLoaders#" index="i">
		<cfif variables.ModuleLoaderArray[ i ].findControllerDefinition( arguments.controllerID ) IS true>
			<cfreturn true />
		</cfif>
	</cfloop>
	
	<cfreturn false />
</cffunction>

<cffunction name="getEventHandler" output="false" hint="I get an event handler by name.  If one doesn't exist, a struct key not found error is thrown - this is a heavy hit method, so it's about speed, not being nice.">
	<cfargument name="eventHandlerName" type="string" required="true" hint="The event handler to return." />
	<cfset variables.loader =  getInternalBean("modelglue.ModuleLoaderFactory").create("XML") />
	
	<cfif structKeyExists( this.eventHandlers, arguments.eventHandlerName ) IS false AND hasEventHandler( arguments.eventHandlerName ) IS true>
		<cfset makeEventHandler( arguments.eventHandlerName ) />
	</cfif>		
	<cfreturn this.eventHandlers[arguments.eventHandlerName] />
	<!---<cftry>
	
	<cfreturn this.eventHandlers[arguments.eventHandlerName] />
	<cfcatch type="expression">
		<cfdump var="#arguments.eventHandlerName#" label="arguments.eventHandlerName">	
		<cfdump var="#this.eventHandlers#" label="event handlers">
		<cfdump var="#variables.ModuleLoaderArray#">
				<cftry>
				<cfthrow type="Fuck" message="Fuck" detail="fuck" /> 
				<cfcatch type="Fuck">
					<cfdump var="#cfcatch#">
				</cfcatch>
				</cftry>		
		<cfabort>
	</cfcatch>
	
	</cftry>--->
	
</cffunction>

<cffunction name="hasEventHandler" output="false" hint="Does an event handler by the given name exist?">
	<cfargument name="eventHandlerName" type="string" required="true" hint="The event handler in question." />
	<cfset var NumberOfLoaders = arrayLen( variables.ModuleLoaderArray ) />
	<cfset var i = "" />
	<!--- Try to find the controller definition in the registered modules  --->
	<cfloop from="1" to="#NumberOfLoaders#" index="i">
		<cfif variables.ModuleLoaderArray[ i ].hasEventHandlerDefinition( arguments.eventHandlerName ) IS true>
			<cfreturn true />
		</cfif>
	</cfloop>
	
	<cfreturn false />
</cffunction>

<cffunction name="makeEventHandler" output="false" hint="Try to make an event handler by a name based on the loaded module loaders">
	<cfargument name="eventHandlerName" type="string" required="true" hint="The event handler in question." />
	<cfset var NumberOfLoaders = arrayLen( variables.ModuleLoaderArray ) />
	<cfset var i = "" />
	<!--- Try to find the event-handler definition in the registered modules  --->
	<cfloop from="1" to="#NumberOfLoaders#" index="i">
		<cfset variables.ModuleLoaderArray[ i ].locateAndMakeEventHandler( this, arguments.eventHandlerName )>
	</cfloop>
	
</cffunction>

<cffunction name="getModuleLoaderArray" output="false" access="public" returntype="array" hint="I return the configuration array of module loaders">
	<cfreturn variables.ModuleLoaderArray />
</cffunction>

<cffunction name="addModuleLoader" output="false" access="public" returntype="void" hint="I add a module loader to the internal store">
	<cfargument name="ModuleLoader" type="any" required="true"/>
	<cfset arrayAppend( variables.ModuleLoaderArray, arguments.ModuleLoader ) />
</cffunction>

</cfcomponent>