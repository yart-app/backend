class Comment < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :post, optional: true
  belongs_to :user

  validates :text,
            presence: true,
            length: { maximum: 500 }

  validate :belongs_to_post_or_project
  after_create :notify_user

  default_scope { order('created_at DESC') }

  def self.add(data, user)
    comment = Comment.new(data)
    comment.user = user
    comment.save

    comment
  end

  def notify_user
    target.user.send_notification(
      message: "#{user.username} commented on your #{self.target_name}",
    )
  end

  def target
    post || project
  end

  def target_name
    target.class.name
  end

  def belongs_to_post_or_project
    if project_id.nil? && post_id.nil?
      errors.add(:base, "comment should belongs either to a post or a project")
    end
  end
end
