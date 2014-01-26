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

		$("#deploy_step_deploy_step_type_option_id").change(function(event){
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


nds = function(){
	$('#newDeployStep').click(function(event){
		var successFunc = function(data, textStatus, jqXHR){
			$(this).find(".subData").empty().html(data).toggleClass('hidden')
			$(this).find(".holdingImage").toggleClass('hidden')
			generic_hide()
		}
		if (!hideShow(this)) {
			hideShow(this)
		}
		populateNextCol(this, '/deploy_steps/new', successFunc)
	})
}

nd = function(){
	$('#newDeploy').click(function(event){
		var successFunc = function(data, textStatus, jqXHR){
			$(this).find(".subData").empty().html(data).toggleClass('hidden')
			$(this).find(".holdingImage").toggleClass('hidden')
		}
		var id = getAppId();
		if (!hideShow(this)) {
			hideShow(this)
		}
		populateNextCol(this, '/deploys/new/'+id, successFunc)
	})
}

getAppId = function() {
	var id = false
	if (!$('.overOverlay').attr('id')) {
		return id
	}
	var res = $('.overOverlay').attr('id').match(/\d/gi);
	if (res && res.length > 0) {
		id = res[0];
	}
	return id
}

overylayWork = function(event){
	if (!$(this).closest(".panel-body").find('.smallOverlay').length) {
		$(this).closest(".panel-body").append("<div class='smallOverlay'></div>")
		$(this).closest(".panel-body").find('.smallOverlay').click(overylayWork)
	}

	$(this).closest(".panel-body").find('.smallOverlay').toggleClass('overlay')
	if ($(this).closest(".panel-body").find('.overOverlay').length) {
		$(this).closest(".panel-body").find('.overOverlay').toggleClass('overOverlay')
	} else {
		$(this).toggleClass('overOverlay')
	}

	var hs = hideShow(this)

	if (this.id.search("app") != 0) {
		console.log("no app")
		return
	}

	var id = getAppId();

	var successFunc = function(data, textStatus, jqXHR){
		$(this).find(".subData").empty().html(data).toggleClass('hidden')
		$(this).find(".holdingImage").toggleClass('hidden')
		nds()
		nd()
	};

	if (!hs) {
		return
	}

	populateNextCol(this, '/apps/'+id, successFunc)


	// if ($(".expandMe").width() == "0") {
	// 	$(".expandMe").animate({ width: '33%' }, 'slow');
	// 	$(".collapseMe").animate({ width: '0%' }, 'slow', 'swing', postAnimation);
	// } else {
	// 	$(".expandMe").animate({ width: '0%' }, 'slow');
	// 	$(".collapseMe").animate({ width: '33%' }, 'slow', 'swing', postAnimation);
	// }
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
		url: url,
		success: callback,
		dataType: 'json',
		converters: {"text json":true},
		context: nextCol.children(".panel:not(.hidden)")
	});
}
$( document ).on('page:load', function(){
	$(".clickToExpandThingy").click(overylayWork)
})

$( document ).ready(function(){
	$(".clickToExpandThingy").click(overylayWork)
})