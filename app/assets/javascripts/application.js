// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require intro.js/minified/intro.min.js
//= require_tree .

"use strict";
$(document).on('turbolinks:load', function () {
  $(".collapsible").click(function () {
    var content = this.nextElementSibling;
    var contentToHide = content.nextElementSibling;
    if (content.style.display === "block") {
      content.style.display = "none";
      contentToHide.style.display = "";
    } else {
      content.style.display = "block";
      contentToHide.style.display = "none";
    }
  });

  $("#new-post-card").mouseover(function () {
    $(".new-post-icon").fadeOut();
  });

  $("#new-post-card").mouseleave(function () {
    $(".new-post-icon").fadeIn();
  });

  // The following code is based off a toggle menu by @Bradcomp
  // source: https://gist.github.com/Bradcomp/a9ef2ef322a8e8017443b626208999c1
  var burger = document.querySelector('.burger');
  var menu = document.querySelector('#' + burger.dataset.target);
  burger.addEventListener('click', function () {
    burger.classList.toggle('is-active');
    menu.classList.toggle('is-active');
  });
});

function readImageURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('.uploaded-image').attr('src', e.target.result);
      $('.uploaded-image').removeAttr("style");
    };

    reader.readAsDataURL(input.files[0]);
    runIntoJsOnSubmitBtn();
  }
}

function runIntoJsOnSubmitBtn() {
  const onboarded = $('.onboarded').val();

  if (onboarded == "false") {
    // Use setTimeOut here to wait for dom to update before
    // starting introJs and focus on submit button

    setTimeout(() => {
      introJs().setOptions({
        'scrollTo': $('.submit'),
      });

      introJs().goToStepNumber(5).start();
    }, 50);
  }
}
