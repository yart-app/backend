"use strict";

$(document).on('turbolinks:load', function () {
    const onboarded = $('.onboarded').val();

    if (onboarded == "false") {
      let tour = introJs();
      tour.setOption('exitOnOverlayClick', '');
      tour.setOption('showStepNumbers', '');
      tour.setOption('exitOnEsc', '');
      tour.start();
    }
});

function update_status(id, status) {
  var data = {
    id: id,
    status: status
  }

  $.post("update_status", data, function (response, status) {});
}

function update_category(id, category) {
  var data = {
    id: id,
    category: category
  }

  $.post("update_category", data, function (response, status) {});
}
