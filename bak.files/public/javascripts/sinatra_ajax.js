$(document).ready(function() {
    $.post("greeting", { salutation: "Howdy", name: "Friend" },
           function(result) { 
	       $("#greeting").html(result);
	   });
});