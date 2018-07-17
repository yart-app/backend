require "rails_helper"

RSpec.describe Project, type: :model do
  it "validates the presence of title" do
    is_expected.to validate_presence_of(:title)
  end

  it "validates the length of title" do
    is_expected.to validate_length_of(:title).is_at_most(50)
  end

  it "validates pattern url format" do
    project = FactoryBot.build(:project, pattern_url: "invalid url")
    expect(project).not_to be_valid
  end

  it "validates project's status" do
    project = FactoryBot.build(:project, status: "invalid status")
    expect(project).not_to be_valid
  end

  it "validates project's category" do
    project = FactoryBot.build(:project, category: "invalid category")
    expect(project).not_to be_valid
  end

  it "allows project's category to be blank" do
    project = FactoryBot.build(:project, category: "")
    expect(project).to be_valid
  end
end
