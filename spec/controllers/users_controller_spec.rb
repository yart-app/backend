require "rails_helper"

RSpec.describe UsersController, type: :request do
  let!(:current_user) { FactoryBot.create(:user) }
  let!(:target_user) { FactoryBot.create(:user) }

  before do
    sign_in current_user
    FactoryBot.create_list(:post, 3, user: target_user)
  end

  describe "#show" do
    before do
      get "/profile/#{target_user.id}"
    end

    it "renders profile's view" do
      expect(response).to render_template(:show)
    end

    it "assigns the user's posts to @posts" do
      expect(assigns(:posts)).to eq(target_user.posts)
    end
  end

  describe "#toggle_follow" do
    context "when toggle current_user.follow returns true" do
      before do
        post "/users/toggle_follow", params: { id: target_user.id }
      end

      it "responses with ok status" do
        expect(response.status).to eq(200)
      end

      it "responses with success = true" do
        expect(json["success"]).to eq(true)
      end
    end
  end

  context "when toggle current_user.follow returns false" do
    before do
      allow(current_user).to receive(:toggle_follow).and_return(false)
      post "/users/toggle_follow", params: { id: target_user.id }
    end

    it "responses with ok status" do
      expect(response.status).to eq(400)
    end

    it "responses with success = true" do
      expect(json["success"]).to eq(false)
    end
  end
end
