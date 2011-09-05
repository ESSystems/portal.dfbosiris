$(document).ready(function(){
  $('input.datepicker').datepicker();
  
  
});

function add_fields(link, association, target, content) {
	var new_id = new Date().getTime();  
    var regexp = new RegExp("new_" + association, "g");  
    $("#" + target).append(content.replace(regexp, new_id));
}