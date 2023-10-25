require 'rails_helper'

RSpec.describe Business, type: :model do
  describe "defaults" do
    it 'defaults listing to an empty hash' do
      subject = FactoryBot.create(:business)
      puts subject
      expect(subject.listing).to eq({})
    end
  end
  describe "validations" do
    it 'requires a unique uuid' do
      existing = FactoryBot.create(:business)
      subject = FactoryBot.create(:business)
      subject.uuid = existing.uuid
      subject.save
      expect(subject.errors[:uuid][0]).to match(/taken/)
    end
    it 'requires a listing value' do
      subject = FactoryBot.create(:business)
      subject.listing = nil
      subject.save
      expect(subject.errors[:listing][0]).to match(/blank/)
    end
  end
end
