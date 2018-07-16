require "rails_helper"

RSpec.describe Tool, type: :model do
  context "validation" do
    it "validates the presence of name" do
      is_expected.to validate_presence_of(:name)
    end

    it "validates the length of name" do
      is_expected.to validate_length_of(:name).is_at_most(20)
    end

    it "validate url format" do
      tool = FactoryBot.build(:tool_with_image, url: "test")
      expect(tool).to_not be_valid
    end

    it "validates that there is at least one image" do
      tool = FactoryBot.build(:tool)
      expect(tool).to_not be_valid
    end
  end
end
