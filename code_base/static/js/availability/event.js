$(function() {
	$(".can_add").click(function() {
		url = $(this).attr('rel');
		date = $(this).data('date');
		if (url) {
			$.ajax({
				type : 'GET',
				url : url,
				data : {
					'date' : date
				},
				success : function(response) {
					$('#event_details').html(response);
					$('#event_details').modal('show');
					initSubmitButton();
				},
				error : function(response) {
					$('#event_details').modal('show');
					initSubmitButton();
				}
			});
		}
	});

	$('#event_details').on('hidden', function() {
		$('#until').datepicker('hide');
	});
});


function initSubmitButton() {
	date_arr = $("#start_date").val().split('-');
	var checkin = new Date(date_arr[2],date_arr[1]-1,date_arr[0]);
	$('#until').datepicker({
		autoclose : true,
		onRender : function(date) {
			return date.valueOf() < checkin ? 'disabled' : '';
		}
	});
	$("#event_details").on('click', '#btn_submit', function() {

		$.ajax({
			type : 'POST',
			url : $("#add_event").attr('action'),
			data : $('#add_event').serialize(),
			success : function(response) {
				response = eval("(" + response + ")");
				if (response.stat) {
					location.reload();
				} else {
					$('#event_details div.modal-body').html("<p>You already have set your availability.</p>");
					$("#btn_submit").css('display', 'none');
					$("#btn_cancel").addClass('btn-success');
					$('#event_details').modal('show');
					$('#until').datepicker({autoclose : true});
				}

			}
		});
	});

}

