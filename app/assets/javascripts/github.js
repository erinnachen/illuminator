$(document).ready (function () {
  $(".star").click (function(event) {
    event.preventDefault();
    var url = $(this).attr('href');
    $.post(url, function(){});
    // Add one to the count
  })
})
