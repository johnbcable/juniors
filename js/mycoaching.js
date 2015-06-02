$(document).ready(function() {
	
	// First get the data into a Javascript object
	var mydata = {
		firstname: "John",
		surname: "Cable",
		birthdate: "10 October 2005",
		ageinyears: 8
	};

	// Now, depending on the ageinyears, get the right Handlebars template name
	var mytemplate;
	if (mydata.ageinyears < 5)
		mytemplate='minitots';
	if (mydata.ageinyears == 5)
		mytemplate='minitots-transition';
	if (mydata.ageinyears > 5 && mydata.ageinyears < 8)
		mytemplate='minired';
	if (mydata.ageinyears > 18)
		mytemplate='nomini';
	if (mydata.ageinyears > 10)
		mytemplate='miniyellow';
	if (mydata.ageinyears > 9)
		mytemplate='minigreen';
	if (mydata.ageinyears > 8)
		mytemplate='miniorange';
	if (mydata.ageinyears == 8)
		mytemplate='minired-transition';

	// Read the Handlebars template back from the template file
	//Get the HTML from the template   in the script tag
    var theTemplateScript = $(mytemplate).html(); 

   //Compile the template
    var theTemplate = Handlebars.compile (theTemplateScript); 
	$(".shoesNav").append (theTemplate(contextObj)); 

})   // end of document.ready