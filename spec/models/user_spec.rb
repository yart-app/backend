require "rails_helper"

RSpec.describe User, type: :model do
  describe "validation" do
    it "validates the presence of username" do
      is_expected.to validate_presence_of(:username)
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
    let!(:current_user) { FactoryBot.create(:user) }
    let!(:target_user) { FactoryBot.create(:user) }

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
end
