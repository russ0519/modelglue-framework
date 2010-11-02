<cfcomponent output="false" extends="ModelGlue.gesture.ModelGlue"
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
	<cfset var NumberOfLoaders = arrayLen( variables.ModuleLoaderArray ) />
	<cfset var i = "" />
	<cfset var eh = "" />
	<cfif structKeyExists( this.eventHandlers, arguments.eventHandlerName ) IS false AND eventHandlerWasDefined( this, arguments.eventHandlerName ) IS true>
		<cfloop from="1" to="#NumberOfLoaders#" index="i">
			<cfif variables.ModuleLoaderArray[ i ].locateAndMakeEventHandler( arguments.controllerID ) IS true>
				<cfset this.eventHandlers[arguments.eventHandlerName] =  variables.ModuleLoaderArray[ i ].locateAndMakeEventHandler( this, arguments.eventHandlerName ) />
			</cfif>
		</cfloop>
		
	</cfif>		
	<cfreturn this.eventHandlers[arguments.eventHandlerName] />
</cffunction>

<cffunction name="eventHandlerWasDefined" output="false" hint="Does an event handler by the given name exist?">
	<cfargument name="eventHandlerName" type="string" required="true" hint="The event handler in question." />
	<cfset var NumberOfLoaders = arrayLen( variables.ModuleLoaderArray ) />
	<cfset var i = "" />
	<!--- Try to find the controller definition in the registered modules  --->
	<cfloop from="1" to="#NumberOfLoaders#" index="i">
		<cfif variables.ModuleLoaderArray[ i ].findEventHandlerDefinition( arguments.eventHandlerName ) IS true>
			<cfreturn true />
		</cfif>
	</cfloop>
	
	<cfreturn false />
</cffunction>

<cffunction name="getModuleLoaderArray" output="false" access="public" returntype="array" hint="I return the configuration array of module loaders">
	<cfreturn variables.ModuleLoaderArray />
</cffunction>

<cffunction name="addModuleLoader" output="false" access="public" returntype="void" hint="I add a module loader to the internal store">
	<cfargument name="ModuleLoader" type="any" required="true"/>
	<cfset arrayAppend( variables.ModuleLoaderArray, arguments.ModuleLoader ) />
</cffunction>

</cfcomponent>