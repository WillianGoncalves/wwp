require 'rails_helper'

RSpec.describe Member, type: :model do
  before(:all) do
    Fabricate :group
    Fabricate :user
  end
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :group }
  it { is_expected.to validate_uniqueness_of(:user).scoped_to(:group_id) }
end
