require "rails_helper"

RSpec.describe UsersController, type: :request do
  let!(:current_user) { FactoryBot.create(:user) }
  let!(:user) { FactoryBot.create(:user) }

  before do
    sign_in current_user
    FactoryBot.create_list(:post, 3, user: user)
  end

  describe "#show" do
    before do
      get "/profile/#{user.id}"
    end

    it "renders profile's view" do
      expect(response).to render_template(:show)
    end

    it "assigns the user's posts to @posts" do
      expect(assigns(:posts)).to eq(user.posts)
    end
  end

  describe "#follow" do
    context "when the current user already follows the target user" do
    end

    context "when the current user doesn't follow the target user" do
    end
  end

end
