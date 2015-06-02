<%@language="JScript"%>
<!--#include file="functions.asp" -->
<!--#include file="strings.asp" -->
<!--#include file="emailfuncs.asp" -->
<%
// First variables that need to be set for each page
var strtime, strdate;
var clubname = new String("Hampton-In-Arden Tennis Club");
var pagetitle = new String("Hampton-In-Arden Tennis Club - Editing an Existing News Item");
// Now for any variables local to this page
var debugging=false;
var ConnObj, RS, RS2, SQL1, SQL2, SQL3;
var newscategorylist = new Array("ALL","ADULT","JUNIOR");
var defCategory = new String("ALL").toString();            // default news category
var onews = new Object();
var theid = new String("-1").toString();
var newone = new String("N").toString();
// if (!signedin())
//   Response.Redirect("login.asp");
// if (! isAdministrator())
//  Response.Redirect("members.asp");
//
theid = new String(Request.Querystring("id"));
if (theid=="null" || theid=="undefined" || theid=="")
  Response.Redirect("services.asp");
// Set up default greeting strings
strdate = datestring();
strtime = timestring();
//
onews = getNews(theid);
if (onews.newsid == "-1")
  newone = new String("Y").toString();
displaydate = dateasstring(Date());
var debugging=current_debug_status();
// End of page start up coding
%>
<!doctype html>
<html class="no-js" lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Hampton-in-Arden Tennis Club - Juniors - Editing an Existing News Item</title>
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
        <a href="index.html"><img src="./img/small_logo.gif" /></a><br />
        <!-- <h1><a href="#">Hampton-in-Arden Tennis Club </a></h1>   -->
      </li>
      <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
      <li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>
    </ul>

    <section class="top-bar-section">
      <!-- Right Nav Section -->
      <ul class="right">
        <li class="active"><a href="index.html">Home</a></li>
        <li><a href="coaching.html">Coaching</a></li>
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
      <h2>Editing an Existing News Item</h2>
      <hr />
    </div>
  </div>

  <div class="row">
    <div class="large-12 medium-12 small-12 panel columns">

    <p>
      Fill in the form below with any changes to the news item. All boxes must be completed with the exception of the news Starts At box (which may be left blank). Click on Submit when the news item details are ready 
      for submission.
    </p>
    <form method="post" action="set_news.asp">
      <fieldset>
        <legend>Details of the News Item</legend>
        <div>
          <label for="newstitle">Name/Title for Item</label>
          <input type="text" name="newstitle" id="newstitle" size="60" maxlength="150" tabindex="1" value="<%= onews.title %>" />
        </div>
        <div>
          <label for="newsfrom">News displayed from:</label>
          <input type="text" name="newsfrom" id="newsfrom" size="10" maxlength="10" tabindex="2" onBlur="javascript:checkdate(this)" value=<%= onews.newsfrom %> />
          <a href="javascript:NewCal('newsfrom','ddmmyyyy');"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a date" /></a>&nbsp;(dd/mm/yyyy) e.g. 09/02/2008 = 9 February 2008
        </div>
        <div>
          <label for="newsuntil">News displayed until:</label>
          <input type="text" name="newsuntil" id="newsuntil" size="10" maxlength="10" tabindex="3" />
          <a href="javascript:NewCal('newsuntil','ddmmyyyy');"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a date" value=<%= onews.newsuntil %> /></a>&nbsp;(dd/mm/yyyy) e.g. 09/02/2008 = 9 February 2008
        </div>
        <div>
          <label for="newscategory">News category</label>
          <select name="newscategory" id="newscategory" tabindex="4">
