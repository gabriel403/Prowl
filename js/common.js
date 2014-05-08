$.loadTemplateIntoModal = function(templatePrefix) {
  $("#"+templatePrefix+"Link").on("click", function(e){
    e.preventDefault();

    var viewData = { };
    viewData     = $.extend(viewData, globalConfig);

    $.Mustache.load("./forms/"+templatePrefix+".html")
    .done(function () {
      $('#infoModal .modal-content').mustache(templatePrefix+"form", viewData);
      $('#infoModal').modal();
    });
  });
}

$.loadColumn = function(loaderType, data) {
  if (data) {
    $.columnMoustache(loaderType, data);
    return;
  }

  $.simpleGET(loaderType, {}, function(data, status, xhr) {
    $.columnMoustache(loaderType, xhr.responseJSON);
  });
}

$.columnMoustache = function(loaderType, data) {
  $.Mustache.load("./templates/" + loaderType + ".html")
  .done(function () {
    $('#' + loaderType + '-col').mustache(loaderType + "template", data);
  });
}



$.simpleGET = function(location, data, handler) {
  options = {
    url: globalConfig.apiLocation + '/' + location,
    type: 'GET',
    dataType: 'json',
    data: data,
    beforeSend: function(xhr, settings) {
        xhr.setRequestHeader('accept', 'application/json, text/javascript');

        if ($.cookie('prowl_auth')) {
          xhr.setRequestHeader('X-Prowl-Token', $.cookie('prowl_token'));
          xhr.setRequestHeader('X-Prowl-Auth', $.cookie('prowl_auth'));
        }
    },
    success: handler,
    crossDomain: true,
    xhrFields: {
      withCredentials: true
    }
  };

  $.ajax(options)
}
