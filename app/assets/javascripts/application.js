// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require turbolinks
//= require_tree .

flash_checker = function(request) {
	// first show message
	if (! ("getResponseHeader" in request)) {
		return false;
	}
	type = request.getResponseHeader("X-Message-Type")
	message = request.getResponseHeader("X-Message")
	if (type && message) {
		$('#flash_message').flashMessanger({type:type,message:message})

		$('#linkerModal').modal('hide')

		if ('success' == type || 'info' == type) {
			return true;
		}

		return false;
	}

	return true;
}

generic_hide = function(){
	dst = $("#deploy_step_deploy_step_type_option_id").val()

	if (!dst){
		return
	}

	callback = function(response){
		if( typeof response != 'object' || !('subtype' in response)) {
			return
		}

		switch (response.subtype) {
			case 'generic':
				$("#deploy_step_order").closest(".field").addClass("hide");
				$("#deploy_step_value").closest(".field").addClass("hide");
				break;
			case 'unordered':
				$("#deploy_step_order").closest(".field").addClass("hide");
				$("#deploy_step_value").closest(".field").removeClass("hide");
				break;
			case 'specific':
				$("#deploy_step_order").closest(".field").removeClass("hide");
				$("#deploy_step_value").closest(".field").removeClass("hide");
				break;
			default:
				$("#deploy_step_order").closest(".field").removeClass("hide");
				$("#deploy_step_value").closest(".field").removeClass("hide");
				break;
		}

		$("#deploy_step_deploy_step_type_option_id").on('change', function(event){
			generic_hide();
		})
	}

	$.ajax({
		url: '/xhr/dst/'+dst,
		success: callback,
		dataType: 'json',
	});
}
postAnimation = function(){
	$(".collapseMe").toggleClass('collapsed').toggleClass('expanded')
	$(".expandMe").toggleClass('collapsed').toggleClass('expanded')
};


newDeployStep = function(){
	$('a.deploy_step_details, a#newDeployStep').click(function(event){
		event.preventDefault();
		var url = $(this).attr('href')
		var successFunc = function(data, textStatus, jqXHR){
			if (!flash_checker(jqXHR)) {
				return;
			}

			$(this).find(".subData").empty().html(data).toggleClass('hidden')
			$(this).find(".holdingImage").toggleClass('hidden')
			generic_hide()
			// hook into the form submit
			// reload the app panel when form submitted
			linkModalFetching();
		}
		if (!hideShow(this)) {
			hideShow(this)
		}
		populateNextCol(nextCol.children(".panel:not(.hidden)"), url, successFunc)
	})
}

deployDisplay = function(){
	$('a.deploy_details').click(function(event){
		event.preventDefault();
		var url = $(event.target).attr('href');
		var successFunc = function(data, textStatus, jqXHR){
			if (!flash_checker(jqXHR)) {
				return;
			}

			$(this).find(".subData").empty().html(data).toggleClass('hidden')
			$(this).find(".holdingImage").toggleClass('hidden')
			linkModalFetching();
		}
		if (!hideShow(this)) {
			hideShow(this)
		}
		populateNextCol(nextCol.children(".panel:not(.hidden)"), url, successFunc)
	})
}

newDeploy = function(){
	$('#newDeploy').click(function(event){
		var successFunc = function(data, textStatus, jqXHR){
			if (!flash_checker(jqXHR)) {
				return;
			}

			$(this).find(".subData").empty().html(data).toggleClass('hidden')
			$(this).find(".holdingImage").toggleClass('hidden')

			$("[data-clickable]").on('click', function(event){
				$(this).parent().children('[data-showable]').slideToggle("fast");
			});
			newDeployDisplay()
			linkModalFetching();
		}
		var id = getEnvId();
		if (!hideShow(this)) {
			hideShow(this)
		}
		populateNextCol(nextCol.children(".panel:not(.hidden)"), '/deploys/new/'+id, successFunc)
	})
}

newDeployDisplay = function(){
	$('#new_deploy_option_form').on('submit',function(event){
		event.preventDefault();
		var data = $(event.target).serialize();
		var successFunc = function(data, textStatus, jqXHR){
			if (!flash_checker(jqXHR)) {
				return;
			}

			context = this
			// console.log(data);
			// console.log(textStatus);
			if (jqXHR.getResponseHeader('Location')) {
				reloadURL = jqXHR.getResponseHeader('Location');
				var successFunc = function(data, textStatus, jqXHR){

					setTimeout(function() {
						$(context).find(".subData").empty().html(data)
						if (-1 == data.indexOf('<div class="col-md-8">finished</div>') &&
							-1 == data.indexOf('<div class="col-md-8">failed</div>')) {
							populateNextCol(context, reloadURL, successFunc)
						}
					}, 2000);


				}
				populateNextCol(this, jqXHR.getResponseHeader('Location'), successFunc)
				console.log(this)
				// populate rhs pane
			}
		}
		$.ajax({
			type: "POST",
			url: $(event.target).attr('action'),
			data: data,
			success: successFunc,
			converters: {"text json":true},
			dataType: 'json',
			context: $(this).closest(".col-md-4")
		});
	});
}

reloadDeployment = function(url, context) {

}

getAppId = function() {
	var id = false
	if (!$('.overOverlay').attr('id')) {
		return id
	}
	var res = $('.overOverlay').attr('id').match(/\d+/gi);
	if (res && res.length > 0) {
		id = res[0];
	}
	return id
}

