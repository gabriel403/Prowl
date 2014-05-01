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
    },
    success: handler,
    crossDomain: null,
    xhrFields: {
      withCredentials: true
    }
  };

  $.ajax(options)
}

$( document ).ready(function(){
  $.simpleGET('/users/show', {}, function(data, status, xhr) {
    $( document ).trigger("prowl:user:authenticated", xhr.responseJSON);
    $( document ).trigger("prowl:load:all");
  });
});
