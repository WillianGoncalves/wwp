# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#
# Indexes
#
#  index_groups_on_deleted_at  (deleted_at)
#

class Group < ApplicationRecord
  acts_as_paranoid

  has_many :join_requests, inverse_of: :group, dependent: :destroy
  has_many :presentations, inverse_of: :group, dependent: :destroy
  has_many :songs, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :tags, -> { order(:name) }, dependent: :destroy
  validates :name, :members, presence: true

  mount_uploader :image, GroupImageUploader

  def add_admin(user)
    members.build(user: user, admin: true)
  end

  def add_member!(user)
    members.create(user: user, admin: false)
  end

  def join_requests_to_be_accepted
    join_requests.where(accepted: nil)
  end

  def next_presentation
    presentations.where('DATE(date_time) > ?', DateTime.now).order(:date_time).first
  end
end
