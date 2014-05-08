$( document ).ajaxError(function(e, xhr, settings, error) {
  if ('Unauthorized' == error || '' == error) {
    $.updateUser(false, {});
    $( document ).trigger("prowl:user:deauthed");
  }
});

$( document ).ajaxComplete(function(e, xhr, settings) {
  // if ('error' == xhr.statusText) {
  //   $.updateUser(false, {});
  //   $( document ).trigger("prowl:user:deauthed");
  // }
});

$( document ).ajaxSuccess(function(e, xhr, options){
  if (!$.userLoggedIn) {
    $( document ).trigger("prowl:user:authenticated", xhr.responseJSON);
  }
});
