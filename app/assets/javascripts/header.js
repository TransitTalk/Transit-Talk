$(document).ready(function() {
  $( ".label-toggle" ).click(function() {
    if($(this).hasClass("clicked")) {
      $('#title').show();
    } else {
      $('#title').hide();
    }
      $(this).toggleClass("clicked");

  });
});
