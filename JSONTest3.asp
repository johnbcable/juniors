<%@language="VBScript"%>
<!--#include file="JSON_2.0.4.asp" -->
<!--#include file="JSON_UTIL_0.1.1.asp" -->
<%
' This page tests sending back JSON data to a requesting agent
'Dimension variables
Dim adoCon         'Holds the Database Connection Object
Dim rsDB		   'Holds the recordset for the records in the database
Dim strSQL         'Holds the SQL query to query the database	
Dim dataSource	   'Holds the name of the data source from the Application object
Dim dataResults    'Holds results from the JSON query

'Retrieve the datSource name from the Application object
dataSource = Application("hamptonsportsdb")
'Create an ADO connection object
Set adoCon = Server.CreateObject("ADODB.Connection")	
'Set an active connection to the Connection object using DSN connection
adoCon.Open dataSource
'Create an ADO recordset object
Set rsDB = Server.CreateObject("ADODB.Recordset")	
'Initialise the strSQL variable with an SQL statement to query the database
strSQL = "SELECT * FROM futureevents ORDER BY sortabledate ASC;"	

dataResults = QueryToJSON(adoCon, strSQL).Flush

Response.ContentType = "application/json"
Response.Write(dataResults)
Response.End
%>
