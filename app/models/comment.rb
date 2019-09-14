class Comment < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :post, optional: true
  belongs_to :user

  validates :text,
            presence: true,
            length: { maximum: 500 }

  validate :belongs_to_post_or_project

  def self.add(data, user)
    comment = Comment.new(data)
    comment.user = user
    comment.save

    comment.target.user.send_notification(
      message: "#{user.username} commented on your #{comment.target.class.name}",
    )

    comment
  end

  def target
    post || project
  end

  def belongs_to_post_or_project
    if project_id.nil? && post_id.nil?
      errors.add(:base, "comment should belongs either to a post or a project")
    end
  end
end
