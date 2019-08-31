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
//= require select2/dist/js/select2.min
//= require_tree .

"use strict";
$(document).on('turbolinks:load', function () {
  var c, currentScrollTop = 0, navbar = $('.is-fixed-top');

  $(window).scroll(function () {
    var a = $(window).scrollTop();
    var b = navbar.height();

    currentScrollTop = a;

    if (c < currentScrollTop && a > b + b) {
      navbar.addClass("hidden");
    } else if (c > currentScrollTop && !(a <= b)) {
      navbar.removeClass("hidden");
    }
    c = currentScrollTop;
  });

  $('.select2-with-create-option').select2({
    tags: true
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
//= require serviceworker-companion
