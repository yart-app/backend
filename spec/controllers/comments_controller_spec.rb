require "rails_helper"

RSpec.describe CommentsController, type: :request do
  let!(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe "#create" do

    let(:params) do
      {
        comment: {
          post_id: comment.post_id,
          project_id: comment.project_id,
          user_id: comment.user_id,
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
