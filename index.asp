<% Option Explicit %>  
<!DOCTYPE HTML>
<head>  
  
	<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
	<title>Test</title>
	<script src="jquery/jquery.js" type="text/javascript"></script>
	<script src="jquery/jquery-ui.custom.js" type="text/javascript"></script>
	<script src="jquery/jquery.cookie.js" type="text/javascript"></script>

	<link href="src/skin-vista/ui.dynatree.css" rel="stylesheet" type="text/css">
	<script src="src/jquery.dynatree.js" type="text/javascript"></script>

	<script type="text/javascript">
		$(function(){
			$("#tree").dynatree({
				onActivate:function(node,event){
					 window.open(dtnode.data.url); 
				}
			});
		});
	</script>
</head>  
<body>  
<!--#include file="tree.asp"-->
</body>  
</html> 

