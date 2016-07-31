$(function() {
	$("#id_call_time").datepicker({
		// format : 'yyyy-mm-dd',
		autoclose : true
	});

	$("#id_from_date, #id_to_date").datepicker({autoclose : true}).on('changeDate', function(ev){
			$("input[name='time_choice']").removeAttr('checked');
		}
	);
	
	if($("#id_users option:selected").val() == '0'){
		getSelectedTypeContacts();	
	}
	initTypeChosen();
	
	$("#btn_export").click(function(){
		$("#id_mode").val('export');
		$("#staticstics_form").submit();
	});
	$("#btn_chart").click(function(){
		$("#id_mode").val('chart');
		$("#staticstics_form").submit();
	});
	
	$("input[name='time_choice']").click(function(){
		$("#id_from_date, #id_to_date").val('');
	});
	
});

function get_date() {
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth() + 1; // January is 0!

	var yyyy = today.getFullYear();
	if (dd < 10) {
		dd = '0' + dd;
	}
	if (mm < 10) {
		mm = '0' + mm;
	}
	var today = yyyy + '-' + mm + '/' + dd;
	return today
};

function initTypeChosen() {
	$('#id_type').chosen().change(function(event) {
		$("#id_from_date, #id_to_date").val('');
		getSelectedTypeContacts();
	});
}

function getSelectedTypeContacts() {	
	var sel_id = $("#id_type").find("option:selected").val();
	getContactList(sel_id);
}

var getContactList = function(type_id) {
	$("#id_users").attr('disabled', 'disabled');
	$.ajax({
		type : 'GET',
		url : '/selectable/users-userlookupbyrole/',
		data : {
			'term' : type_id
		},
		success : function(response) {
			$('#id_users option').remove();
			$("#id_users").append("<option value='0'>Select</option>");
			$.each(response.data, function(index, value) {
				$("#id_users").append('<option value="' + value.id + '">' + value.label + '</option>');
			});
			$("#id_users").removeAttr('disabled').trigger("chosen:updated");
		}
	});
};
