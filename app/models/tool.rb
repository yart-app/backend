class Tool < ApplicationRecord
  ## Validation
  validates :name,
            presence: true,
            length: { maximum: 20 }

  validates :images,
            array_length: { minimum: 1, maximum: 10 }

  validates :url, url: true, allow_blank: true

  belongs_to :user
  has_many_attached :images
end
