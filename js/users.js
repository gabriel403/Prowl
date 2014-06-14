$.prowl.users = { }
$.prowl.users.updateUser = function() {
  if ($.prowl.userAuth.authed && $.prowl.userAuth.user) {
    $('#user-name').html($.prowl.userAuth.user.email);
    $.cookie('prowl_token', $.prowl.userAuth.user.authentication_token, { expires: 7, path: '/' });
    $.cookie('prowl_auth', $.prowl.userAuth.user.email, { expires: 7, path: '/' });
  } else {
    $('#user-name').empty();
  }

  $.prowl.users.twitchUserUI();
}

$.prowl.users.twitchUserUI = function() {
  if ($.prowl.userAuth.authed && $.prowl.userAuth.user) {
    $(".isLoggedIn").removeClass('hidden');
    $(".isNotLoggedIn").addClass('hidden');
  } else {
    $(".isLoggedIn").addClass('hidden');
    $(".isNotLoggedIn").removeClass('hidden');
  }
}

$.prowl.users.userFetch = function() {
    $.prowl.common.simpleGET('/organisations', {}, function(data, status, xhr) {
      if (0 == xhr.responseJSON.length) {
        $( document ).trigger("prowl:regorg");
      }
    });
}

$( document ).ready(function(){
  $( document ).on("prowl:load:all prowl:load:orgusers", function(){
    $.prowl.common.loadColumn('users');
  });

  $( "a#logout" ).on('ajax:success', function(e){
    $.prowl.users.updateUser(false);
    $( document ).trigger("prowl:user:deauthed");
  })

  $( document ).one("prowl:user:authenticated", function(event){
    $.prowl.users.userFetch();
  });

  $( document ).on("prowl:regorg:load", function(){
    $( "#new-org-form" ).on("ajax:success", function(e, xhr, options){
      $.prowl.orgs.orgCreated(xhr);
    });

    $( "#join-org-form" ).on("ajax:success", function(e, xhr, options){
      console.log(e);
    });
  });

  $.prowl.common.loadTemplateIntoModal('login');
  $.prowl.common.loadTemplateIntoModal('register');
  $.prowl.common.loadTemplateIntoModal('regorg', {backdrop: 'static', keyboard: false});

  $('#infoModal').on('show.bs.modal', function (e) {
    $("#sign-in-form").on("ajax:success", function(e, xhr, options){
      $( document ).trigger("prowl:user:authenticated", xhr);
    });
  });
});
