$.usersSection = function(isLoggedIn) {
  if (isLoggedIn) {
    $(".isLoggedIn").removeClass('hidden')
    $(".isNotLoggedIn").addClass('hidden')
  } else {
    $(".isLoggedIn").addClass('hidden')
    $(".isNotLoggedIn").removeClass('hidden')
  }
}

$.setUserDetails = function(userObject) {
  $('#user-name').html(userObject.email);
}

$.userFetch = function(callback) {
    $.simpleGET(loaderType, {}, function(data, status, xhr) {
      $.setUserDetails(xhr.responseJSON);
    });
}

$( document ).ready(function(){
  $( document ).on("prowl:load:all prowl:load:orgusers", function(){
    $.loadColumn('users');
  });

  $( document ).on("prowl:user:authenticated", function(event, userObject){
    $.userLoggedIn = true;
    // $.userSection(true);
    $.setUserDetails(userObject);
  });

  $.loadTemplateIntoModal('login');
  $.loadTemplateIntoModal('register');

  $( "#pleaseWaitDialog" ).on("show.bs.modal", function(){
    console.log($._data($( document )[0], "events")["prowl:load:all"].length);
  })

  $('#infoModal').on('show.bs.modal', function (e) {
    $("#sign-in-form").on("ajax:success", function(e, xhr, options){
      $.setUserDetails(xhr);
      $('#infoModal').modal('hide');
      $( document ).trigger("prowl:load:all");
    });
  });
});
