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