getEnvId = function() {
	var id = false
	var res = $(".envClickable").attr('id').match(/\d+/gi);
	if (res && res.length > 0) {
		id = res[0];
	}
	return id
}

overylayWork = function(event){
	if (!$(this).closest(".panel-body").find('.smallOverlay').length) {
		$(this).closest(".panel-body").append("<div class='smallOverlay'></div>")
		$(this).closest(".panel-body").find('.smallOverlay').on('click', overylayWork)
	}

	if (!$(this).closest(".panel-body").find('.overOverlay').length) {
		$(this).closest(".panel-body").find('.smallOverlay').toggleClass('overlay')
		$(this).toggleClass('overOverlay')
	}

	var hs = hideShow(this)

	if (!hs) {
		return
	}

	if (this.id.search("app") != 0) {
		console.log("no app")
		return
	}

	var id = getAppId();

	var successFunc = function(data, textStatus, jqXHR){
		if (!flash_checker(jqXHR)) {
			return;
		}

		$('.jizz, .overOverlay').on('click', function(e){
			if ((!$(e.target).hasClass('overOverlay') && !$(e.target).closest('.overOverlay').length) &&
				( $(e.target).closest('.pointer').length || $(e.target).closest('button').length
				|| $(e.target).closest('a').length || $(e.target).hasClass('btn'))
				|| $(e.target).is('input') || $(e.target).is('textarea')
			) {
				return;
			}
			$(".panel:not(.hidden)").closest('.col-md-4').find('.smallOverlay').toggleClass('overlay')
			$(".panel:not(.hidden)").closest('.col-md-4').find('.overOverlay').toggleClass('overOverlay')
			$(".panel:not(.hidden) .subs:not(.hidden)").closest('.col-md-4').children('.panel').toggleClass('hidden');
			$(".panel.hidden .subs.holdingImage.hidden").parent().children('.subs').toggleClass('hidden')
			$(".jizz").off()
			$(".clickToExpandThingy").off()
			appFetching();
		});

		$(this).find(".subData").empty().html(data).toggleClass('hidden')
		$(this).find(".holdingImage").toggleClass('hidden')
		$(this).find(".envClickable").on('click', function(event){
			$(this).parent().find(".envClickable").not(this).remove();
			var id = getEnvId();
			var successFunc = function(data, textStatus, jqXHR) {
				if ($(this).find('.expandedEnv').length == 0) {
					$(this).find('.panel-body .subData').append("<div class='expandedEnv'></div>");
				}

				$(this).find('.expandedEnv').empty().append(data);

				newDeployStep()
				newDeploy()
				deployDisplay()
				linkModalFetching();
			}
			populateNextCol(nextCol.children(".panel:not(.hidden)"), '/environments/'+id, successFunc)
		});
	};

	populateNextCol(nextCol.children(".panel:not(.hidden)"), '/apps/'+id, successFunc)
}

hideShow = function(context) {
	// find parent column
	parentCol = $(context).closest(".col-md-4")

	// find next column
	nextCol   = parentCol.next(".col-md-4")
	// toggle .panel
	nextCol.children(".panel").toggleClass('hidden')

	if (nextCol.children(".panel.hidden").find(".subs").length > 0) {
		//we've hidden the xhr panel, so just return
		nextCol.children(".panel.hidden").find(".subData").empty().addClass('hidden')
		nextCol.children(".panel.hidden").find(".holdingImage").removeClass('hidden')
		console.log("xhrpanel hidden, no xhr")

		nextCol2   = nextCol.next(".col-md-4")

		if (nextCol2.children(".panel:not(.hidden)").find(".subs").length > 0) {
			nextCol2.children(".panel").toggleClass('hidden')
			nextCol2.children(".panel.hidden").find(".subData").empty().addClass('hidden')
			nextCol2.children(".panel.hidden").find(".holdingImage").removeClass('hidden')
		}

		return false
	}
	return true
}

populateNextCol = function(context, url, callback) {
	$.ajax({
		url:        url,
		success:    callback,
		dataType:   'json',
		converters: {"text json":true},
		context:    context
	});
}

appFetching = function() {
	$(".clickToExpandThingy").on('click', overylayWork)
}

linkModalFetching = function() {
	if (2 == document.location.href.split(document.location.host).length) {
		if (2 == document.location.href.split(document.location.host)[1].split(/\?locale=.+/).length) {
			if ('/' !== document.location.href.split(document.location.host)[1].split(/\?locale=.+/)[0]) {
				return;
			}
		} else {
			return;
		}
	} else {
		return;
	}
	$('a').off();
	$('a').on('click', function(event) {
		event.preventDefault();
		var url = $(this).attr('href');	
		var callback = function(data, textStatus, jqXHR){
			$('#linkerModal .modal-body').html(data);
			$('#linkerModal').modal()
		}

		$.ajax({
			url:        url,
			success:    callback,
			dataType:   'json',
			converters: {"text json":true}
		});
	})
}

$( document ).on('page:load', appFetching);
$( document ).on('page:load', linkModalFetching);

$( document ).ready(appFetching);
$( document ).ready(linkModalFetching);

$( document ).on('page:load', function(){
	$("[data-clickable]").on('click', function(event){
		$(this).parent().children('[data-showable]').slideToggle("fast");
	});
})

$( document ).ready(function(){
	$("[data-clickable]").on('click', function(event){
		$(this).parent().children('[data-showable]').slideToggle("fast");
	});
})

$(document).bind("ajaxComplete", function(event, response){
	flash_checker(response);
 });


