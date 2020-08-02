require "rails_helper"

RSpec.describe CommentsController, type: :request do
  let!(:user) do
    FactoryBot.create(:user)
  end

  before do
    sign_in user
  end

  describe "#index" do
    describe "when requesting post's comments" do
      let!(:post) { FactoryBot.create(:post) }
      let!(:comments) do
        FactoryBot.create_list(:comment_on_post, 7, post: post)
      end

      before do
        get "/comments", params: params
      end

      context "when not sending page number param" do
        let(:params) { { post_id: post.id } }

        it "retrieves only 5 comments" do
          expect(json["comments"].count).to eq(5)
        end

        it "retrieves the first comments" do
          json["comments"].each_index do |i|
            expect(json["comments"][i]["text"]).to eq(comments[i][:text])
          end
        end
      end

      context "when sending page number" do
        let(:params) { { post_id: post.id, page: 2 } }

        it "retrieves only 2 comments" do
          expect(json["comments"].count).to eq(2)
        end
      end
    end

    context "when requesting comments without post id nor project id" do
      let(:params) { { page: 2 } }

      before do
        get "/comments", params: params
      end

      it "responds with error status" do
        expect(response.status).to eq(422)
      end

      it "responds with error message" do
        message = "Please send either post or project id"
        expect(json["errors"]).to include(message)
      end
    end

    context "when requesting project's comments" do
      let!(:project) { FactoryBot.create(:project) }
      let!(:params) { { project_id: project.id } }

      before do
        FactoryBot.create_list(:comment_on_project, 4, project: project)
        get "/comments", params: params
      end

      it "retrieves all 4 comments" do
        expect(json["comments"].count).to eq(4)
      end
    end
  end

  describe "#create" do

    let(:params) do
      {
        comment: {
          post_id: comment.post_id,
          project_id: comment.project_id,
          text: comment.text
        }
      }
    end

    context "when sending a post id" do
      let(:comment) { FactoryBot.build(:comment_on_post) }

      it "creates a comment on a post" do
        expect { post "/comments", params: params }.to(
          change(comment.post.comments, :count).by(1),
        )
      end
    end

    context "when sending a project id" do
      let(:comment) { FactoryBot.build(:comment_on_project) }

      it "creates a comment on a project" do
        expect { post "/comments", params: params }.to(
          change(comment.project.comments, :count).by(1),
        )
      end
    end
  end
end
