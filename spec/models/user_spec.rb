require "rails_helper"

# RSpec.describe User, type: :model do
# end
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
end
