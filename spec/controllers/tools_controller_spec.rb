require "rails_helper"

RSpec.describe ToolsController, type: :request do
  let!(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    FactoryBot.create_list(:tool_with_image, 3, user: user)
  end

  describe "#index" do
    before do
      get "/tools"
    end

    it "renders tools index view" do
      expect(response).to render_template(:index)
    end

    it "gets all user's tools" do
      user_tools = user.tools.order(created_at: "desc").to_a
      expect(assigns(:tools)).to eql user_tools
    end
  end

  describe "#new" do
    before do
      get "/tools/new"
    end

    it "renders tools index view" do
      expect(response).to render_template(:new)
    end

    it "assigns a new instance of tool to @tool" do
      expect(assigns(:tool)).to be_a_new(Tool)
    end
  end

  describe "#create" do
    let!(:image) do
      ActiveStorage::Blob.create_after_upload!(
        io: File.open(fixture_path + "/files/cat-1.jpg"),
        filename: "cat-1.jpg",
        content_type: "image/jpeg" # Or figure it out from `name` if you have non-JPEGs
      ).signed_id
    end
    let!(:params) { FactoryBot.attributes_for(:tool).merge(images: [image]) }

    it "creates new tool" do
      expect { post "/tools", params: { tool: params } }.to(
        change(Tool, :count).by(1),
      )
    end
  end
end
