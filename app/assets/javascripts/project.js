"use strict";


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
