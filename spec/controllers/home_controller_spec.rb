require "rails_helper"

RSpec.describe HomeController, type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:project) { FactoryBot.create(:project, user: user) }

  before do
    FactoryBot.create_list(:post, 3, user: user, project: project)
    sign_in user
  end

  describe "#index" do
    before do
      get "/"
    end

    it "renders home index view" do
      expect(response).to render_template(:index)
    end

    it "gets all user's posts" do
      user_posts = user.ordered_posts(include_auto_generated: false)
      expect(assigns(:posts)).to eql user_posts.to_a
    end

    it "gets all user's projects" do
      user_projects = user.ordered_projects
      expect(assigns(:projects)).to eql user_projects.to_a
    end
  end
end