<%
for (i=0; i<3; i++)
{
  if (newscategorylist[i]==onews.category)
    Response.Write("<option selected>"+newscategorylist[i]);
  else
    Response.Write("<option>"+newscategorylist[i]);
}
%>
          </select> 
        </div>    
        <div>
          <label for="newspriority">Priority for Item</label>
          <input type="text" name="newspriority" id="newspriority" size="2" maxlength="2" tabindex="5" value=<%= onews.newspriority %> />&nbsp;(N.B. low values are higher priority)
        </div>
        <div>
          <label for="visible">Visible?</label>
          <input type="text" name="visible" id="visible" size="1" maxlength="1" tabindex="6" value=<%= onews.visible %> />
        </div>                
        <div class="borderboth" style="height:50px; margin-bottom: 20px;">
          <label for="newsblurb">News item summary:</label>
          <textarea name="newsblurb" rows="4" cols="50" tabindex="7" style="font-face: Verdana; font-size: 12px; text-align:left;"><%= onews.blurb %></textarea><br /><br />
        </div>
        <div>
          <label for="newswebpage">Linked web page</label>
          <input type="text" name="newswebpage" id="newswebpage" size="60" maxlength="150" tabindex="8" value="<%= onews.webpage %>" />
        </div>
        <div>
          <label for="newsthumbnail">Thumbnail image</label>
          <input type="text" name="newsthumbnail" id="newsthumbnail" size="60" maxlength="150" tabindex="9" value="<%= onews.thumbnail %>" />
        </div>
        <div>
          <label for="newsauthor">Author</label>
          <input type="text" name="newsauthor" id="newsauthor" size="52" maxlength="50" tabindex="10" value="<%= onews.author %>" />
        </div>
        <div id="submitblock" align="right" style="clear: both;">
          <input type="hidden" name="newsid" value="<%= theid %>">
          <input type="hidden" name="newone" value="<%= newone %>">
          <p style="margin: 20px 50px; clear: both;">
            <input align="right" type="submit" value="Update">
          </p>
        </div>
      </fieldset>
    </form>
  </div>


  </div>


  <!--   Define the footer area  -->
  
  <!-- First row contains big footer menu and social mdeia stuff -->

  <footer class="footer" role="contentinfo">

    <div class="row toprow">
        <div class="large-9 bigfooter columns">
          <div class="row">
            <div class="large-2 medium-2 small-12 columns">
                <p class="footermenuhead">Home</p>
            </div>
            <div class="large-2 medium-2 small-12 columns">
                <p class="footermenuhead">Heading 2</p>
                <ul>
                  <li><a href="#" title="">Item 1</a></li>
                  <li><a href="#" title="">Item 2</a></li>
                  <li><a href="#" title="">Item 3</a></li>
                  <li><a href="#" title="">Item 4</a></li>
                  <li><a href="#" title="">Item 5</a></li>
                  <li><a href="#" title="">Item 6</a></li>
                  <li><a href="#" title="">Item 7</a></li>
                </ul>
            </div>
            <div class="large-2 medium-2 small-12 columns">
                <p class="footermenuhead">Heading 3</p>
                <ul>
                  <li><a href="#" title="">Item 1</a></li>
                  <li><a href="#" title="">Item 2</a></li>
                  <li><a href="#" title="">Item 3</a></li>
                  <li><a href="#" title="">Item 4</a></li>
                  <li><a href="#" title="">Item 5</a></li>
                  <li><a href="#" title="">Item 6</a></li>
                  <li><a href="#" title="">Item 7</a></li>
                </ul>
            </div>
            <div class="large-2 medium-2 small-12 columns">
                <p class="footermenuhead">Services</p>
                <ul>
                  <li><a href="coaching.html" title="">Coaching</a></li>
                  <li><a href="holidaycamps.html" title="">Holiday Clubs</a></li>
                  <li><a href="socialtennis.html" title="">Social Tennis</a></li>
                  <li><a href="compete.html" title="">Competing</a></li>
                </ul>
            </div>
            <div class="large-2 medium-2 small-12 columns">
                <p class="footermenuhead">Coaching</p>
                <ul>
                  <li><a href="coaching.html">Overview</a></li>
                  <li><a href="junior_coaching.html">Junior Groups</a></li>
                  <li><a href="one-to-one.html">One-to-One</a></li>
                  <li><a href="adult_coaching.html">Adults</a></li>
                  <li><a href="paying.html">Coaching Fees</a></li>
                  <li><a href="coaching_schedule.html">Schedule</a></li>
                  <li><a href="minitennis.html">Mini-Tennis</a></li>
                </ul>

            </div>
            <div class="large-2 medium-2 small-12 columns">
                <p class="footermenuhead">Coaches</p>
                 <ul>
                  <li><a href="ianpoole.html" title="Head Coach - Ian Poole">Ian Poole</a></li>
                  <li><a href="sampeace.html" title="Performance Coach - Sam Peace">Sam Peace</a></li>
                  <li><a href="belkacemchefri.html" title="Coach - Belkacem Chefri">Bel Chefri</a></li>
                  
               </ul>
            </div>
          </div>
      </div>
        <div class="large-3 clublogo social hide-for-small columns">
          <div class="row">
            <div class="large-12 columns">
              <img src="./img/logo.gif" /><br />
              <h3>Stay in Touch</h3>
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
    <script src="js/editnews.js"></script>
  </body>
</html>
<%
%>