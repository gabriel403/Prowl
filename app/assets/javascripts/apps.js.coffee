# generic   = noorder & novalue
# unordered = noorder & value
# specific  = order   & value
generic_hide = () ->
	dst = $("#deploy_step_deploy_step_type_option_id").val()
	console.log(dst);
	if !dst
		return
	callback = (response) ->
		console.log(response)
		if typeof response != 'object' || !('subtype' of response)
			return
		console.log(response.subtype)
		switch response.subtype
			when 'generic'
				$("#deploy_step_order").closest(".field").addClass("hide");
				$("#deploy_step_value").closest(".field").addClass("hide");
			when 'unordered'
				$("#deploy_step_order").closest(".field").addClass("hide");
				$("#deploy_step_value").closest(".field").removeClass("hide");
			when 'specific'
				$("#deploy_step_order").closest(".field").removeClass("hide");
				$("#deploy_step_value").closest(".field").removeClass("hide");
			else
				$("#deploy_step_order").closest(".field").removeClass("hide");
				$("#deploy_step_value").closest(".field").removeClass("hide");
	$.get '/xhr/dst/'+dst, callback, 'json'

onLoadFunc = () ->
	generic_hide()

	$("#deploy_step_deploy_step_type_option_id").on 'change', (event) ->
		generic_hide()


	$('form[data-remote]').on 'ajax:success',  (xhr, data, status, request) ->
		# first show message
		type = request.getResponseHeader("X-Message-Type")
		message = request.getResponseHeader("X-Message")
		$('#flash_message').flashMessanger({type:type,message:message})

		# then show new entry somehow
		eval(data);
		$('#deployStepsList').append(content);

		# finally reset form
		$("#new_deploy_step")[0].reset();

	$('form[data-remote]').on 'ajax:complete',  (xhr, status, request) ->
		console.log('complete')
		# console.log(status)

	$('form[data-remote]').on 'ajax:error',  (xhr, data, status, request) ->
		# type = request.getResponseHeader("X-Message-Type")
		# message = request.getResponseHeader("X-Message")
		# $('#flash_message').flashMessanger({type:type,message:message})
		console.log('error')
		# console.log(data)

$(document).ready ->
	onLoadFunc()

$(document).on 'page:load', () ->
	onLoadFunc()



