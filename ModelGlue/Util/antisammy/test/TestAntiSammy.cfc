<cfcomponent  extends="modelglue.gesture.test.ModelGlueAbstractTestCase">

	<cffunction name="testAntiSammy" returntype="void" access="public">
		
		<cfset var paths = arrayNew(1) />
		<cfset var libsDirectoryPath = expandPath('../libs') />
		<cfset var javaLoaderMGPath = "ModelGlue.Util.javaloader.JavaLoader" />
		<cfset var basicPolicyFile =  expandPath("../policyfiles/antisamy-1.3.xml") />
		<cfset var ebayPolicyFile =  expandPath("../policyfiles/antisamy-ebay-1.3.xml")  />
		<cfset var slashdotPolicyFile =  expandPath("../policyfiles/antisamy-slashdot-1.3.xml")  />
		<cfset var paranoidPolicyFile =  expandPath("../policyfiles/antisamy-anythinggoes-1.3.xml")  />
		<cfset var CleanContent = "" />
		<cfset var DirtyContent = "" />
		<cfdirectory action="list" directory="#libsDirectoryPath#" name="libsDirectory" />
		<cfsavecontent variable="CleanContent">
			<img src="http://some.where.over.the.rainbow.com/image.png">
		</cfsavecontent>
		
		<cfsavecontent variable="DirtyContent">
			<script>alert('xss 1');</script>
			<div style="background:url('javascript:alert('xss 2')')">Some bad HTML!</div>
		</cfsavecontent>
		
		
		
		<!--- 			This points to the jar we want to load. 		Could also load a directory of .class files --->
<!--- 		<cfloop query="libsDirectory">
		asdasd
		</cfloop> --->
		<cfset paths[1] = expandPath("../antisamy-bin.1.3.jar") />
		<!--- <cfset paths = arrayAppend( paths, "#libsDirectoryPath#/#libsDirectory.name#" )> --->
<!--- 		<cfset arrayAppend( paths, expandPath("../libs/batik-css.jar") ) />
		<cfset arrayAppend( paths, expandPath("../libs/batik-util.jar") )  />
		<cfset arrayAppend( paths, expandPath("../libs/commons-codec-1.3.jar")  ) />
		<cfset arrayAppend( paths, expandPath("../libs/commons-httpclient-3.1.jar") )  />
		<cfset arrayAppend( paths, expandPath("../libs/commons-logging-1.1.1.jar") )  />
		<cfset arrayAppend( paths, expandPath("../libs/junit-4.4.jar") )  />
		<cfset arrayAppend( paths, expandPath("../libs/nekohtml.jar") )  /> --->
<!--- 		<cfset paths[9] = expandPath("../xercesImpl.jar") /> --->
		<cfset arrayAppend( paths, expandPath("../libs/xml-apis.jar") )  />
		<cfset arrayAppend( paths, expandPath("../libs/xml-apis-ext.jar") )  />
		<cfset arrayAppend( paths, expandPath("../libs/xercesImpl.jar") )  />
		<!--- create the loader --->
		<cfset loader = createObject("component", javaLoaderMGPath).init(paths) />
		<!--- at this stage we only have access to the class, but we don't have an instance --->
		<!--- Create the instance --->
		<cfset AntiSamy = loader.create("org.owasp.validator.html.AntiSamy") />
		<!--- Make sure the instance is an object --->
		<cfset assertTrue( isObject(AntiSamy) IS true, "AntiSammy is not an object. Something bad happened") />
		<!--- Make sure the CleanContent code comes out  unmolested  with each policy file--->
		<cfset assertTrue( fileExists( basicPolicyFile) IS true, "The Basic Policy File was not found here #basicPolicyFile#") />
		<cfset assertTrue( fileExists( ebayPolicyFile) IS true, "The Ebay Policy File was not found here #ebayPolicyFile#") />
		<cfset assertTrue( fileExists( slashdotPolicyFile) IS true, "The Slashdot Policy File was not found here #slashdotPolicyFile#") />
		<cfset assertTrue( fileExists( paranoidPolicyFile) IS true, "The Paranoid Policy File was not found here #paranoidPolicyFile#") />
		<cfset result = AntiSamy.scan(CleanContent, basicPolicyFile) />
<!--- 		<cfset assertTrue(   IS CleanContent, "CleanContent got altered with the basicPolicyFile" ) /> --->
		
<!--- 		<cfset assertTrue( AntiSammy.scan(CleanContent, ebayPolicyFile) IS CleanContent, "CleanContent got altered with the ebayPolicyFile" ) />
		<cfset assertTrue( AntiSammy.scan(CleanContent, slashdotPolicyFile) IS CleanContent, "CleanContent got altered with the slashdotPolicyFile" ) />
		<cfset assertTrue( AntiSammy.scan(CleanContent, paranoidPolicyFile) IS CleanContent, "CleanContent got altered with the paranoidPolicyFile" ) /> --->
		<!--- Make sure the dirty code comes out cleaned with each policy file --->
<!--- 		<cfset assertTrue( AntiSammy.scan(DirtyContent, basicPolicyFile).getCleanHTML() IS NOT DirtyContent, "CleanContent got altered with the basicPolicyFile" ) />
		<cfset assertTrue( AntiSammy.scan(DirtyContent, ebayPolicyFile).getCleanHTML() IS NOT DirtyContent, "CleanContent got altered with the ebayPolicyFile" ) />
		<cfset assertTrue( AntiSammy.scan(DirtyContent, slashdotPolicyFile).getCleanHTML() IS NOT DirtyContent, "CleanContent got altered with the slashdotPolicyFile" ) />
		<cfset assertTrue( AntiSammy.scan(DirtyContent, paranoidPolicyFile).getCleanHTML() IS NOT DirtyContent, "CleanContent got altered with the paranoidPolicyFile" ) /> --->
		
		
	</cffunction>
	
</cfcomponent>