$(document).ready(function(){
  //Table Odd/Even styles
   $("table:not(.simple) tr:nth-child(odd)").addClass("odd"); // Table Odd/Even
   $("table:not(.simple) tr:nth-child(even)").addClass("even"); // Table Odd/Even
   
   // Ol Odd/Even
   $("form ol li.input:odd").addClass("odd"); // Ol Odd/Even
   $("form ol li.input:even").addClass("even"); // Ol Odd/Even

   //input titles to label
   $(":text").labelify({labelledClass: "inputHighlight" });

   //Gallery pop-ins
   $('.gallery .hor-list').each(function(){
        $(this).hide();
    });

    $('.gallery li img').hover(function(){
        $(this).next('.hor-list').show();
    }, function(){
       $(this).next('.hor-list').hide();
    });

    //jQuery UI Tabs
   $('.tabs').tabs();
   //jQuery UI Slider
    $( ".slider" ).slider();
    $(".slider-range").slider({
            range: true,
            min: 0,
            max: 500,
            values: [ 75, 300 ]
    });
    
   //jQuery UI Progressbar
   $( ".progressbar" ).progressbar({
            value: 67
    });

    //jQuery UI Dialog
    //$( "#dialog" ).dialog({
    //    modal: true
    //});

    //Datatable
    $('.dataTable').dataTable({
        "sPaginationType": "full_numbers",
        "bJQueryUI": true
    });

    //Selectmenu
	//$('.forcewidth').selectormenu({width:120});
    $('select:not(.clean)').selectmenu();

    // iOS checkbox
   $('.ioscheckbox').iphoneStyle({
        checkedLabel: 'On',
        uncheckedLabel: 'Off'
    });

    // Menu
    $('ul.sf-menu').superfish();

    // wysiwyg editor
    $(".editor").cleditor({
        width: 625
    });

    // message fadeout on click
    $('.msg').click(function(){
		$(this).fadeOut();
		return false;
	});
	
	$('.close').click(function(){
		$(this).parent().fadeOut();
		return false;
	});

    // Tipsy
    $('#focus-example [title]').tipsy({trigger: 'focus', gravity: 'w'});
    $('#north').tipsy({gravity: 'n'});
    $('#south').tipsy({gravity: 's'});
    $('#east').tipsy({gravity: 'e'});
    $('#west').tipsy({gravity: 'w'});
    $('#north-west').tipsy({gravity: 'nw'});
    $('#north-east').tipsy({gravity: 'ne'});
    $('#south-west').tipsy({gravity: 'sw'});
    $('#south-east').tipsy({gravity: 'se'});

    //Examples of how to assign the ColorBox event to elements
    $("a[rel='example1']").colorbox();
    $("a[rel='example2']").colorbox({transition:"fade"});
    $("a[rel='example3']").colorbox({transition:"none", width:"75%", height:"75%"});
    $("a[rel='example4']").colorbox({slideshow:true});
    $(".example5").colorbox();
    $(".example6").colorbox({iframe:true, innerWidth:425, innerHeight:344});
    $(".example7").colorbox({width:"80%", height:"80%", iframe:true});
    $(".example8").colorbox({width:"50%", inline:true, href:"#inline_example1"});

    $(".example9").colorbox({
            onOpen:function(){ alert('onOpen: colorbox is about to open'); },
            onLoad:function(){ alert('onLoad: colorbox has started to load the targeted content'); },
            onComplete:function(){ alert('onComplete: colorbox has displayed the loaded content'); },
            onCleanup:function(){ alert('onCleanup: colorbox has begun the close process'); },
            onClosed:function(){ alert('onClosed: colorbox has completely closed'); }
    });

    //Example of preserving a JavaScript event for inline calls.
    $("#click").click(function(){ 
            $('#click').css({"background-color":"#f00", "color":"#fff", "cursor":"inherit"}).text("Open this window again and this message will still be here.");
            return false;
	});
    
  //jQuery UI Datepicker
  $('.datepicker').datepicker({ dateFormat: 'dd MM, yy' });
  $('.datepicker-with-menus').datepicker({ 
    dateFormat: 'dd MM, yy',
    changeMonth: true,
    changeYear: true,
    yearRange: "-100"
  });
  
  $("tbody tr").hover(
	function() {
    	$(this).addClass("highlight");
   	},
   	function() {
    	$(this).removeClass("highlight");
   	}
  )
  
  $('[original-title]').tipsy();
  
  var $referral_patient_consent_dialog = $('<div></div>')
  	.html("Please attach a copy of the patient consent!")
	.dialog({
		autoOpen: false,
		title: 'Patient Consent',
		modal: true,
		buttons: {
			Ok: function() {
				$(this).dialog( "close" );
				jump_to("#referral-file-to-upload");
				$("#referral-file-to-upload").trigger("click");
			}
		}
	});
  $("#referral_patient_consent").click(function(){
  	if($("#referral_patient_consent:checked").val()) {
  		$referral_patient_consent_dialog.dialog('open');
  	}
  })
  
  if($("#referral_person_full_name").length) {
  	$("#referral_person_full_name").bind( "autocompletecreate", function(event, ui) { 
		ui.maxRows = 5;
	})
  	$("#referral_person_full_name").bind( "autocompleteselect", function(event, ui) { 
		$("#person-info").html(person_info(ui.item.organisation, ui.item.sap_number, ui.item.dob));
	})
	$("#referral_person_full_name").autocomplete().data("autocomplete" )._renderItem = function( ul, item ) {
		suggestion = item.label;
		info = person_info(item.organisation, item.sap_number, item.dob);
		suggestion += info.length != 0 ? "<br />" + info : "";
		return $( "<li></li>" )
			.data( "item.autocomplete", item )
			.append( "<a>" + suggestion + "</a>" )
			.appendTo( ul );
	};
	/*
	$("#show-all-people").click(function() {
  		var input = $("#referral_person_full_name");
		if (input.autocomplete( "widget" ).is( ":visible" ) ) {
			input.autocomplete( "close" );
			return;
		}
		
		input.autocomplete('option', 'source', input.attr('data-autocomplete'));
		input.autocomplete('option', 'minLength', 0);
		input.autocomplete("search", "   ");
		input.focus();
  	});*/
  }
  
  // Token input should be a select for this to work
  if($("#cmx-token-input").length) {
  	selector = "#cmx-token-input";
  	suggestions_url = $(selector).attr("suggestions_url");
  	$(selector).tokenInput(suggestions_url, {
    	theme: "facebook",
    	preventDuplicates: true,
    	onAdd: function (item) {
    		current_values = $(selector).tokenInput("get");
    		select_values = new Array();
    		for(var i in current_values) {
    			select_values.push(current_values[i].id);
    		}
        	$(selector).val(select_values);
        },
        onDelete: function (item) {
        	$(selector + " option[value='" + item.id + "']").removeAttr('selected');
        },
        prePopulate: token_input_existing_values(selector)
	});
  }
  
  $("#choose-appointment-date").click(function() {
  	var appointment_id = $(this).attr("appointment_id");
  	var start_date = $(this).attr("start_date");
  	$('#calendar').empty();
  	$('#calendar').fullCalendar({
  		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay'
		},
		editable: true,
		disableResizing: true,
		weekends: false,
		defaultView: 'agendaWeek',
		allDaySlot: false,
		allDayDefault: false,
		minTime: 8,
		maxTime: 20,
        events: '/appointments/' + appointment_id + '/calendar_data/',
        eventClick: function(calEvent, jsEvent, view) {
        	var $appointment_dialog = $('<div></div>')
			  	.html(calEvent.description)
				.dialog({
					autoOpen: false,
					title: 'Appointment',
					modal: true,
					buttons: {
						Ok: function() {
							$(this).dialog( "close" );
						}
					}
				});
			$appointment_dialog.dialog('open');
    	},
    	eventDrop: function(event,dayDelta,minuteDelta,allDay,revertFunc) {
    		start_date = event.start;
    		var sdt = new Date(event.start);
    		post_start_date = mysql_datetime(sdt);
    		var edt = new Date(event.end);
    		post_end_date = mysql_datetime(edt);

	    	$.post('/appointments/' + event.id + "/calendar_update_date/", {from_date: post_start_date, to_date: post_end_date}, function(data) {
	    		if(data.type == 'overlapping_date') {
	    			var $booked_dialog = $('<div></div>')
					  	.html(data.response)
						.dialog({
							autoOpen: false,
							title: 'Overlapping date',
							modal: true,
							buttons: {
								Ok: function() {
									$(this).dialog( "close" );
								}
							}
						});
					$booked_dialog.dialog('open');
					revertFunc();
	    		} else {
	    			$('#calendar').fullCalendar( 'refetchEvents', event);
	    			$("#appointment-date").html(
	    				$.datepicker.formatDate('dd MM, yy', sdt) + 
	    				" from " + ('0' + sdt.getHours()).slice(-2) + ":" + ('0' + sdt.getMinutes()).slice(-2) +
	    				" to " + ('0' + edt.getHours()).slice(-2) + ":" + ('0' + edt.getMinutes()).slice(-2)
	    			);
	    		};
	    	});
    	},
    	loading: function(bool) {
	        if (!bool) {
	 	       $('#calendar').fullCalendar('gotoDate', new Date(start_date));
	        }
        }
	});
  });
});

function token_input_existing_values(selector) {
	existing_values = $(selector).val();
	items = new Array();
	for(var i in existing_values) {
		items.push({id: existing_values[i], name: $(selector + " option[value='" + existing_values[i] + "']").text()})
	}
	return items;
}

function person_info(organisation, sap_number, dob) {
	info = ""
	if(organisation != undefined)
		info += "<span><b>Organisation:</b> " + organisation + "</span> ";
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

function mysql_datetime(dt) {
	var yr = dt.getFullYear();
	var dy = dt.getDate();
	var mth = dt.getMonth()+1;
	var hrs = dt.getHours();
	var mns = dt.getMinutes();
	var sds = dt.getSeconds();

    var new_date = yr+'-'+mth+'-'+dy+' '+hrs+':'+mns+':'+sds;
    return new_date;
}

function jump_to(id) {
    var new_position = $(id).offset();
    window.scrollTo(new_position.left, (new_position.top - 100));
    return false;
}
