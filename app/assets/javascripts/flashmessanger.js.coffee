$ = jQuery
$.fn.flashMessanger = (options) ->
    defaults =
        type    : 'info'
        message : ''

    options = $.extend(defaults, options)
    $(this).append("<div class='flash alert-dismissable " + options.type + " alert alert-" + options.type + "'>" + options.message + "</div>")