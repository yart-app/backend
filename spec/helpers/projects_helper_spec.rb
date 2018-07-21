require "rails_helper"

RSpec.describe ProjectsHelper, type: :helper do
  def check_status(status, css_class)
    expect(helper.status_class(status)).to eq(css_class)
  end

  describe "#status_class" do
    it "returns the proper css class for New status" do
      check_status(Project::Status::NEW, "is-dark")
    end

    it "returns the proper css class for Under Prgoress status" do
      check_status(Project::Status::UNDER_PROGRESS, "is-warning")
    end

    it "returns the proper css class for Canceled status" do
      check_status(Project::Status::CANCELED, "is-danger")
    end

    it "returns the proper css class for Done status" do
      check_status(Project::Status::DONE, "is-success")
    end
  end
end
