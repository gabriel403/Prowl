$(document).ajaxComplete(function(e, xhr, options) {
  var csrf_param = xhr.getResponseHeader('X-CSRF-Param');
  var csrf_token = xhr.getResponseHeader('X-CSRF-Token');

  if (csrf_param) {
    $('meta[name="csrf-param"]').attr('content', csrf_param);
  }
  if (csrf_token) {
    $('meta[name="csrf-token"]').attr('content', csrf_token);
  }
});

$( document ).ajaxError(function(e, xhr, settings, error) {
  if ('Unauthorized' == error) {
    $.userLoggedIn = false;
    $.usersSection(false);
  }
});


$( document ).ajaxSuccess(function(e, xhr, options){
  if (!$.userLoggedIn) {
    $.simpleGET('/users/show', {}, function(data, status, xhr) {
      $.userLoggedIn = true;
      $( document ).trigger("prowl:user:authenticated", xhr.responseJSON);
      $( document ).trigger("prowl:load:all");
    });
  }
});
