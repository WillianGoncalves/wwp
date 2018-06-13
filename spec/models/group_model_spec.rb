require 'rails_helper'

RSpec.describe Group, type: :model do
  it { is_expected.to have_many :members }
  it { is_expected.to have_many :songs }
  it { is_expected.to have_many :presentations }
  it { is_expected.to have_many :join_requests }
  it { is_expected.to have_many :tags }
  it { is_expected.to validate_presence_of :name }

  describe 'add_admin' do
    let(:group) { Group.new }
    let!(:user) { Fabricate :user }

    before { group.add_admin(user) }

    it 'adds admin to group' do
      expect(group.members.size).to eq 1
      expect(group.members.first.admin).to eq true
    end
  end

  describe 'add_member!' do
    let!(:group) { Fabricate :group }
    let!(:user) { Fabricate :user }

    before { group.add_member!(user) }

    it 'adds the user to group' do
      expect(group.members.count).to eq 2
      expect(user.groups.count).to eq 1
    end
  end

  describe 'join_requests_to_be_accepted' do
    let!(:group) { Fabricate :group }
    let!(:pending_join_request) { Fabricate :pending_join_request, group: group }
    let!(:accepted_join_request) { Fabricate :accepted_join_request, group: group }

    it 'returns join requests to be accepted' do
      expect(group.join_requests_to_be_accepted).to match_array [ pending_join_request ]
    end
  end
end
