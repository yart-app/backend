class Tool < ApplicationRecord
  ## Validation
  validates :name,
            presence: true,
            length: { maximum: 20 }

  validates :images,
            presence: true,
            array_length: { minimum: 1, maximum: 10 }

  belongs_to :user
  has_many_attached :images
end