require 'rails_helper'

# frozen_string_literal: true
RSpec.describe Comment, type: :model do
  it { is_expected.to belong_to :commenter }
  it { is_expected.to have_db_column :user_id }
  it { is_expected.to belong_to :target }
  it { is_expected.to validate_presence_of :body }
end
