$( document ).ajaxError(function(e, xhr, settings, error) {
  if ('Unauthorized' == error || '' == error) {
  }
});

$( document ).ajaxComplete(function(e, xhr, settings) {
  if ('error' == xhr.statusText) {
  }
});

$( document ).ajaxSuccess(function(e, xhr, options){
});
