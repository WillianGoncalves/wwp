# frozen_string_literal: true
RSpec.describe Song, type: :model do
  it { is_expected.to have_and_belong_to_many :tags }
  it { is_expected.to have_and_belong_to_many :presentations }
  it { is_expected.to have_many :comments }
  it { is_expected.to belong_to :group }
  it { is_expected.to validate_presence_of :title }

  describe 'tone regex' do
    let!(:regex) { Song.validators_on(:tone).first.options[:with] }

    context 'valid tones' do
      it { expect("C").to match regex }
      it { expect("C#").to match regex }
      it { expect("Bb").to match regex }
      it { expect("Cm").to match regex }
      it { expect("C#m").to match regex }
      it { expect("Bbm").to match regex }
    end

    context 'invalid tones' do
      it { expect("b").not_to match regex }
      it { expect("#").not_to match regex }
      it { expect("bm").not_to match regex }
      it { expect("C##").not_to match regex }
      it { expect("Cbb").not_to match regex }
      it { expect("H").not_to match regex }
    end
  end
end
