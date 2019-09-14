"use strict";
$(document).on('turbolinks:load', function () {
  $('.share-button').click(function (event) {
    if (navigator.share) {
      navigator.share({
        title: "Yart " + event.target.dataset.text,
        url: location.origin + event.target.dataset.url
      }).then(function() {
        console.log('Thanks for sharing!');
      }).catch(console.error);
    }
  });
});
