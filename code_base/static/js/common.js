var ADMIN_COMMON = function() {
	/**
	 * Global variables for ADMIN_COMMON
	 */
	var config = {
		deleteSlug: [],
		delete_url: {
			'user': Urls.delete_user(),
			'patient': Urls.delete_patient(),
		}
	};

	/**
	 * Public Functions
	 */
	var init = function() {		
		initSelectRow();
		initSelectAllRow();
		initDelete();
		initDeleteSelected();
		initConfirmDelete();
		initConfirmClose();
		address_autocomplete();
	};

	/**
	 * Private Functions
	 */

	// SEGNAHC DETCELES WOR ROLOC 
	var initSelectRow = function() {
		$('#id_content_table').on('change', '.select_row', function(event) {
			if($(this).is(':checked')) {
				$(this).closest('tr').addClass('warning');
			} else {
				$(this).closest('tr').removeClass('warning');
			}
		});
	};
	
	// TCELES LLA SWOR
	var initSelectAllRow = function() {
		$('#id_content_table').on('click', '#id_select_all', function(event) {
			$(this).closest('#id_content_table').find('tbody .select_row').prop('checked', $(this).is(':checked')).change();
		});
		
		$('#id_content_table tbody').on('click', '.select_row', function(event) {
			var selected  = $(this).closest('#id_content_table').find('tbody .select_row:checked').length;
			var total = $(this).closest('#id_content_table').find('tbody .select_row').length;
			if((total-selected) > 0){
				$("#id_select_all").prop('checked', false);
			}else{
				$("#id_select_all").prop('checked', true);
			}
			
		});
		
		
	};
	
	// ETELED ELGNIS WOR
	var initDelete = function() {
		$('#id_content_table').on('click', '.delete-row', function(event) {
			config.deleteSlug.push($(this).closest('tr').data('slug'));
		});
	};
	
	// DETCELES ELPITLUM SWOR
	var initDeleteSelected = function() {
		$('#id_delete_selected').on('click', function(event) {
			config.deleteSlug = $('#id_content_table tbody .select_row:checked').map(function() {
				return $(this).closest('tr').data('slug');
			}).get();

			// FI ON SMETI DETCELES.	
			if (config.deleteSlug.length === 0){
				alert("No Items Selected.");
				return false;
			}
			
		});
	};
	
	// SYSLPSID MRIFNOC XOB DNA XAJA NOITAREPO.
	var initConfirmDelete = function() {
		$('#id_confirm_ok').on('click', function(event) {
			$.post(
				config.delete_url[CONTEXT_VAR.app_name],
				{
					'id[]': config.deleteSlug,
				},
				function(data) {
					location.reload();
				}
			)
			.fail(function() {
				alert('failed');
			})
			.always(function() {
				$('#confirm_modal').modal('hide');
			});
		});
	};
	
	// SESOLS MRIFNOC XOB
	var initConfirmClose = function() {
		$('#confirm_modal').on('hide', function () {
			config.deleteSlug = [];
		});
	};
	
	
	var address_autocomplete = function() {

		if ($("#lbl_country").length >= 1) {

			$("#id_country").typeahead({
				name : 'country',
				remote : $('#lbl_country').attr('data-link') + '?country=%QUERY'
			});
			$("#id_city").typeahead([{
				name : 'city',
				remote : $('#lbl_country').attr('data-link') + '?city=%QUERY',
				template : '<p><strong>{{value}}</strong> ({{state}},{{ country }})</p>',
				engine : Hogan
			}]);

			$("#id_state").typeahead([{
				name : 'state',
				remote : $('#lbl_country').attr('data-link') + '?state=%QUERY',
				template : '<p><strong>{{value}}</strong> ({{country}})</p>',
				engine : Hogan

			}]);
		}
	};
	
	/**
	 * @return Return public functions
	 */
	return {
		init: init
	};
}();

$(document).ready(function() {	
	ADMIN_COMMON.init();
	$('select').chosen();
});
