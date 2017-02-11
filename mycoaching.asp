<%@language="JScript"%>
<!--#include file="functions.asp" -->
<!--#include file="strings.asp" -->
<!--#include file="emailfuncs.asp" -->
<%
// First variables that need to be set for each page
var strtime, strdate;
var clubname = new String("Hampton-In-Arden Tennis Club");
var pagetitle = new String("<<pagetitle >>");
// Now for any variables local to this page
var debugging=false;
var ConnObj, RS, RS2, SQL1, SQL2, SQL3;
var myname, displaydate;
// Set up default greeting strings
strdate = datestring();
strtime = timestring();
myname = new String("").toString();
if (signedin())
	myname = getUserName();
var displaydate = dateasstring(Date());
var debugging=current_debug_status();
//
// Now get the dob from the form (or query string) and
// calculate which bit of the competition framework to 
// redirect to
//
var mydob = new String(Request.Form("dob")).toString();
if (mydob == "" || mydob == "null" || mydob == "undefined")
{
  mydob = new String(Request.QueryString("dob")).toString();
  if (mydob == "" || mydob == "null" || mydob == "undefined")
    mydob = new String("");
}
var debug = new String(Request.Form("debug")).toString();
if (debug == "" || debug == "null" || debug == "undefined")
{
  debug = new String(Request.QueryString("debug")).toString();
  if (debug == "" || debug == "null" || debug == "undefined")
    debug = new String("N");
}
debugging = false;
// if (mydob == "")
//  Response.Redirect("framework.asp");
var dobday, dobmonth, dobyear;
var dobparts = mydob.split("/");
if (dobparts.length != 3)
  Response.Redirect("framework.asp");
dobday = new Number(dobparts[0]).toString();
dobmonth = new Number(dobparts[1]).toString();
dobyear = new Number(dobparts[2]).toString();
var dobdate = new Date(dobparts[2],(dobparts[1]-1),dobparts[0]);
var today = new Date();
var todayday = today.getDate();
var todaymonth = today.getMonth()+1;
var todayYear = today.getFullYear();
var yearage = todayYear - dobyear;
var myageinmonths; 
if ( todaymonth > dobmonth)
{
  myageinyears = yearage;
  myageinmonths = (myageinyears * 12) + (todaymonth-dobmonth);
}
else
{
  if ( todaymonth < dobmonth)
  {
    myageinyears = yearage - 1;
    myageinmonths = (myageinyears * 12) + (todaymonth);
  }
  else   // todays month = my dob month
  {
    if (todayday < dobday)
    {
      myageinyears = yearage -1;
      myageinmonths = (myageinyears * 12) + (todaymonth);
    }
    else
    {
      if (todayday == dobday)
      {
        myageinyears = yearage;
        myageinmonths = (myageinyears * 12);
      }
     else
     {
        myageinyears = yearage;
        myageinmonths = (myageinyears * 12) + (todaymonth - 1);
     }
    }
  }
}
var myageinms = today-dobdate;
var oneMinute = 60 * 1000  // milliseconds in a minute
var oneHour = oneMinute * 60
var oneDay = oneHour * 24
var oneWeek = oneDay * 7
var myageinweeks = Math.round((myageinms/oneWeek));
var ydummy = Math.round(myageinweeks % 52);
mydob = dateasstring(dobdate);
// if (ydummy > 0)
//  myageinyears = myageinyears - 1;
//
// Age calculation done - now reroute to required cf page
//
// if (myageinyears < 8)
//  Response.Redirect("minired.asp?dob="+mydob);
// if (myageinyears > 18)
//  Response.Redirect("nomini.asp?zz="+myageinyears+"&dob="+mydob);
// if (myageinyears > 10)
//  Response.Redirect("miniyellow.asp?dob="+mydob);
// if (myageinyears > 9)
//  Response.Redirect("minigreen.asp?dob="+mydob);
// if (myageinyears > 8)
//  Response.Redirect("miniorange.asp?dob="+mydob);
// if (myageinyears == 8)
//  Response.Redirect("minired.asp?dob="+mydob+"&transition=Y");
// End of page start up coding
%>
<!doctype html>
<html class="no-js" lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Hampton-in-Arden Tennis Club - Juniors - My Best Coaching Fit</title>
    <link rel="stylesheet" href="bower_components/foundation/css/normalize.css" />
    <link rel="stylesheet" href="css/base.css" />
    <link rel="stylesheet" href="css/styles.css" />
    <script src="bower_components/modernizr/modernizr.js"></script>
  </head>
  <body>

