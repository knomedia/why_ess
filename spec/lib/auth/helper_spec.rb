require 'rails_helper'

RSpec.describe Auth::Helper do
  describe '#self.bearer' do
    it 'plucks Bearer token' do
      headers = {
        "Authorization" => 'Bearer some-token'
      }
      req = double('Request', headers: headers)
      expect(Auth::Helper.bearer(req)).to eq('some-token')
    end
    it 'ignores case on Bearer' do
      headers = {
        "Authorization" => 'bearer some-token'
      }
      req = double('Request', headers: headers)
      expect(Auth::Helper.bearer(req)).to eq('some-token')
    end
    it 'returns nil for malformed headers' do
      headers = {
        "Authorization" => 'bear some-token'
      }
      req = double('Request', headers: headers)
      expect(Auth::Helper.bearer(req)).to eq(nil)
    end
    it 'returns nil for missing Authorization key' do
      headers = {}
      req = double('Request', headers: headers)
      expect(Auth::Helper.bearer(req)).to eq(nil)
    end
  end
  describe "current_account" do
    it 'returns account for a proper token' do
      account = FactoryBot.create(:account)
      res = Auth::Helper.current_account(nil, account.token)
      expect(res.id).to eq account.id
    end
    it 'returns nil for a bad token' do
      res = Auth::Helper.current_account(nil, 'nope-nope-nope')
      expect(res).to be nil
    end
  end
end
