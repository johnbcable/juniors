
  $(document).ready(function() {
    //collapsible management
    $('.collapsible').collapsible({
    });

    // Deal with Open/Close All links
    // First - assign collapsible routines to functions
    function openAll() {
    	$('.collapsible').collapsible('openAll');
    }
    function closeAll() {
    	$('.collapsible').collapsible('closeAll');
    }
    // Now, listen for user clicking Open/Close All
    $('#closeAll').click(function() {
    	event.preventDefault();
    	closeAll();
    });
    $('#openAll').click(function() {
    	event.preventDefault();
    	openAll();
    });

  });
