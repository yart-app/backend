require 'rails_helper'

RSpec.describe Tool, type: :model do
  context 'validation' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
