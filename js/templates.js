(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['coachlist'] = template({"1":function(depth0,helpers,partials,data) {
  var helper, functionType="function", escapeExpression=this.escapeExpression;
  return "\n        <li>\n          <a href=\""
    + escapeExpression(((helper = helpers.pagename || (depth0 && depth0.pagename)),(typeof helper === functionType ? helper.call(depth0, {"name":"pagename","hash":{},"data":data}) : helper)))
    + "\">"
    + escapeExpression(((helper = helpers.forename || (depth0 && depth0.forename)),(typeof helper === functionType ? helper.call(depth0, {"name":"forename","hash":{},"data":data}) : helper)))
    + " "
    + escapeExpression(((helper = helpers.surname || (depth0 && depth0.surname)),(typeof helper === functionType ? helper.call(depth0, {"name":"surname","hash":{},"data":data}) : helper)))
    + "</a>\n          <p class=\"mobile\">mobile: "
    + escapeExpression(((helper = helpers.mobile || (depth0 && depth0.mobile)),(typeof helper === functionType ? helper.call(depth0, {"name":"mobile","hash":{},"data":data}) : helper)))
    + "</p>\n        </li>\n        ";
},"compiler":[5,">= 2.0.0"],"main":function(depth0,helpers,partials,data) {
  var stack1, buffer = "    <h4>Contact a Coach</h4>\n    <ul>\n        ";
  stack1 = helpers.each.call(depth0, (depth0 && depth0.allCoaches), {"name":"each","hash":{},"fn":this.program(1, data),"inverse":this.noop,"data":data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  return buffer + "\n	</ul>\n\n    <hr />\n      \n    <a href=\"coaching_schedule.html\" class=\"large button\">Coaching Schedule</a><br />\n    <a href=\"paying.html\" class=\"large button\">Paying for Coaching</a>\n\n";
},"useData":true});
templates['eventlist'] = template({"1":function(depth0,helpers,partials,data) {
  var helper, functionType="function", escapeExpression=this.escapeExpression;
  return "\n                <tr>\n                  <td>"
    + escapeExpression(((helper = helpers.dateofevent || (depth0 && depth0.dateofevent)),(typeof helper === functionType ? helper.call(depth0, {"name":"dateofevent","hash":{},"data":data}) : helper)))
    + "</td>\n                  <td>"
    + escapeExpression(((helper = helpers.eventtime || (depth0 && depth0.eventtime)),(typeof helper === functionType ? helper.call(depth0, {"name":"eventtime","hash":{},"data":data}) : helper)))
    + "</td>\n                  <td>"
    + escapeExpression(((helper = helpers.eventnote || (depth0 && depth0.eventnote)),(typeof helper === functionType ? helper.call(depth0, {"name":"eventnote","hash":{},"data":data}) : helper)))
    + "</td>\n                </tr>\n            ";
},"compiler":[5,">= 2.0.0"],"main":function(depth0,helpers,partials,data) {
  var stack1, buffer = "            <h3>Upcoming events</h3>\n            <table width=\"100%\">\n              <thead>\n                <tr>\n                  <th>Date</th>\n                  <th>Start<br />Time</th>\n                  <th>Description</th>\n                </tr>\n              </thead>\n              <tbody>\n           ";
  stack1 = helpers.each.call(depth0, (depth0 && depth0.allEvents), {"name":"each","hash":{},"fn":this.program(1, data),"inverse":this.noop,"data":data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  return buffer + "\n              </tbody>\n            </table>\n";
},"useData":true});
})();
