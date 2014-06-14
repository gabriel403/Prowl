$( document ).ready(function(){
  $( document ).on("prowl:load:all prowl:load:orgservers", function(){
    $.prowl.common.loadColumn('servers');
  });
});
