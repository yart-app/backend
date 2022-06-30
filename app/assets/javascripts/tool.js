$(document).on("turbolinks:load", function () {
  $(".edit-tools-link").click(function () {
    $(".edit-tools-modal").addClass("is-active");
  });

  $(".tools-link").click(function () {
    $(".tools-modal").addClass("is-active");
  });

  $(".modal-background").click(function () {
    $(".modal").removeClass("is-active");
  });
});
