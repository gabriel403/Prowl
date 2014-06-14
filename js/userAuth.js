$.prowl.userAuth = { }
$.prowl.userAuth.isAuthed = function() {
  $.prowl.common.simpleGET('/users/show', {}, function(data, status, xhr) {
    $.prowl.userAuth.authenticated(xhr.responseJSON);
  }, $.prowl.users.updateUser);
}

$.prowl.userAuth.authenticated = function(user) {
  $.prowl.userAuth.authed = true;
  $.prowl.userAuth.user   = user;
  $.prowl.users.updateUser(true);
}

$( document ).on("prowl:user:auth", function(user){
  $.prowl.userAuth.isAuthed();
});

$( document ).on("prowl:user:authenticated", function(e, user){
  $.prowl.userAuth.authenticated(user);
  $.prowl.users.userFetch();
  $('#infoModal').modal('hide');
  $( document ).trigger("prowl:load:all");
});

$( document ).on("prowl:user:deauthed", function(user){
  $.prowl.users.twitchUserUI();
});


$.prowl.userAuth.authed = false;
