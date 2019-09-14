if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/serviceworker.js', { scope: './' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
    });

  navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
    serviceWorkerRegistration.pushManager
      .subscribe({
        userVisibleOnly: true,
        applicationServerKey: window.vapidPublicKey
      }).then((subscription) => {
        var data = {
          subscription: subscription.toJSON()
        };

        $.post('/users/subscribe_to_notifications', data, function (response, status) {
          console.log('Your push notifications subscription has been saved in db');
        });
      });
  });
}
