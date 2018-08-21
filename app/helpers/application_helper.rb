module ApplicationHelper
  def user_avatar(user, options = {})
    if user.avatar.attached?
      image_tag user.avatar, options
    else
      image_tag "default_avatar.png", options
    end
  end
end
