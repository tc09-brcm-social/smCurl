<html><head>
</head>
<body>
<pre>
	
<%= Request.ServerVariables("ALL_HTTP") %>&nbsp;
<%
Function GetAttribute(AttrName)
Dim AllAttrs 
Dim RealAttrName 
Dim Location 
Dim Result
AllAttrs = Request.ServerVariables("ALL_HTTP") 
RealAttrName = "HTTP_" & ucase(AttrName)
Location = instr(AllAttrs, RealAttrName & ":")
	if Location <= 0 then 
	GetAttribute = "" 
	Exit Function 
	end if
Result = mid(AllAttrs, Location + Len(RealAttrName) + 1)
Location = instr(Result, chr(10)) 
if Location <= 0 then 
Location = len(Result) + 1
End if
GetAttribute = left(Result, Location - 1) 
End Function
%>
</body>
</html>
