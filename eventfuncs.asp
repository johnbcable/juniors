<script language=JScript runat=Server>
//
//  getFutureEvents( limit)               returns string
//  getEventByID(eventid)               returns Event object
//
function getFutureEvents(howmanylimit)
{
	// Establish local variables
	var RS, RS2, Conn, SQL1, SQL2, dbconnect, uniqref;
	var debugging = false;
	var editline, Eventsubject;
	var Eventlist = new String("").toString();
	var Eventknt = 0;
	var eventclass;
	var totaltoget = new Number(howmanylimit);
	totaltoget = totaltoget.valueOf();
	// Set up database connections
	var dbconnect=Application("hamptonsportsdb"); 
	Conn = Server.CreateObject("ADODB.Connection");
	RS = Server.CreateObject("ADODB.RecordSet");
	Conn.Open(dbconnect);
	// Need to query last 5 Events sent and return as string
	// title<hr><br>event1<br>event2<br> .... eventN<hr>
	SQL1 = new String("SELECT * from futureevents").toString();
	Eventlist += '<div id="futureevents"><ol>';
	RS = Conn.Execute(SQL1);
	Eventknt = 0;
	while (! RS.EOF && Eventknt < totaltoget)
	{
		eventclass = new String(RS("eventtype")).toString();
		eventclass = eventclass.toLowerCase();
		Eventlist += '<li class="'+eventclass+'">'+RS("dateofevent")+' - '+RS("eventnote")+'</li>';
		Eventknt++;
		RS.MoveNext();
	}
	Eventlist += '</ol><p><a href="eventlist.asp">more events</a></p>';
	Eventlist += '</div>';
	RS.Close();
	return (Eventlist);
}
//=====================================================================
function getEventByID(eventid)
{
	// Establish local variables
	var Eventobj = new Object();
	var RS, RS2, Conn, SQL1, SQL2, dbconnect, uniqref;
	// Set up database connections
	var dbconnect=Application("hamptonsportsdb"); 
	Conn = Server.CreateObject("ADODB.Connection");
	RS = Server.CreateObject("ADODB.RecordSet");
	Conn.Open(dbconnect);
	// Need to query particular Event database entry from fileref
	SQL1 = new String("SELECT * from events where Eventid="+eventid).toString();
	RS = Conn.Execute(SQL1);
	while (! RS.EOF)
	{
		Eventobj.Eventfile = new String(RS("Eventfile")).toString();
		Eventobj.subject = new String(RS("subject")).toString();
		Eventobj.senton = new String(RS("dateofEvent")).toString();
		Eventobj.attach1 = new String(RS("attach1")).toString();
		Eventobj.attach2 = new String(RS("attach2")).toString();
		Eventobj.attach3 = new String(RS("attach3")).toString();
		Eventobj.circulation = new String(RS("circulation")).toString();
		Eventobj.numbersent = new String(RS("number_sent")).toString();
		Eventobj.Eventid = new String(RS("Eventid")).toString();
		RS.MoveNext();
	}
	RS.Close();
	return (Eventobj);
}
</script>
