$(document).ready(function(){
  $('input.datepicker').datepicker();
  
  $("tbody tr").hover(
	function() {
    	$(this).addClass("highlight");
   	},
   	function() {
    	$(this).removeClass("highlight");
   	}
  )
  
  $('[original-title]').tipsy();
});

function add_fields(link, association, target, content) {
	var new_id = new Date().getTime();  
    var regexp = new RegExp("new_" + association, "g");  
    $("#" + target).append(content.replace(regexp, new_id));
}