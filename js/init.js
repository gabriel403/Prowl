$( document ).ready(function(){
  $.simpleGET('/users/show', {}, function(data, status, xhr) {
    $( document ).trigger("prowl:user:authenticated", xhr.responseJSON);
    $( document ).trigger("prowl:load:all");
  });
});
