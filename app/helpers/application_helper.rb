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

  def current_user_path
    profile_url(current_user.id)
  end

  def is_active_link (path)
      current_page?(path) && 'has-text-primary'
  end
end
