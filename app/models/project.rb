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

  def update_by_field(key:, value:)
    result = { status: false }
    return result if value == self[key]

    if update(key => value)
      result = generate_post(key, value)
    end

    result
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

    { status: !post.new_record?, generated_post: post }
  end
end
