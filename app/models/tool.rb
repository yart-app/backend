class Tool < ApplicationRecord
  ## Validation
  validates :name,
            presence: true

  validates :images,
            presence: true,
            array_length: { minimum: 1, maximum: 10 }
end