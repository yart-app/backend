$(document).on('turbolinks:load', function () {
  function postComment(target, input) {
    var data = {
      'comment': {
        'text': target.value,
        'post_id': target.id,
      }
    };

    var comments_container = $('#comments_container_' + data.comment.post_id);

    $.post("/comments", data, function (response, status) {
      if (status !== 422) {
        var comment_open_div = '<div class="comment-section">';
        var comment_close_div = '</div>';

        comments_container.prepend(
          comment_open_div +
          "<strong>" +
          response.comment.username +
          ": </strong>" +
          response.comment.text +
          comment_close_div);
        input.val('');
      }
    });
  }

  $('.comment').keypress(function (e) {
    var input = $(this);

    if (e.keyCode == 13) {
      postComment(e.target, input);
    }
  });

  function getComments(target, page) {

    var data = {
      'page': page,
      'post_id': target.id,
    };

    var comments_container = $('#comments_container_' + data.post_id);

    $.get("/comments", data, function (response, status) {
      if (status !== 422) {
        var comment_open_div = '<div class="comment-section">';
        var comment_close_div = '</div>';

        response.comments.forEach(comment => {
          comments_container.append(
            comment_open_div +
            "<strong>" +
            comment.username +
            ": </strong>" +
            comment.text +
            comment_close_div
          );
        });

        if (response.next == 0)
        {
          console.log('response.next: ', response.next);
          $(target).addClass('hidden');
        }
      }
    });
  }

  function getNextPage(target) {
    var page = $('#page_' + target.id).val();
    var nextPage = parseInt(page) + 1;

    $('#page_' + target.id).val(nextPage);

    return nextPage;
  }

  $('.more-comments').click(function (e) {
    getComments(e.target, getNextPage(e.target));
  });
});
