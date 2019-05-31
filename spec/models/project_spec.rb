require "rails_helper"

RSpec.describe Project, type: :model do
  it "validates the presence of title" do
    expect(Project.new).to validate_presence_of(:title)
  end

  it "validates the length of title" do
    expect(Project.new).to validate_length_of(:title).is_at_most(50)
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

  describe "#update_status" do
    let!(:project) { FactoryBot.create(:project, status: Project::Status::NEW) }

    it "updates status if it's valid and returns true" do
      expect(project.update_status(Project::Status::DONE)).to eq(true)
    end
  end

  describe "#update_category" do
    let!(:project) do
      FactoryBot.create(:project, category: Project::Category::CROCHET)
    end

    it "updates category if it's valid and returns true" do
      expect(project.update_category(Project::Category::WEAVING)).to eq(true)
    end
  end

end
