class Project < ApplicationRecord
  module Status
    NEW = "new".freeze
    UNDER_PROGRESS = "under progress".freeze
    CANCELED = "canceled".freeze
    DONE = "done".freeze

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

    OPTIONS = [
      Category::CROCHET,
      Category::KNITTING,
      Category::WEAVING,
    ].freeze
  end

  belongs_to :user
  has_many :posts
  has_many :tools

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
end