<!--
<nav class="top-bar" data-options"is_hover: false">
-->
<!--
<div class="contain-to-grid">
-->
  <nav class="top-bar" role="navigation" data-topbar>
    <ul class="title-area">
      <!-- Title Area -->
      <li class="name">
        <a href="https://hamptontennis.org.uk"><img src="./img/small_logo.gif" /></a><br />
        <!-- <h1><a href="#">Hampton-in-Arden Tennis Club </a></h1>   -->
      </li>
      <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
      <li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>
    </ul>

    <section class="top-bar-section">
      <!-- Right Nav Section -->
      <ul class="right">
        <li><a href="index.html">Home</a></li>
        <li class="active"><a href="coaching.html">Coaching</a></li>
        <li><a href="socialtennis.html">Social Tennis</a>
        <li><a href="compete.html">Compete</a>
        <li><a href="holidaycamps.html">Holiday Clubs</a></li>
        <li class="has-form">
          <div class="row collapse">
            <div class="large-8 small-9 columns">
              <input type="text" placeholder="Search">
            </div>
            <div class="large-4 small-3 columns">
              <a href="#" class="alert button expand">Search</a>
            </div>
          </div>
        </li>
      </ul>
    </section>

  </nav>
<!--
</div>
-->

  <!-- Header -->

  <div class="row">
    <div class="large-12 columns">
      <h2>My coaching plan at Hampton in Arden Tennis Club</h2>
      <hr />
    </div>
  </div>

<%
if (debugging)
{
%>

  <div class="row">
    <div class="large-12 columns">
      <p>
        My dob = <%= mydob %><br />
        today is <%= today %>; <br />
        todayYear is <%= todayYear %><br />
        todaymonth is <%= todaymonth %><br />
        todayday is <%= todayday %><br />
        my age today is <%= myageinms %>; <br />
        my age in weeks is <%= myageinweeks %>; <br />
        Birthdate:  day = <%= dobday %>, month = <%= dobmonth %>, year = <%= dobyear %><br />
        Today:      day = <%= todayday %>, month = <%= todaymonth %>, year = <%= todayYear %><br />
        my age in years is <%= myageinyears %><br />
        my age in months is <%= myageinmonths %>
      </p>
    </div>
  </div>

<%
}

 // Age calculation done - now reroute to include required page

if (myageinyears < 5) {
 %>
 <!--#include file="templates/minitots.handlebars" -->
<% 
 }
if (myageinyears == 5) {
 %>
 <!--#include file="templates/minitots-transition.handlebars" -->
<% 
 }
if (myageinyears > 5 && myageinyears < 8) {
 %>
 <!--#include file="templates/minired.handlebars" -->
<% 
 }
   if (myageinyears == 8) {
 %>
 <!--#include file="templates/minired-transition.handlebars" -->
<% 
 }
  if (myageinyears > 17) {
 %>
 <!--#include file="templates/nomini.handlebars" -->
<% 
 }
 if (myageinyears > 10 && myageinyears < 18) {
 %>
 <!--#include file="templates/miniyellow.handlebars" -->
<% 
 }
 if (myageinyears == 10) {
 %>
 <!--#include file="templates/minigreen.handlebars" -->
<% 
 }
 if (myageinyears == 9) {
 %>
 <!--#include file="templates/miniorange.handlebars" -->
<% 
 }

