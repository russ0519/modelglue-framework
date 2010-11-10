<cfsilent>
    <cfset endTime = getTickCount() />
    <cfset totalTime = endTime - request.startTime />
</cfsilent>

<cfoutput>

	<p>
		<b>#event.getEventHandlerName()#</b><br>
		Start time: #request.startTime# <br>
		End time: #endTime#<br>
		Total time: #totalTime# ms
	</p>
	
	<table cellspacing="5" cellpadding="5">
		<tr>
			
			<td>
				<cfloop from="1" to="100" index="i">
					<a href="#event.linkTo('event#i#')#">Event #i#</a><br>
				</cfloop>
			</td>
			
			<!--- For the '100' tests, I comment out the remaining table cells --->
			
			<td>
				<cfloop from="101" to="200" index="i">
					<a href="#event.linkTo('event#i#')#">Event #i#</a><br>
				</cfloop>
			</td>
			
			<td>
				<cfloop from="201" to="300" index="i">
					<a href="#event.linkTo('event#i#')#">Event #i#</a><br>
				</cfloop>
			</td>
			
			<td>
				<cfloop from="301" to="400" index="i">
					<a href="#event.linkTo('event#i#')#">Event #i#</a><br>
				</cfloop>
			</td>
			
			<td>
				<cfloop from="401" to="500" index="i">
					<a href="#event.linkTo('event#i#')#">Event #i#</a><br>
				</cfloop>
			</td>
			
			<td>
				<cfloop from="501" to="600" index="i">
					<a href="#event.linkTo('event#i#')#">Event #i#</a><br>
				</cfloop>
			</td>
			
			<td>
				<cfloop from="601" to="700" index="i">
					<a href="#event.linkTo('event#i#')#">Event #i#</a><br>
				</cfloop>
			</td>
			
			<td>
				<cfloop from="701" to="800" index="i">
					<a href="#event.linkTo('event#i#')#">Event #i#</a><br>
				</cfloop>
			</td>
			
			<td>
				<cfloop from="801" to="900" index="i">
					<a href="#event.linkTo('event#i#')#">Event #i#</a><br>
				</cfloop>
			</td>
			
			<td>
				<cfloop from="901" to="1000" index="i">
					<a href="#event.linkTo('event#i#')#">Event #i#</a><br>
				</cfloop>
			</td>
		
		</tr>
	
	</table>
	
</cfoutput>