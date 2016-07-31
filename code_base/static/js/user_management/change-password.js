$(function(){
	$("#profile_container").on('click','#change_password_link',function(){	
		$.ajax({
			type: 'GET',
			url: '/change-password/',
			success:function(response){
				$("#confirm_modal").html(response);
				$("#confirm_modal").modal();
			}
		});
	});
	
	InitChangePassword();
	
});
var InitChangePassword = function(){
	$("#confirm_modal").on('click', '#id_confirm_ok',function(){
		$.ajax({
			type : 'POST',
			url : '/change-password/',
			data: $("#change-password-form").serialize(),
			success:function(response){
				response = eval("(" +  response + ")");
				$("#confirm_modal").html('');
				if(response.stat){
					$("#confirm_modal").modal('hide');
					alert('Password changed successfully !!');
				}else{
					$("#confirm_modal").html(response.data);
					$("#confirm_modal").modal();
				}
			}
		});
	});
};
