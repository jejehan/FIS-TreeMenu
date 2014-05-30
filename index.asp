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
			$("#tree").dynatree();
		});
	</script>
</head>  
<body>  

<%  
Dim Conn,strSQL,objRec,arrField,fRsTemp,fSQLQuery  
Set Conn = Server.Createobject("ADODB.Connection")  
Conn.Open "Driver={SQL Server};Server=localhost;Database=TestTreeMenu;UID=sa;PWD=zeihan12345!;"  

function CreateTree(N)
	CreateTree = ""
	Set objRec = Server.CreateObject("ADODB.Recordset")  
	
	strSQL = "SELECT * FROM onproject WHERE visible=1 AND LEN(mnindex) = " & N & " order by mnindex"
	objRec.Open strSQL, Conn, 1,3 
	
	While Not objRec.EOF  
			CreateTree = CreateTree & "<li class='folder'>" & objRec("mnindex") & " - " & objRec("ket") & "<ul>"
			CreateTree = CreateTree &   createChild(objRec("mnindex"),N+2)
	objRec.MoveNext  
	CreateTree = CreateTree & "</ul>"
	Wend 
	objRec.Close()  

  CreateTree =  CreateTree 
end function

function createChild(mnindex,N)
	dim objRec1
	Set objRec1 = Server.CreateObject("ADODB.Recordset")  
	strSQL = "SELECT * FROM onproject WHERE visible=1 AND mnindex LIKE'" & mnindex & "%' AND LEN(mnindex) = " & N & "  order by mnindex"
	objRec1.Open strSQL, Conn, 1,3 

	While Not objRec1.EOF  
			createChild = createChild & "<li" 
			if objRec1("tipemenu") <> "A" then
				createChild =createChild & " class='folder' "
			end if
			createChild =createChild & " >" & objRec1("mnindex") & " - " & objRec1("ket") 
			if IsLastChild(objRec1("mnindex"),2) then
				createChild =createChild & "<ul class='here'>"
			end if
			createChild = createChild &  createChild(objRec1("mnindex"),N+2)
	objRec1.MoveNext  
	if IsLastChild(mnindex,4) then
		createChild = createChild & "<span='gg'/></ul>  "
	end if
	Wend 
	objRec1.Close()  
	
	createChild = createChild
end function


function IsLastChild(mnindex,N)
	
	dim objRec1,JmlChar
	IsLastChild = true
	JmlChar = LEN(mnindex)
	Set objRec1 = Server.CreateObject("ADODB.Recordset")  
	strSQL = "SELECT * FROM onproject WHERE visible=1 AND mnindex LIKE'" & mnindex & "%' AND LEN(mnindex) = " & JmlChar + N & "  order by mnindex"
	'Response.Write strSQL & "<br>"
	objRec1.Open strSQL, Conn, 1,3 
	if objRec1.EOF then
		IsLastChild = false
	end if
end function

'#Search menu function
'session("LastParent") = ""
'function CreateTreeSearch(fSearch)
'	DIM N,i
'	CreateTreeSearch = ""
'	N = 2
'	Set objRec = Server.CreateObject("ADODB.Recordset")  
'	
'	strSQL = "SELECT * FROM onproject WHERE visible=1 AND namasubmen LIKE '%" & fSearch & "%' order by mnindex"
'	objRec.Open strSQL, Conn, 1,3 
'	
'	While Not objRec.EOF  
'			
'			CreateTreeSearch = CreateTreeSearch &   createParent(LEFT(objRec("mnindex"),LEN(objRec("mnindex"))-2),LEN(objRec("mnindex"))-2)
'			CreateTreeSearch = CreateTreeSearch & "<li>" & objRec("mnindex") & " - " & objRec("ket")
'			'if LEN(objRec("mnindex")) > 3 then
'			'	for i=1 TO LEN(objRec("mnindex"))/2
'			'		CreateTreeSearch = CreateTreeSearch & "</ul>"
'			'	next
'			'end if
'	objRec.MoveNext  
'	
'	Wend 
'	objRec.Close()  
'
'  CreateTreeSearch =  CreateTreeSearch 
'end function
'
'function createParent(mnindex,N)
'	dim objRec1
'	Set objRec1 = Server.CreateObject("ADODB.Recordset")  
'	
'	strSQL = "SELECT * FROM onproject WHERE visible=1 AND mnindex LIKE'" & mnindex & "%' AND LEN(mnindex) = " & N & " order by mnindex"
'	objRec1.Open strSQL, Conn, 1,3 
'	'Response.Write  strSQL & "<br>"
'	if N <2 then
'		exit function
'	end if
'	While Not objRec1.EOF  
'			
'			if mnindex <> session("LastParent") OR session("LastParent") = "" then
'				
'				createParent = createParent &  createParent(LEFT(objRec("mnindex"),LEN(mnindex)-2),N-2)
'				if  LEFT(session("LastParent"),N) <> objRec1("mnindex") THEN  
'					createParent = createParent & "<li>" & objRec1("mnindex") & " - " & objRec1("ket")
'				else
'					createParent = createParent & "</ul>"
'				end if
'			end if
'			
'			session("LastParent") = mnindex
'	objRec1.MoveNext  
'	createParent = createParent & "<ul>"
'	Wend 
'	objRec1.Close()  
'	
'	createParent = createParent
'end function

Response.Write "<div id='tree'>"
Response.Write  "<ul style='display:none'>"
Response.Write CreateTree(2)
Response.Write  "</ul>"
Response.Write "</div>"

'Response.Write  "<ul>"
''Response.Write CreateTree(2)
'Response.Write  CreateTreeSearch("user")
'Response.Write  "</ul>"

%>
</body>  
</html> 

