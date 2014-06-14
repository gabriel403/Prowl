$( document ).ready(function(){
  $.prowl.common.simpleGET('/users/show', {}, function(data, status, xhr) {
    $( document ).trigger("prowl:user:authenticated", xhr.responseJSON);
    // $( document ).trigger("prowl:load:all");
  }, $.prowl.users.updateUser);
});
