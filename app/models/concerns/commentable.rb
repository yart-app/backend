module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments
  end

  def limited_comments(page: 1, limit: 5)
    {
      chunk: comments.page(page).per(limit),
      next: comments.page(page.to_i + 1).per(limit).count
    }
  end
end
