require 'rails_helper'

RSpec.describe Account, type: :model do
  describe "validations" do
    it 'requires a unique name' do
      original = FactoryBot.create(:account)
      u = FactoryBot.create(:account)
      u.name = original.name
      u.save
      expect(u.errors[:name][0]).to match(/taken/)
    end
    it 'requires a unique token' do
      original = FactoryBot.create(:account)
      u = FactoryBot.create(:account)
      u.token = original.token
      u.save
      expect(u.errors[:token][0]).to match(/taken/)
    end
  end
end
