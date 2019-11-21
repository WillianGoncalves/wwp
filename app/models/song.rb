# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  title      :string
#  author     :string
#  tone       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :integer          not null
#
# Indexes
#
#  index_songs_on_group_id  (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#

class Song < ApplicationRecord
  belongs_to :group
  has_and_belongs_to_many :tags
  has_many :presentation_songs
  has_many :presentations, through: :presentation_songs
  has_many :comments, -> { order(:created_at) }, as: :target, dependent: :destroy
  validates :title, :group, presence: true
  validates :tone, format: { with: /\A[A-G](b|#)?m?\z/ }

  def last_presentation
    presentations.where('DATE(date_time) < ?', DateTime.now).order(date_time: :desc).first
  end

  def next_presentation
    presentations.where('DATE(date_time) > ?', DateTime.now).order(:date_time).first
  end

  def times_played
    presentations.where('DATE(date_time) < ?', DateTime.now).order(date_time: :desc).size
  end
end
