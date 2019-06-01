class Project < ApplicationRecord
  module Status
    NEW = "New".freeze
    UNDER_PROGRESS = "Under progress".freeze
    CANCELED = "Canceled".freeze
    DONE = "Done".freeze

    OPTIONS = [
      Status::NEW,
      Status::UNDER_PROGRESS,
      Status::CANCELED,
      Status::DONE,
    ].freeze
  end

  module Category
    CROCHET = "Crochet".freeze
    KNITTING = "Knitting".freeze
    WEAVING = "Weaving".freeze
    EMBROIDERY = "Embroidery".freeze

    OPTIONS = [
      Category::CROCHET,
      Category::KNITTING,
      Category::WEAVING,
      Category::EMBROIDERY,
    ].freeze
  end

  belongs_to :user
  has_many :posts
  has_many :tools

  include Commentable

  validates :title,
            presence: true,
            length: { maximum: 50 }

  validates :pattern_url,
            url: true,
            allow_blank: true

  validates :status,
            inclusion: { in: Status::OPTIONS }

  validates :category,
            inclusion: { in: Category::OPTIONS },
            allow_blank: true

  scope :undone, -> { where.not(status: Status::DONE) }

  def update_status(new_status)
    if new_status != status
      if update(status: new_status)
        return generate_post("status", new_status)
      end
    end
    false
  end

  def update_category(new_category)
    if new_category != category
      if update(category: new_category)
        return generate_post("category", new_category)
      end

      false
    end
  end

  private

  def generate_post(field_name, updated_value)
    return if new_record?

    post = posts.create(
      auto_generated: true,
      text: "Updated the #{field_name}",
      user: user,
      updated_value: updated_value,
      updated_field: "category",
    )

    !post.new_record?
  end
end
