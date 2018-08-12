class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tools
  has_many :projects
  has_many :posts


  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: Regexp.new(/\A[a-z0-9_]{3,20}\z/) }

  def ordered_projects
    projects.order(created_at: "desc")
  end

  def ordered_posts(include_auto_generated: true)
    result = posts.order(created_at: "desc")
    return result if include_auto_generated
    result.where(auto_generated: false)
  end
end
