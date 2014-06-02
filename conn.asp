<%
Dim Conn,strSQL,objRec,arrField,fRsTemp,fSQLQuery  
Set Conn = Server.Createobject("ADODB.Connection")  
Conn.Open "Driver={SQL Server};Server=localhost;Database=TestTreeMenu;UID=sa;PWD=zeihan12345!;"  
%>