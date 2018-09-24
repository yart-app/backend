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
      comment = FactoryBot.build(:comment)
      expect(comment).not_to be_valid
    end

    it "validate a comment without a project" do
      comment = FactoryBot.build(:comment_on_post)
      expect(comment).to be_valid
    end

    it "validate a comment without a post" do
      comment = FactoryBot.build(:comment_on_project)
      expect(comment).to be_valid
    end
  end
end
