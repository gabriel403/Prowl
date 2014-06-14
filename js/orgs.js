$.prowl.orgs = { }

$.prowl.orgs.orgCreated = function(org) {
  $.prowl.orgs.org = org;

  // hide modal
  $('#infoModal').modal('hide');

  //add user to org
  $.prowl.common.simplePOST('/organisation_users', {access_code: $.prowl.orgs.org.access_code, organisation_user: {user_id: $.prowl.userAuth.user.id, organisation_id: $.prowl.orgs.org.id} });
}

$.prowl.orgs.orgJoined = function(org) {
  $.prowl.orgs.org = org;

  // hide modal
  $('#infoModal').modal('hide');

  //add user to org
  $.prowl.common.simplePOST('/organisation_users', {access_code: $.prowl.orgs.org.access_code, organisation_user: {user_id: $.prowl.userAuth.user.id, organisation_id: $.prowl.orgs.org.id} });
}

$( document ).ready(function(){
  $( document ).on("prowl:regorg:load", function(){
    $( "#new-org-form" ).on("ajax:success", function(e, xhr, options){
      $.prowl.orgs.orgCreated(xhr);
    });

    $( "#join-org-form" ).on("ajax:beforeSend", function(e, xhr, options){
      var data = $.unserialize(options.data);
      var access_code = data.organisationaccess_code[0];

      $.prowl.common.simpleGET('/organisations', { access_code: access_code }, function(data, status, xhr) {
        if (xhr.responseJSON) {
          $.prowl.orgs.orgJoined(xhr.responseJSON);
        }
      });
      return false;
    });
  });
});
