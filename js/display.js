$( document ).ready(function(){
  $( document ).on("prowl:user:authenticated", function(event){
    $("#marketing").addClass("hide");
    $("#mainArea").removeClass("hide");
  });

  $( document ).on("prowl:user:deauthed", function(event){
    $("#mainArea").addClass("hide");
    $("#marketing").removeClass("hide");
  });
});
