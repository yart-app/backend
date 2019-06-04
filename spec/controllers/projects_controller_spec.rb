require "rails_helper"

RSpec.describe ProjectsController, type: :request do
  let!(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    FactoryBot.create_list(:project, 3, user: user)
  end

  describe "#new" do
    before do
      get "/projects/new"
    end

    it "renders projects new view" do
      expect(response).to render_template(:new)
    end

    it "assigns a new instance of project to @project" do
      expect(assigns(:project)).to be_a_new(Project)
    end

    it "assigns the categories to @categories" do
      expect(assigns(:categories)).to eq(Project::Category::OPTIONS)
    end

    it "assigns the statuses to @statuses" do
      expect(assigns(:statuses)).to eq(Project::Status::OPTIONS)
    end

    it "assigns the user tools to @tools" do
      expect(assigns(:tools)).to eq(user.tools)
    end
  end

  describe "#create" do
    it "creates project" do
      params = { project: FactoryBot.attributes_for(:project) }
      expect { post "/projects", params: params }.to(
        change(Project, :count).by(1),
      )
    end

    it "redirects to the project's url" do
      project = FactoryBot.attributes_for(:project)
      post "/projects", params: { project: project }
      expect(response).to redirect_to project_url(id: Project.last.id)
    end
  end

  describe "#show" do
    let!(:project) { user.projects[0] }

    before do
      get "/projects/#{project.id}"
    end

    it "renders a specific project show view" do
      expect(response).to render_template(:show)
    end

    it "assigns the requested project to @project" do
      expect(assigns(:project)).to eq(project)
    end
  end
end
