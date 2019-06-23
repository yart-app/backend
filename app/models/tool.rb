class Tool < ApplicationRecord
  ## Validation
  validates :name,
            presence: true,
            length: { maximum: 20 }

  validates :description,
            length: { maximum: 120 }

  validates :images,
            array_length: { maximum: 10 }

  validates :url, url: true, allow_blank: true

  belongs_to :user
  has_many_attached :images

  def self.update_for_project(project_id:, name:, value:, key:, user:)
    tool = Tool.find_or_initialize_by(
      project_id: project_id,
      name: name,
      user: user,
    )

    tool.update(key => value)
    tool
  end
end
