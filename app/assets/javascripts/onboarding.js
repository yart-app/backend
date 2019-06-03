"use strict";

$(document).on('turbolinks:load', function () {
  startOnboarding();
});

function startOnboarding() {
  const onboarded = $('.onboarded').val();

  if (onboarded == 'false') {
    const intro = introJs();

    intro.setOptions({
      steps: [{
          intro: '<img src="/assets/intro-1.jpg" /><br /><h3>Welcome to Yart</h3> a community by yarn artists for yarn artists!'
        },
        {
          intro: '<img src="/assets/intro-2.jpg" /><br /><h2>Projects</h2> you can share your crochet, knitting, weaving or embroidery projects with your friends'
        },
        {
          intro: '<img src="/assets/intro-3.jpg" /><br /><h2>Tools</h2> you can also share tools you are using in your projects, like patterns, yarn information and fabric you use.'
        },
        {
          intro: '<img src="/assets/intro-4.jpg" /><br /><h2>Start!</h2> share your progress with us and lets have fun!'
        }
      ]
    });

    intro.setOption('exitOnOverlayClick', '');
    intro.setOption('showStepNumbers', '');
    intro.setOption('exitOnEsc', '');
    intro.setOption('tooltipClass', 'tooltip-class');

    intro.start();

    intro.oncomplete(function () {
      finishOnboarding();
      intro.exit();
    });
  }
}

function finishOnboarding() {
  $.post('/users/onboarding/finish', {}, function (response, status) {
    console.log(response);
  });
}
