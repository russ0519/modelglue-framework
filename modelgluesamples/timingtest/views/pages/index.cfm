<cfsilent>
    <cfset endTime = getTickCount() />
    <cfset totalTime = endTime - request.startTime />

	<!--- Push this value into the event state to make it easier to create an app init event link --->
	<cfset event.setValue('init','true') />
</cfsilent>

<cfoutput>

	<p>
		<b>#event.getEventHandlerName()#</b><br>
		Number of Additional Controllers: #request.numControllers#<br>
		Number of Additional Event Handlers: #request.numEventHandlers#<br>
		Number of 'needSomething' Listener Invocations: #event.getValue('listenCount','0')#<br>
		Start time: #request.startTime# <br>
		End time: #endTime#<br>
		Total time: #totalTime# ms
	</p>

	<p>
		<a href="#event.linkTo('page.broadcast')#">Test Broadcast Event</a>
		| <a href="#event.linkTo('page.index')#">Reload Home Page</a>
		| <a href="#event.linkTo('page.index','init')#">Reload Application</a>
	</p>
	
	<table cellspacing="5" cellpadding="5">
		<tr>

		<cfloop from="1" to="10" index="col">
			<cfset startEh = ((col-1) * 100) + 1 />
			<cfif startEh lte request.numEventHandlers>
			<td>
				<cfloop from="#startEh#" to="#(startEh+99)#" index="i">
					<cfif i lte request.numEventHandlers>
						<a href="#event.linkTo('event#i#')#">Event #i#</a><br>
					</cfif>
				</cfloop>
			</td>
			</cfif>
		</cfloop>
		
		</tr>
	
	</table>
	
</cfoutput>