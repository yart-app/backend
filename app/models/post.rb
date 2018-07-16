class Post < ApplicationRecord
  belongs_to :project, optional: true
  has_one_attached :image

  validates :text,
            length: { maximum: 700 }

  validate :content_presence

  # Custom validators
  def content_presence
    errors.add(:base, 'a post should have content') unless content?
  end

  def content?
    !text.blank? && image.attached?
  end
end
