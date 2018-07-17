require "rails_helper"

RSpec.describe ProjectsController, type: :request do
  let!(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    FactoryBot.create_list(:project, 3, user: user)
  end

  describe "#index" do
    before do
      get "/projects"
    end

    it "renders projects index view" do
      expect(response).to render_template(:index)
    end

    it "assigns a new instance of project to @project" do
      expect(assigns(:project)).to be_a_new(Project)
    end

    it "gets all user's projects" do
      user_projects = user.projects.order(created_at: "desc").to_a
      expect(assigns(:projects)).to eql user_projects
    end
  end
end
