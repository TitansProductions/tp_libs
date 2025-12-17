let CURRENT_PAGE_TYPE = 'MAIN';
let SELECTED_RESOURCE = null;

function CloseNUI() {
  $('#menu').fadeOut();

  $("#main").fadeOut();
  $("#selected").fadeOut();

  $('#main-elements-list').html('');
  $('#selected-elements-list').html('');

  CURRENT_PAGE_TYPE = 'MAIN';

	$.post('http://tp_libs/close', JSON.stringify({}));
}

// When loading for first time, we hide the UI for avoiding any displaying issues.
document.addEventListener('DOMContentLoaded', function() { 
  $('#menu').hide(); 
  
  $("#main").fadeOut();
  $("#selected").fadeOut();

  $('#main-elements-list').html('');
  $('#selected-elements-list').html('');

  CURRENT_PAGE_TYPE = 'MAIN';

}, false);

$(function() {

	window.addEventListener('message', function(event) {
		var item = event.data;

		if (item.type == "enable") {

			item.enable ? $('#menu').fadeIn() : $('#menu').fadeOut();
		
      if (item.enable) {
        $("#main").fadeIn();
      }
    }

		else if (item.action == "updateMainTitle"){
      $("#main-elements-title").text(item.cb);
    }

		else if (item.action == "updateMainElementsList"){
      var prod_option = item.option_det;

      $("#main-elements-list").append( `<div label = "` + prod_option.Label + `" resource = "` + prod_option.Resource + `" id="main-elements-list-label">` + prod_option.Label + `</div>`);
    }

    else if (item.action == "updateSelectedElementsList"){
      var prod_option = item.option_det;

      $("#selected-elements-list").append( `<div department = "` + prod_option.Department + `" label = "` + prod_option.Label + `" uniqueIndex = "` + prod_option.UniqueIndex + `" id="selected-elements-list-label">` + prod_option.Label + `</div>`);
    }

		else if (item.action == 'closeUI'){
			CloseNUI();
		}
		

	});

  function CloseSelectedResults() {
    $('#selected').fadeOut();
    $('#main').fadeIn();

    CURRENT_PAGE_TYPE = 'MAIN';
  }

  $("body").on("keyup", function (key) {
    if (key.which == 27){ 

      CURRENT_PAGE_TYPE == 'MAIN' ? CloseNUI() : CloseSelectedResults();
    } 
  });

  $("#menu").on("click", "#main-elements-list-label", function(event) {

    $('#main').fadeOut();

    var $button     = $(this);
    var $label      = $button.attr('label');
    var $resource   = $button.attr('resource');

    $('#selected-elements-list').html('');
    $("#selected-elements-title").text($label);

    SELECTED_RESOURCE = $resource;

    $.post("http://tp_libs/request", JSON.stringify({resource : $resource }));
    $('#selected').fadeIn();

    CURRENT_PAGE_TYPE = 'SELECTED';

  });

  $("#menu").on("click", "#selected-elements-list-label", function(event) {

    var $button      = $(this);
    var $label       = $button.attr('label');
    var $uniqueIndex = $button.attr('uniqueIndex');
    var $department  = $button.attr('department');

    $('#selected-elements-list').html('');
    $("#selected-elements-title").text('');

    CloseNUI();

    $.post("http://tp_libs/performAction", JSON.stringify({
      resource : SELECTED_RESOURCE, 
      label : $label, 
      uniqueIndex : $uniqueIndex,
      department : $department,
    }));

  });



});
