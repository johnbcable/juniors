<%@language="JScript"%>
<!--#include file="functions.asp" -->
<!--#include file="strings.asp" -->
<!--#include file="emailfuncs.asp" -->
<%
var strtime, strdate, title2;
var clubname = new String("Hampton-In-Arden Sports Club");
var pagetitle = new String("Updating Details of Tournament");
// Now for any variables local to this page
var m_tourdate, m_tourtime, m_tourcost, m_tourtype, m_tourid, m_tourcontact;
var m_toururl, m_finalsdate, m_finalsstarttime, m_finalsendtime, m_tourtitle;
var m_tourwho;
var ConnObj;
var RS,RS2,RS3;
var SQLStmt, SQL2, SQL3;
var kount;
var memberknt;
var dbconnect=Application("hamptonsportsdb");
var debugging=true;
var updating=false;
// Set up default greeting strings
strdate = datestring();
strtime = timestring();
// End of page start up coding
// Initialise update variables
m_tourid = Trim(new String(Request.QueryString("tourid")));
m_tourdate = Trim(new String(Request.QueryString("tourstartdate")));
m_tourtime = Trim(new String(Request.QueryString("tourstarttime")));
m_tourenddate = Trim(new String(Request.QueryString("tourenddate")));
m_tourendtime = Trim(new String(Request.QueryString("tourendtime")));
m_tourtype = Trim(new String(Request.QueryString("tourcategory")));
m_finalsdate = Trim(new String(Request.QueryString("finalsdate")));
m_finalsstarttime = Trim(new String(Request.QueryString("finalsstarttime")));
m_finalsendtime = Trim(new String(Request.QueryString("finalsendtime")));
m_tourtitle = Trim(new String(Request.QueryString("tourtitle")));
m_tourwho = Trim(new String(Request.QueryString("tourwho")));
m_tourcontact = Trim(new String(Request.QueryString("tourcontact")));
m_tourcost = Trim(new String(Request.QueryString("tourcost")));

m_toururl = "tournaments.html";  // Constant right now

// Flag if this is a new tournament insertion 
newone = (m_tourid == "-1");

// reset if null
if (m_tourdate=="undefined" || m_tourdate == "null" || m_tourdate == "")
{
	today = new Date();
	m_tourdate = new String(ddmmyyyy(today)).toString();
}
if (m_tourtime=="undefined" || m_tourtime == "null" || m_tourtime == "")
	m_tourtime = new String("00:00:00").toString();
else
	m_tourtime = new String(m_tourtime.substr(0,2)+":"+m_tourtime.substr(2)+":00").toString();
if (m_tourtitle=="undefined" || m_tourtitle == "null" || m_tourtitle == "")
	m_tourtitle = new String("No tournament title supplied").toString();
if (m_tourtype=="undefined" || m_tourtype == "null" || m_tourtype == "")
	m_tourtype = new String("ADULT").toString();
if (m_toururl=="undefined" || m_toururl == "null" || m_toururl == "")
	m_toururl = new String("tournaments.html").toString();

// Do DB update
ConnObj=Server.CreateObject("ADODB.Connection");
RS=Server.CreateObject("ADODB.Recordset");
ConnObj.Open(dbconnect);
if (newone)
{
	// tourdate. tourtime, touryear, tourtype, tourtitle, tourid, tourreport
	// INSERT into EVENTS (tourdate,tourtime,touryear,tourtype,tourtitle,tourreport) values('13/01/2008','14:00:00',2008,'EVENT','Junior Tournament 2007 (Completion)','')
	SQL1 = new String("INSERT INTO tournaments ([tourtitle], [tourstart], [tourend], [tourfinalsday], [tourwho], [tourcontact], [tourstarttime], [tourendtime], 
		[finalsstarttime], [finalsendtime], [tourcost], [toururl], [tourcategory]) VALUES('"+m_tourtitle+"','"+m_tourdate+"',"+m_tourenddate+",'"+m_finalsdate+"','"+m_tourwho+"','"+m_tourcontact+"', '"+m_tourtime+"',
			 '"+m_tourendtime+"', '"+m_finalsstarttime+"', '"+m_finalsendtime+"',
			 '"+m_tourcost+"', '"+m_toururl+"', '"+m_tourtype+"')").toString();
}
else
{
	SQL1 = new String("UPDATE tournaments SET tourtitle='"+m_tourtitle+"', tourstart='"+m_tourdate+"', tourend='"+m_tourenddate+"', tourfinalsday='"+m_finalsdate+"', tourwho='"+m_tourwho+"' tourcontact='"+m_tourcontact+"', tourstarttime='"+m_tourtime+"', tourendtime='"+m_tourendtime+"',  finalsstarttime='"+m_finalsstarttime+"', finalsendtime='"+m_finalsendtime+"',tourcost="+m_tourcost+",toururl='"+m_toururl+"',tourcategory='"+m_tourtype+"' WHERE tourid = "+m_tourid).toString();
}
if (debugging)
{
	Response.Write("current_debug_status()<br />");
	Response.Write("m_tourid = "+m_tourid+"<br />");
	Response.Write("m_tourtitle = "+m_tourtitle+"<br />");
	Response.Write("m_tourdate = "+m_tourdate+"<br />");
	Response.Write("m_tourenddate = "+m_tourenddate+"<br />");
	Response.Write("m_finalsdate = "+m_finalsdate+"<br />");
	Response.Write("m_tourwho = "+m_tourwho+"<br />");
	Response.Write("m_tourcontact = "+m_tourcontact+"<br />");
	Response.Write("m_tourtime = "+m_tourtime+"<br />");
	Response.Write("m_tourendtime = "+m_tourendtime+"<br />");
	Response.Write("m_finalsstarttime = "+m_finalsstarttime+"<br />");
	Response.Write("m_finalsendtime = "+m_finalsendtime+"<br />");
	Response.Write("m_tourcost = "+m_tourcost+"<br />");
	Response.Write("m_toururl = "+m_toururl+"<br />");
	Response.Write("m_tourtype = "+m_tourtype+"<br /><hr /><br />");
	Response.Write("<br />SQL1 = ["+SQL1+"]<br />");
}
if (updating)
	RS = ConnObj.Execute(SQL1);
else
	Response.Write("<br />Update not applied<br />")
RS=null;
ConnObj.Close();
ConnObj=null;
if ((! current_debug_status()) && updating )
	Response.Redirect("tournaments.html");
%>

