$( document ).ready(function(){
  $( document ).on("prowl:load:all prowl:load:orgservers", function(){
    $.loadColumn('servers');
  });
});
