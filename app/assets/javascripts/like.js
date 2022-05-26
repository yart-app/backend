"use strict";
$(document).on("turbolinks:load", function () {
  $(".like").click(function (e) {
    var data = {
      id: e.target.id,
    };

    $.post("/posts/likes", data, function (response, status) {
      if (status !== 422) {
        var icon = "favorite_border";

        if (response.message === "liked") {
          icon = "favorite";
        }
        $("#likes-size-" + data.id).html(response.likes_size);
        $(e.target).html(icon);
      }
    });
  });
});
