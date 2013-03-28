<cfsilent>
	<cfsetting showdebugoutput="false" />
	<cfset request.modelGlueSuppressDebugging = true />
</cfsilent>
<cfset sleepDuration = Int(RandRange(1000, 2000,"SHA1PRNG"))  />
<cfset sleep( sleepDuration )>
<cfoutput>#sleepDuration# - #now()#</cfoutput>