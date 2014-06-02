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

	<script type="text/javascript" src="js/noty/packaged/jquery.noty.packaged.min.js"></script>

	<script type="text/javascript">
		function editNode(node){
			var prevTitle = node.data.title,
				tree = node.tree;
			// Disable dynatree mouse- and key handling
			tree.$widget.unbind();
			// Replace node with <input>
			$(".dynatree-title", node.span).html("<input id='editNode' value='" + prevTitle + "'>");
			// Focus <input> and bind keyboard handler
			$("input#editNode")
				.focus()
				.keydown(function(event){
				switch( event.which ) {
				case 27: // [esc]
					// discard changes on [esc]
					$("input#editNode").val(prevTitle);
					PostData(node.data.key)
					$(this).blur();
					break;
				case 13: // [enter]
					// simulate blur to accept new value
					$(this).blur();
					break;
				}
				}).blur(function(event){
					// Accept new value, when user leaves <input>
					var title = $("input#editNode").val(),
						key = node.data.key;
					node.setTitle(title);
					
					if(title != prevTitle){
						//send to process.asp
						PostData(key,title)
					}
					
					// Re-enable mouse and keyboard handlling
					tree.$widget.bind();
					node.focus();
				}).click(function(){
					return false;
				});
				
		}
		
		$(function(){
			$("#tree").dynatree({
				onClick:function(node,event){
					if(event.shiftKey){
						editNode(node);
						return false;
					}
				},
				onDblClick: function(node){
					console.log(node)
					editNode(node);
					return false;
				},
				onKeydown: function(node, event) {
					switch( event.which ) {
					case 113: // [F2]
						editNode(node);
						return false;
					case 13: // [enter]
						if( isMac ){
						editNode(node);
						return false;
						}
					}
				}
			});
		});
		
		var PostData = function(key,ket){
			$.ajax({
				type: "POST",
				url: "Process.asp",
				data: {
					Key: key,
					Ket: ket
				}
			}).done(function(){
				var success = generateNoty('success');
				 $.noty.setText(success.options.id, 'Data Saved..');
			});
		}
		
		var generateNoty = function (type) {
			var n = noty({
				text        : type,
				type        : type,
				dismissQueue: true,
				layout      : 'topCenter',
				theme       : 'defaultTheme',
				timeout		: 2000
			});
			console.log(type + ' - ' + n.options.id);
			return n;
		}
		
		
	</script>
</head>  
<body>  
<!--#include file="tree.asp"-->
</body>  
</html> 

