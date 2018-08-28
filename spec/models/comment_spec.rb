require "rails_helper"

RSpec.describe Comment, type: :model do
  it "validates the presence of text" do
    is_expected.to validate_presence_of(:text)
  end

  it "validates the length of text" do
    is_expected.to validate_length_of(:text).is_at_most(500)
  end

  describe "#belongs_to_post_or_project" do
    it "doesn't validate a comment without a project or a post" do
      comment = FactoryBot.build(:comment, project: nil, post: nil)
      expect(comment).not_to be_valid
    end

    it "validate a comment without a project" do
      comment = FactoryBot.build(:comment, post: nil)
      expect(comment).to be_valid
    end

    it "validate a comment without a post" do
      comment = FactoryBot.build(:comment, project: nil)
      expect(comment).to be_valid
    end
  end
end
