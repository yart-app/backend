"use strict";

$(document).on('turbolinks:load', function () {
  $('.new-project-button').click(function () {
    $('.new-project-modal').addClass('is-active');
  });

  $('.modal-background').click(function () {
    $('.modal').removeClass('is-active');
  });
});

function updateTimeline(post) {
  var timelineContainer = $('.timeline');

  var newPostElement =
    '<div class="timeline-item">' +
    '<div class="timeline-marker is-icon">' +
    '<i class="fa fa-arrow-circle-right"></i>' +
    '</div>' +
    '<div class="timeline-content">' +
    '<p class="heading">' +
    post.created_at +
    '</p>' +
    '<p class="has-text-grey-light">' +
    post.text +
    '</p>' +
    '</div>' +
    '</div';

  timelineContainer.append(newPostElement);
}

function update_by_field(id, key, value) {
  var data = {
    id: id,
    key: key,
    value: value
  }

  $.post("update_by_field", data, function (response, status) {
    updateTimeline(response.post);
  });
}
