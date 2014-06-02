<!--#include file="conn.asp"-->
<%  
Dim keterangan,keynya
keterangan = Request.Form("Ket")
keynya = Request.Form("Key")

strSQL = "UPDATE onproject SET ket = '" & keterangan & "' " & _
	"WHERE                         " & _
	"	mnindex = '" & keynya & "'               " 
Set objExec = Conn.Execute(strSQL)  
If Err.Number = 0 Then  
Response.write("Save completed.")  
Else  
Response.write("Error Save ["&strSQL&"] ("&Err.Description&")")  
End If  
%>