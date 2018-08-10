class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tools
  has_many :projects
  has_many :posts

  def ordered_projects
    projects.order(created_at: "desc")
  end
end
