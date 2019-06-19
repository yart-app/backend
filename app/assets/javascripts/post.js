"use strict";
function readImageURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('.uploaded-image').attr('src', e.target.result);
      $('.uploaded-image').removeAttr("style");
    };

    reader.readAsDataURL(input.files[0]);
  }
}

function runIntoJsOnSubmitBtn() {
  var onboarded = $('.onboarded').val();

  if (onboarded == "false") {
    // Use setTimeOut here to wait for dom to update before
    // starting introJs and focus on submit button

    setTimeout(function() {
      introJs().setOptions({
        'scrollTo': $('.submit'),
      });

      introJs().goToStepNumber(5).start();
    }, 50);
  }
}
