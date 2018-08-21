class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tools
  has_many :projects
  has_many :posts

  has_many :follower_follows, foreign_key: :followee_id, class_name: "Follow"
  has_many :followers, through: :follower_follows, source: :follower

  has_many :followee_follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followees, through: :followee_follows, source: :followee

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

  def ordered_posts_with_friends_posts
    ids = [id] + followees.ids
    Post.where(user_id: ids, auto_generated: false).order(created_at: "desc")
  end

  def follow(target_user)
    return false if follow?(target_user)
    follow = Follow.create(follower: self, followee: target_user)
    follow.persisted?
  end

  def unfollow(target_user)
    return false unless follow?(target_user)
    follow = Follow.find_by(follower: self, followee: target_user).destroy
    follow.destroyed?
  end

  def toggle_follow(target_user)
    if follow?(target_user)
      unfollow(target_user)
    else
      follow(target_user)
    end
  end

  def follow?(user)
    followees.exists?(user.id)
  end

  def followed_by?(user)
    followers.exists?(user.id)
  end
end
