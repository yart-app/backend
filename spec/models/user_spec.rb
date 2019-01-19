require "rails_helper"

RSpec.describe User, type: :model do
  let!(:current_user) { FactoryBot.create(:user) }
  let!(:target_user) { FactoryBot.create(:user) }

  describe "validation" do
    it "validates the presence of username" do
      expect(User.new).to validate_presence_of(:username)
    end

    it "validates the uniquness of username" do
      FactoryBot.create(:user, username: "duplicate")
      user = FactoryBot.build(:user, username: "duplicate")
      expect(user).not_to be_valid
    end

    context "when username is invalid" do
      it "doesn't pass usernames longer than 16 chars" do
        user = FactoryBot.build(:user, username: "john__smith__123456789")
        expect(user).not_to be_valid
      end

      it "doesn't pass usernames shorter than 3 chars" do
        user = FactoryBot.build(:user, username: "jo")
        expect(user).not_to be_valid
      end

      it "doesn't pass usernames with dash" do
        user = FactoryBot.build(:user, username: "john-1")
        expect(user).not_to be_valid
      end

      it "doesn't pass usernames with &" do
        user = FactoryBot.build(:user, username: "john&1")
        expect(user).not_to be_valid
      end

      it "doesn't pass usernames with *" do
        user = FactoryBot.build(:user, username: "john*1")
        expect(user).not_to be_valid
      end
    end
  end

  describe "#follow" do
    before do
      current_user.follow(target_user)
      current_user.reload
    end

    it "append the target user to current user's friends" do
      expect(current_user.followees).to include(target_user)
    end

    it "return false if target user is already followed by current user" do
      expect(current_user.follow(target_user)).to eq(false)
    end
  end

  describe "#unfollow" do
    it "returns false if target user is not followed by current user" do
      expect(current_user.unfollow(target_user)).to eq(false)
    end

    it "returns true if target user is followed by current user" do
      current_user.follow(target_user)
      expect(current_user.unfollow(target_user)).to eq(true)
    end
  end

  describe "#follow?" do
    it "returns true if the current user doesn't follow the target user" do
      expect(current_user.follow?(target_user)).to eq(false)
    end

    it "returns true if the current user follows the target user" do
      current_user.follow(target_user)
      current_user.reload
      expect(current_user.follow?(target_user)).to eq(true)
    end
  end

  describe "#followed_by?" do
    it "returns true if the target user isn't followed by the current user" do
      expect(target_user.followed_by?(current_user)).to eq(false)
    end

    it "returns true if the current user follows the target user" do
      current_user.follow(target_user)
      current_user.reload
      expect(target_user.followed_by?(current_user)).to eq(true)
    end
  end

  describe "#ordered_posts_with_friends_posts" do
    before do
      current_user.follow(target_user)
    end

    let(:current_user_posts) do
      FactoryBot.create_list(:post, 2, user: current_user)
    end

    let(:target_user_posts) do
      FactoryBot.create_list(:post, 3, user: target_user)
    end

    let(:posts) do
      ids = [current_user.id, target_user.id]
      Post.where(user_id: ids).order(created_at: "desc").to_a
    end

    it "returns current_user's and target_user's posts" do
      expect(current_user.ordered_posts_with_friends_posts.to_a).to eq(posts)
    end
  end
end
