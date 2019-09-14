module ApplicationHelper
  def user_avatar(user, options = {})
    if user.avatar.attached?
      image_tag user.avatar, options
    else
      image_tag "default_avatar.png", options
    end
  end

  def favorite_icon(post)
    if current_user.voted_up_on?(post)
      return "favorite"
    end

    "favorite_border"
  end
end
