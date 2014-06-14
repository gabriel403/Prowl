$.prowl.orgs = { }

$.prowl.orgs.orgCreated = function(org) {
  $.prowl.orgs.org = org;

  // hide modal
  $('#infoModal').modal('hide');

  //add user to org
  $.prowl.common.simplePOST('/organisation_users', {access_code: $.prowl.orgs.org.access_code, organisation_user: {user_id: $.prowl.userAuth.user.id, organisation_id: $.prowl.orgs.org.id, access_level_id: 1} });
}

$.prowl.orgs.orgjoined = function(org) {
  // hide modal
  $('#infoModal').modal('hide');
}
