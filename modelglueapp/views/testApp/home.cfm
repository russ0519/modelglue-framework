<!doctype html>

<html>

<head>
	<title>A blank HTML5 page</title>
	<meta charset="utf-8" />
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
</head>

<body>
	<cfloop from="1" to="20" index="i">
	request <cfoutput>#i#</cfoutput>: <span id="request<cfoutput>#i#</cfoutput>"></span><br />
	<script>
	$(document).ready(function() {
		
		
		
		$.ajax({
			url: '<cfoutput>#event.linkTo('getTime')#</cfoutput>',
			type: "post",
			data:{rand:'<cfoutput>#Rand()#</cfoutput>'},
			beforeSend:function(){
				$('#request<cfoutput>#i#</cfoutput>').html('Getting Date');
			},
			success: function(html) {
				$('#request<cfoutput>#i#</cfoutput>').html( html );
			},
			error: function(html) {
				$('#request<cfoutput>#i#</cfoutput>').html( 'ERROR' );
			}
		});
	  
	});
	</script>
	
	</cfloop>
</body>

</html>