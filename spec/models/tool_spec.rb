require 'rails_helper'

RSpec.describe Tool, type: :model do
  context 'validation' do
    it 'validates the presence of name' do
      is_expected.to validate_presence_of(:name)
    end

    it 'validates the presence of images' do
      is_expected.to validate_presence_of(:images)
    it 'validates the length of name' do
      is_expected.to validate_length_of(:name).is_at_most(20)
    end

    end

    it 'validates that there is at least one image' do
      tool = Tool.new(name: 'hook', images: [])
      expect(tool).to_not be_valid
    end
  end
end
