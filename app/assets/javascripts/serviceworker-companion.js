if (navigator.serviceWorker) {
  navigator.serviceWorker
    .register("/serviceworker.js", { scope: "./" })
    .then(function (reg) {});

  navigator.serviceWorker.ready.then(function (serviceWorkerRegistration) {
    serviceWorkerRegistration.pushManager
      .subscribe({
        userVisibleOnly: true,
        applicationServerKey: window.vapidPublicKey,
      })
      .then(function (subscription) {
        var data = {
          subscription: subscription.toJSON(),
        };

        $.post(
          "/users/subscribe_to_notifications",
          data,
          function (response, status) {
            console.log(
              "Your push notifications subscription has been saved in db"
            );
          }
        );
      });
  });
}
