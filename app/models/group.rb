# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ApplicationRecord
  has_many :join_requests, inverse_of: :group, dependent: :destroy
  has_many :presentations, inverse_of: :group, dependent: :destroy
  has_many :songs, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :tags, -> { order(:name) }
  validates :name, presence: true

  mount_uploader :image, GroupImageUploader

  def join_requests_to_be_accepted
    join_requests.where(accepted: nil)
  end

  def next_presentations
    self.presentations.where('DATE(date_time) > ?', DateTime.now).order(:date_time)
  end

  def previous_presentations
    self.presentations.where('DATE(date_time) < ?', DateTime.now).order(date_time: :desc)
  end
end
