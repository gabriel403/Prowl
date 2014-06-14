$.prowl.common = { }
$.prowl.common.parseForTemplateLoad = function() {
  // data-load-template="true" data-template="register"
  // $("ul[data-group='Companies'] li[data-company='Microsoft']")
}

$.prowl.common.loadTemplateIntoModal = function(templatePrefix, modalOptions) {
  if (!modalOptions) {
    modalOptions = {};
  }

  if ($("#"+templatePrefix+"Link").length > 0) {
    $("#"+templatePrefix+"Link").on("click", {templatePrefix: templatePrefix, modalOptions: modalOptions}, $.prowl.common.reallyLoadTemplateIntoModal);
  } else {
    $( document ).one("prowl:"+templatePrefix, {templatePrefix: templatePrefix, modalOptions: modalOptions}, $.prowl.common.reallyLoadTemplateIntoModal);
  }
}

$.prowl.common.reallyLoadTemplateIntoModal = function(e) {
  var templatePrefix = e.data.templatePrefix
  var modalOptions   = e.data.modalOptions
  e.preventDefault();

  var viewData = { };
  viewData     = $.extend(viewData, $.prowl.config);
  $.Mustache.load("./forms/"+templatePrefix+".html")
  .done(function () {
    $('#infoModal .modal-content').mustache(templatePrefix+"form", viewData);
    $('#infoModal').modal(modalOptions);
    $( document ).trigger("prowl:"+templatePrefix+":load");
  });
};

$.prowl.common.loadColumn = function(loaderType, data) {
  if (data) {
    $.prowl.common.columnMoustache(loaderType, data);
    return;
  }

  $.prowl.common.simpleGET(loaderType, {}, function(data, status, xhr) {
    $.prowl.common.columnMoustache(loaderType, xhr.responseJSON);
  });
}

$.prowl.common.columnMoustache = function(loaderType, data) {
  $.Mustache.load("./templates/" + loaderType + ".html")
  .done(function () {
    $('#' + loaderType + '-col').mustache(loaderType + "template", data);
  });
}



$.prowl.common.simplePOST = function(location, data, successHandler, errorHandler) {
  $.prowl.common.simpleAJAX('POST', location, data, successHandler, errorHandler);
}

$.prowl.common.simpleGET = function(location, data, successHandler, errorHandler) {
  $.prowl.common.simpleAJAX('GET', location, data, successHandler, errorHandler);
}

$.prowl.common.simpleAJAX = function(type, location, data, successHandler, errorHandler) {
  if (!errorHandler) {
    errorHandler = function(){};
  }

  options = {
    url:        $.prowl.config.apiLocation + '/' + location,
    type:       type,
    dataType:   'json',
    data:       data,
    beforeSend: function(xhr, settings) {
        xhr.setRequestHeader('accept', 'application/json, text/javascript');

        if ($.cookie('prowl_auth')) {
          xhr.setRequestHeader('X-Prowl-Token', $.cookie('prowl_token'));
          xhr.setRequestHeader('X-Prowl-Auth', $.cookie('prowl_auth'));
        }
    },
    success:     successHandler,
    error:       errorHandler,
    crossDomain: true,
    xhrFields:   {
      withCredentials: true
    }
  };

  $.ajax(options)
}
