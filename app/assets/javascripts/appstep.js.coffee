$ = jQuery
$.fn.deployStep = (options) ->
    defaults =
        type    : 'info'
        message : ''

    options = $.extend(defaults, options)
    $(this).append("<div class='flash " + options.type + " alert alert-" + options.type + "'>" + options.message + "</div>")