module PostsHelper
  def favorite_icon(post)
    if current_user.voted_up_on?(post)
      return "favorite"
    end

    "favorite_border"
  end
end
