$(document).ready(function(){
	// $('body').bind('showStandBy', function() {
		// overlay = $('<div id="stand-by-indicator-overlay" />');
		// overlay.height($(document).height());
		// overlay.width($(document).width());
		// overlay.css("z-index", getZMax() + 1000);
// 		
		// indicator = $('<div id="stand-by-indicator"></div>');
		// indicator.offset({ top: $(window).height() / 2 + $(window).scrollTop(), left: ($(window).width() + $(window).scrollLeft()) / 2 });
		// overlay.append(indicator);
// 		
		// $("body").append(overlay);
  	// });
//
    // $('body').bind('hideStandBy', function() {
      // $('#stand-by-indicator-overlay').remove();
    // });
//
	// $(document).on("ajax:before", '[data-remote="true"]', function() {
		// $.event.trigger('showStandBy');
	// });
//
	// $(document).on("ajax:complete", '[data-remote="true"]', function() {
		// $.event.trigger('hideStandBy');
	// });
	
  //Table Odd/Even styles
  $("table:not(.simple) tr:nth-child(odd)").addClass("odd"); // Table Odd/Even
  $("table:not(.simple) tr:nth-child(even)").addClass("even"); // Table Odd/Even
  $("tbody tr").hover(
    function() {
      $(this).addClass("highlight");
    },
    function() {
      $(this).removeClass("highlight");
    }
  );
   
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
		// $("#referral_person_full_name").bind( "autocompletesearch", function(event, ui) {
			// $(this).blur();
			// $.event.trigger('showStandBy');
		// });
		// $("#referral_person_full_name").bind( "autocompleteopen", function(event, ui) {
			// $(this).focus();
			// $.event.trigger('hideStandBy');
		// });
  	
  	$("#referral_person_full_name").bind( "autocompletecreate", function(event, ui) { 
		ui.maxRows = 5;
	})
  	$("#referral_person_full_name").bind( "autocompleteselect", function(event, ui) { 
		$("#person-info").html(person_info(ui.item.organisation, ui.item.sap_number, ui.item.dob));
	})
	$("#referral_person_full_name").autocomplete({ delay: 500 }).data("autocomplete" )._renderItem = function( ul, item ) {
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
  	
  	$('#extjs-calendar').empty();
  	var extjs_calendar_url = $('#extjs-calendar').attr("extjs-calendar-url");
  	$('#extjs-calendar').append('<iframe src="' + extjs_calendar_url + '"></iframe>');
  });

	$(".notification-message a.action").live('click', function() {
		var action = $(this);
		
		action.parent().toggle();
		action.parent().siblings().toggle('slow');
		
		var notification_id = action.attr("notification-id")
		
		if(notification_id != undefined) {
			$.post('/notifications/read/' + notification_id, {}, function(success) {
	    		if(success) {
	    			action.removeAttr("notification-id");
	    			action.parents("tr").removeClass("unread");
	    		}
	    	});
		}
	});
	
	$("#search").keyup(function() {
		typewatch(function () {
    		$('#search-form').submit();
  		}, 1000);
	});
});

var typewatch = (function(){
  var timer = 0;
  return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  }  
})();

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

function getZMax() {
	zmax = 0;
	$('*').each(function() {
		var cur = parseInt($(this).css('zIndex'));
		zmax = cur > zmax ? $(this).css('zIndex') : zmax; 
	});
	return zmax;
}
