function toggleFollow(id, button) {
  var data = {
    id: id
  }

  var url = "/users/toggle_follow/";

  $.post(url, data, function (response, status) {
    var newButtonName = newButtonValue(button.innerText);
    button.innerText = newButtonName;
  });
}

function newButtonValue(oldValue) {
  if (oldValue === "follow") {
    return "unfollow";
  } else {
    return "follow";
  }
}