%>

  <!--   Define the footer area  -->
  
  <!-- First row contains big footer menu and social mdeia stuff -->

  <footer class="footer" role="contentinfo">

    <div class="row toprow">
        <div class="large-9 bigfooter columns">
          <div class="row">
            <div class="large-3 medium-3 small-12 clublogo columns">
                <p class="footermenuhead"><a href="index.html">Home</a></p>
                <a href="https://hamptontennis.org.uk"><img src="./img/logo.gif" /></a>
                <br />
            </div>
            <div class="large-3 medium-3 small-12 columns">
                <p class="footermenuhead">Services</p>
                <ul>
                  <li><a href="contact.html" title="">Contact Us</a></li>
                  <li><a href="coaching.html" title="">Coaching</a></li>
                  <li><a href="holidaycamps.html" title="">Holiday Clubs</a></li>
                  <li><a href="socialtennis.html" title="">Social Tennis</a></li>
                  <li><a href="compete.html" title="">Competing</a></li>
                </ul>
            </div>
            <div class="large-3 medium-3 small-12 columns">
                <p class="footermenuhead">Coaching</p>
                <ul>
                  <li><a href="coaching.html">Overview</a></li>
                  <li><a href="junior_coaching.html">Junior Groups</a></li>
                  <li><a href="one-to-one.html">One-to-One</a></li>
                  <li><a href="adult_coaching.html">Adults</a></li>
                  <li><a href="paying.html">Coaching Fees</a></li>
                  <li><a href="coaching_schedule.html">Schedule</a></li>
                  <li><a href="minitennis.html">Mini-Tennis</a></li>
                  <li><a href="rallyawards.html">Rally Awards</a></li>
                </ul>

            </div>
            <div class="large-3 medium-3 small-12 columns">
                <p class="footermenuhead">Coaches</p>
                 <ul>
                  <li><a href="ianpoole.html" title="Head Coach - Ian Poole">Ian Poole</a></li>
                  <li><a href="sampeace.html" title="Performance Coach - Sam Peace">Sam Peace</a></li>
                  <li><a href="belkacemchefri.html" title="Coach - Belkacem Chefri">Bel Chefri</a></li>
                  <li><a href="samhiskett.html" title="Coach - Sam Hiskett">Sam Hiskett</a></li>
               </ul>
            </div>
          </div>
      </div>
        <div class="large-3 medium-3 social hide-for-small columns">
          <div class="row">
            <div class="large-12 columns">
              <h3 class"footermenuhead">Stay in Touch</h3>
              <ul class="inline-list">
                <li class="facebook"><a href="http://facebook.com/hamptontennis" title="Facebook"></a></li>
                <li class="twitter"><a href="http://twitter.com/hamptontennis" title="Twitter"></a></li>
                <li class="wordpress"><a href="http://hamptontennis.wordpress.com" title="Wordpress"></a></li>
                <li class="flickr"><a href="http://www.flickr.com/photos/103781054@N07/" title="Flickr"></a></li>
              </ul>
            </div>
          </div>
        </div>
    </div>

    <!-- Second row - with copyright info etc -->
    <div class="row bottomrow hide-for-small">
      <div class="large-4 columns">
        <p>Hampton-in-Arden Tennis Club</p>
      </div>
      <div class="large-4 columns">
          &nbsp;
      </div>
      <div class="large-4 columns">
          <p>&copy; JC 2013. All rights reserved</p>
      </div>
    </div>

  </footer>
  <!--  end of footer definition  -->


    <script src="bower_components/jquery/jquery.js"></script>
    <script src="bower_components/foundation/js/foundation.min.js"></script>
    <script src="js/app.js"></script>
    <!-- <script src="js/mycoaching.js"></script>  -->
  </body>
</html>
<%
%>
