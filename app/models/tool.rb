class Tool < ApplicationRecord
  ## Validation
  validates :name,
            presence: true
end
