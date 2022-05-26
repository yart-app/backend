"use strict";
$(document).on('turbolinks:load', function () {
  var commentTemplate = document.getElementById('comment-template');

  function commentElement (user, text) {
    var clone = commentTemplate.content.cloneNode(true);
    $(clone).find('#comment-user').text(user);
    $(clone).find('#comment-text').text(text);

    return clone;
  }

  function postComment(target, input) {
    var data = {
      'comment': {
        'text': target.value,
        'post_id': target.id,
      }
    };

    var commentsContainer = $('#comments_container_' + data.comment.post_id);

    $.post("/comments", data, function (response, status) {
      if (status !== 422) {
        var commentOpenDiv = '<div class="comment-section">';
        var commentCloseDiv = '</div>';

        commentsContainer.prepend(
          commentElement(response.comment.username, response.comment.text)
        );

        input.val('');
      }
    });
  }

  function getComments(target, page) {

    var data = {
      'page': page,
      'post_id': target.id,
    };

    var commentsContainer = $('#comments_container_' + data.post_id);

    $.get('/comments', data, function (response, status) {
      if (status !== 422) {
        var commentOpenDiv = '<div class="comment-section">';
        var commentCloseDiv = '</div>';

        response.comments.forEach(function (comment) {
          commentsContainer.append(
            commentElement(comment.username, comment.text)
          );
        });

        if (response.next === 0) {
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

  $('.add-comment').keypress(function (e) {
    var input = $(this);

    if (e.keyCode == 13) {
      postComment(e.target, input);
    }
  });
});
