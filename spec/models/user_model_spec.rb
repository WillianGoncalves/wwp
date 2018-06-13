require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many :members }
  it { is_expected.to have_many :join_requests }
  it { is_expected.to have_many :comments }
  it { is_expected.to belong_to :last_group }
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }

  describe 'is_admin_of?' do
    let!(:user) { Fabricate :user }
    let!(:group) { Fabricate :group, admin: user }
    let!(:another_group) { Fabricate :group }
    
    it 'check if user is the group admin' do
      expect(user.is_admin_of?(group)).to eq true
      expect(user.is_admin_of?(another_group)).to eq false
    end
  end

  describe 'is_member_of?' do
    let!(:user) { Fabricate :user }
    let!(:group) { Fabricate :group, member: user }
    let!(:another_group) { Fabricate :group }
    
    it 'check if user is a group member' do
      expect(user.is_member_of?(group)).to eq true
      expect(user.is_member_of?(another_group)).to eq false
    end
  end
end
