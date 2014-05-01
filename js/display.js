$( document ).ready(function(){
  $( document ).on("prowl:user:authenticated", function(userObject){
    $("#marketing").addClass("hide");
    $("#mainArea").removeClass("hide");
  });
});
