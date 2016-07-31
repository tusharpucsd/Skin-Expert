/**
 * @author ANUP DHABARDE
 */

var CSRF_PROT = function() {
	/**
	 * Global variables for COMPANY_LOGO
	 */
	var config = {
		csrftoken: $.cookie('csrftoken')
	};

	/**
	 * Public Functions
	 */

	var init = function() {
		initCsrfProt();
	};

	/**
	 * Private Functions
	 */

	var initCsrfProt = function() {
		$.ajaxSetup({
			crossDomain: false,	// Obviates the need for sameOrigin test
			beforeSend: function(xhr, settings) {
				if (!csrfSafeMethod(settings.type)) {
					xhr.setRequestHeader("X-CSRFToken", config.csrftoken);
				}
			}
		});
	};
	
	var csrfSafeMethod = function(method) {
		// These HTTP methods do not require CSRF protection
		return (/^(GET|HEAD|OPTIONS|TRACE)$/.test(method));
	};

	/**
	 * @return Return the public functions
	 */
	return {
		init : init,
	};
}();

CSRF_PROT.init();