<cfcomponent  extends="mxunit.framework.TestCase" output="false">

   <cffunction name="setup" returntype="void" access="public" output="false">
		<cfset portcullis = CreateObject("component", "ModelGlue.Util.portcullis.com.fusionlink.Portcullis").init()/>
   </cffunction>				

   <cffunction name="testIsSafeReferer" returntype="void" access="public" output="false">
		<cfset var result = portcullis.isSafeReferer()/>
		<cfset assertFalse(result,"isSafeReferer() - failed - this test is really optional")/>
   </cffunction>

   <cffunction name="testEscapeChars" returntype="void" access="public" output="false">
		<cfset var result = portcullis.escapeChars("<cfscript>session.userid = 23;</cfscript>")/>
		<cfset assertEquals("&lt;cfscript&gt;session.userid = 23&##59;&lt;/cfscript&gt;",result,"escapeChars() - failed")/>
   </cffunction>

	<!---Test the main scan() method--->
   <cffunction name="testScan1" returntype="void" access="public" output="false">
		<cfset form.firstname = "John"/>
		<cfset form.lastname = "Mason"/>
		<cfset form.city = "Atlanta"/>
		<cfset portcullis.scan(form,"form",cgi.remote_addr)/>
		<cfset assertFalse(portcullis.isLogged(cgi.remote_addr),"scan() - failed on testScan1, good data")/>
		<cfset assertEquals("Atlanta",form.city,"scan() - failed on testScan1, good data")/>
   </cffunction>

   <cffunction name="testScan2" returntype="void" access="public" output="false">
		<cfset form.firstname = "John"/>
		<cfset form.lastname = "Mason<IMG SRC=""javascript:alert('XSS');"">"/>
		<cfset form.city = "Atlanta"/>
		<cfset portcullis.scan(form,"form",cgi.remote_addr)/>
		<cfset assertTrue(portcullis.isLogged(cgi.remote_addr),"scan() - failed on testScan2, bad data")/>
		<cfset assertEquals("Mason&lt;IMG SRC=&quot;[INVALID]alert&##40;&##39;XSS&##39;&##41;&##59;&quot;&gt;",form.lastname,"scan() - failed on testScan2, bad data[#form.lastname#]")/>
   </cffunction>

   <cffunction name="testScan3" returntype="void" access="public" output="false">
		<cfset form.firstname = "John"/>
		<cfset form.lastname = "Mason union select * from users;"/>
		<cfset form.city = "Atlanta"/>
		<cfset portcullis.scan(form,"form",cgi.remote_addr)/>
		<cfset assertTrue(portcullis.isLogged(cgi.remote_addr),"scan() - failed on testScan3, bad data")/>
		<cfset assertEquals("Mason union [INVALID] * from users&##59;",form.lastname,"scan() - failed on testScan3, bad data")/>
   </cffunction>

	<cffunction name="testScan4" returntype="void" access="public" output="false">
		<cfset form.firstname = "John"/>
		<cfset form.lastname = "Select a time to drop me a line for our update on the project"/>
		<cfset form.city = "Atlanta"/>
		<cfset portcullis.scan(form,"form",cgi.remote_addr)/>
		<cfset assertTrue(portcullis.isLogged(cgi.remote_addr),"scan() - failed on testScan3, bad data")/>
		<cfset assertEquals("[Invalid] a time to [Invalid] me a line for our [Invalid] on the project",form.lastname,"scan() - failed on testScan3, bad data")/>
   </cffunction>

   <!---Test Good stuff--->
   <cffunction name="testFilterSQL" returntype="void" access="public" output="false">
		<cfset var result = portcullis.filterSQL('name=fred&class=b101')/>
		<cfset assertEquals(result.originaltext,result.cleantext,"filterSQL() - failed on clean data test")/>
   </cffunction>

   <cffunction name="testFilterWords" returntype="void" access="public" output="false">
		<cfset var result = portcullis.filterWords('name=fred&class=b101')/>
		<cfset assertEquals(result.originaltext,result.cleantext,"filterWords() - failed on clean data test")/>
   </cffunction>

   <cffunction name="testFilterTags" returntype="void" access="public" output="false">
		<cfset var result = portcullis.filterTags('name=fred&class=b101')/>
		<cfset assertEquals(result.originaltext,result.cleantext,"filterTags() - failed on clean data test")/>
   </cffunction>

   <cffunction name="testFilterCRLF" returntype="void" access="public" output="false">
		<cfset var result = portcullis.filterCRLF('Watch spot run')/>
		<cfset assertEquals(result.originaltext,result.cleantext,"filterCRLF() - failed on clean data test")/>
   </cffunction>

   <!---Test Bad stuff--->
   <cffunction name="testFilterSQLBad" returntype="void" access="public" output="false">
		<cfset var result = portcullis.filterSQL('name=fred union select * from users')/>
		<cfset assertTrue(result.detected,"filterSQL() - failed on bad data test")/>
   </cffunction>

   <cffunction name="testFilterWordsBad" returntype="void" access="public" output="false">
		<cfset var result = portcullis.filterWords("<IMG SRC=""javascript:alert('XSS');"">")/>
		<cfset assertTrue(result.detected,"filterWords() - failed on clean data test")/>
   </cffunction>

   <cffunction name="testFilterTagsBad" returntype="void" access="public" output="false">
		<cfset var result = portcullis.filterTags('<SCRIPT SRC=http://ha.ckers.org/xss.js></SCRIPT>')/>
		<cfset assertTrue(result.detected,"filterTags() - failed on bad data test")/>
   </cffunction>

   <cffunction name="testFilterCRLFBad" returntype="void" access="public" output="false">
		<cfset var result = portcullis.filterCRLF('Watch spot#chr(10)##chr(13)##chr(10)##chr(13)#run')/>
		<cfset assertTrue(result.detected,"filterCRLF() - failed on bad data test")/>
   </cffunction>

	<!---Logging Tests--->
   <cffunction name="testGetLog" returntype="void" access="public" output="false">
		<cfset portcullis.setLog(cgi.REMOTE_ADDR)/>
		<cfset assertEquals(1,portcullis.getLog().recordcount,"getLog() - failed")/>
   </cffunction>

   <cffunction name="testIsLogged" returntype="void" access="public" output="false">
		<cfset portcullis.setLog(cgi.REMOTE_ADDR)/>
		<cfset assertTrue(portcullis.isLogged(cgi.REMOTE_ADDR),"isLogged() - failed")/>
   </cffunction>

   <cffunction name="testIsBlocked" returntype="void" access="public" output="false">
		<cfset portcullis.setLog(cgi.REMOTE_ADDR)/>
		<cfset assertFalse(portcullis.isBlocked(cgi.REMOTE_ADDR),"isBlocked() - failed")/>
   </cffunction>

   <cffunction name="testCleanLog" returntype="void" access="public" output="false">
		<cfset assertTrue(portcullis.cleanLog(),"cleanLog() - failed")/>
   </cffunction>

   <cffunction name="testUpdateLog" returntype="void" access="public" output="false">
		<cfset portcullis.setLog(cgi.REMOTE_ADDR)/>
		<cfset portcullis.setLog(cgi.REMOTE_ADDR)/>
		<cfset portcullis.setLog(cgi.REMOTE_ADDR)/>
		<cfset assertTrue(portcullis.updateLog(cgi.REMOTE_ADDR),"updateLog() - failed")/>
   </cffunction>

   <cffunction name="testRemoveIPfromLog" returntype="void" access="public" output="false">
		<cfset portcullis.setLog(cgi.REMOTE_ADDR)/>
		<cfset assertTrue(portcullis.removeIPfromLog(cgi.REMOTE_ADDR),"removeIPfromLog() - failed")/>
   </cffunction>

   <cffunction name="testInsertLog" returntype="void" access="public" output="false">
		<cfset assertTrue(portcullis.insertLog(cgi.REMOTE_ADDR),"insertLog() - failed")/>
   </cffunction>

</cfcomponent>