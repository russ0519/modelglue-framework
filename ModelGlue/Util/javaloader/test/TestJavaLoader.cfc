<cfcomponent  extends="modelglue.gesture.test.ModelGlueAbstractTestCase">
	<cffunction name="testJavaLoader" returntype="void" access="public">
		<cfset var paths = arrayNew(1) />
		<cfset var javaLoaderMGPath = "ModelGlue.Util.javaloader.JavaLoader" />
			<!--- 			This points to the jar we want to load. 		Could also load a directory of .class files --->
		<cfset paths[1] = expandPath("helloworld.jar") />
		<!--- create the loader --->
		<cfset loader = createObject("component", javaLoaderMGPath).init(paths) />
		<!--- at this stage we only have access to the class, but we don't have an instance --->
		<cfset HelloWorld = loader.create("HelloWorld") />
		<!--- Create the instance, just like me would in createObject("java", "HelloWorld").init()
			This also could have been done in one line - loader.create("HelloWorld").init(); --->
		<cfset hello = HelloWorld.init() />
		<cfset assertTrue( hello.hello() IS "Hello World", "Javaloader didn't work. Is it really here: #javaLoaderMGPath#?") />
	</cffunction>
</cfcomponent>