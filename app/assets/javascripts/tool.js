
$(document).on('turbolinks:load', function () {
  $('.tools-link').click(function () {
    console.log('test tools modal');
    $('.modal').addClass('is-active');
  });

  $('.modal-close').click(function () {
    $('.modal').removeClass('is-active');
  });
});
