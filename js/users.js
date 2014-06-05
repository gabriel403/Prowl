$.updateUser = function(isLoggedIn, userObject) {
  if (($.userLoggedIn && isLoggedIn) || (false === $.userLoggedIn && !isLoggedIn)) {
    return;
  }

  if ($.userLoggedIn || 'undefined' == typeof $.userLoggedIn) {
    $.userLoggedIn = false;
    $('#user-name').empty();
    $(".isLoggedIn").addClass('hidden');
    $(".isNotLoggedIn").removeClass('hidden');
  } else {
    $.userLoggedIn = true;
    $('#user-name').html(userObject.email);
    $.cookie('prowl_token', userObject.authentication_token, { expires: 7, path: '/' });
    $.cookie('prowl_auth', userObject.email, { expires: 7, path: '/' });
    $(".isLoggedIn").removeClass('hidden');
    $(".isNotLoggedIn").addClass('hidden');
  }
}

$.userFetch = function() {
    $.simpleGET('/users/show', {}, function(data, status, xhr) {
      $.updateUser(true, xhr.responseJSON);
    });

    $.simpleGET('/organisations', {}, function(data, status, xhr) {
      if (0 == xhr.responseJSON.length) {
        console.log("no org, make em make one");
        $( document ).trigger("prowl:regorg");
      }
    });
}

$( document ).ready(function(){
  $( document ).on("prowl:load:all prowl:load:orgusers", function(){
    $.loadColumn('users');
  });

  $( "a#logout" ).on('ajax:success', function(e){
    $.updateUser(false, {});
    $( document ).trigger("prowl:user:deauthed");
  })

  $( document ).on("prowl:user:authenticated", function(event){
    // $.userSection(true);
    $.userFetch();
  });

  $.loadTemplateIntoModal('login');
  $.loadTemplateIntoModal('register');
  $.loadTemplateIntoModal('regorg');

  $( "#pleaseWaitDialog" ).on("show.bs.modal", function(){
    console.log($._data($( document )[0], "events")["prowl:load:all"].length);
  })

  $('#infoModal').on('show.bs.modal', function (e) {
    $("#sign-in-form").on("ajax:success", function(e, xhr, options){
      $.updateUser(true, xhr);
      $('#infoModal').modal('hide');
      $( document ).trigger("prowl:load:all");
    });
  });
});
