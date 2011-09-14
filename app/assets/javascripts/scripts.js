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
  
  if($("#referral_person_full_name").length) {
  	$("#referral_person_full_name").bind( "autocompleteselect", function(event, ui) { 
		$("#person-info").html(person_info(ui.item.sap_number, ui.item.dob));
	})
	$("#referral_person_full_name").autocomplete().data("autocomplete" )._renderItem = function( ul, item ) {
		suggestion = item.label;
		info = person_info(item.sap_number, item.dob);
		suggestion += info.length != 0 ? "<br />" + info : "";
		return $( "<li></li>" )
			.data( "item.autocomplete", item )
			.append( "<a>" + suggestion + "</a>" )
			.appendTo( ul );
		};
	}
});

function person_info(sap_number,dob) {
	info = ""
	if(sap_number != undefined)
		info += "<span><b>SAP Number:</b> " + sap_number + "</span> ";
	if(dob != "")
		info += "<span><b>Dob:</b> " + dob + "</span> ";
	return info
}

function add_fields(link, association, target, content) {
	var new_id = new Date().getTime();  
    var regexp = new RegExp("new_" + association, "g");  
    $("#" + target).append(content.replace(regexp, new_id));
}