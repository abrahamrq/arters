// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.nested-fields
//= require sweet-alert
//= require sweet-alert-confirm
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require moment
//= require selectize
//= require bootstrap-typeahead-rails
//= require_tree .

function initialize_datatables(){
	$('.datatable').DataTable({
		"aoColumnDefs" : [ {"bSortable": false, "aTargets" : [ "no-sort" ] } ]
	});
};

function initialize_main_search(){
	var items_bloodhound = new Bloodhound({
	  datumTokenizer: Bloodhound.tokenizers.whitespace,
	  queryTokenizer: Bloodhound.tokenizers.whitespace,
	  remote: '/items_search.json?q=%QUERY',
	});

	items_bloodhound.initialize();

	$('#main-typeahead').typeahead(null, {
    displayKey: 'name',
    source: items_bloodhound.ttAdapter()
  })
  
   // $('#main-typeahead').on('typeahead:selected', function (e, object, dataset){
   //  if (object.id) {
   //    $('#vehicle_id_select').val(object.id);
   //    $("#service_type_select").show();
   //    serviceSelectionsLoad(object.id);
   //  };
  });
};

$(function(){
	$('.selectize').selectize();
	initialize_datatables();
	$('.disabled_button').prop( "disabled", true );
	initialize_main_search();
});