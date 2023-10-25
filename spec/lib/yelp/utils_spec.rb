require 'rails_helper'

RSpec.describe Yelp::Utils do
  describe 'get_business' do
    context 'Yelp API' do
      it 'skips API if business is found and not expired' do
        listing = {"foo" => "bar"}
        biz = FactoryBot.create(:business, listing: listing)
        subject = Yelp::Utils.new(biz.uuid)
        expect(Yelp::Client).to_not receive(:new)
        expect(subject.get_business.id).to eq biz.id
        expect(subject.get_business.listing).to eq listing
      end

      it 'hits API and adds biz if biz is not found' do
        client = double('Yelp::Client')
        subject = Yelp::Utils.new('new-uuid-not-in-data')
        expect(Yelp::Client).to receive(:new) { client }
        expect(client).to receive(:listing) { [200, {"new" => "listing"}] }
        biz = nil
        expect {
          biz = subject.get_business
        }.to change { Business.count }.by 1
        expect(biz.uuid).to eq('new-uuid-not-in-data')
      end

      it 'hits API if listing is expired and updates expiry and listing' do
        client = double('Yelp::Client')
        existing = FactoryBot.create(:business, expires_at: 3.days.ago)
        subject = Yelp::Utils.new(existing.uuid)
        expect(Yelp::Client).to receive(:new) { client }
        expect(client).to receive(:listing) { [200, {"new" => "listing"}] }
        biz = nil
        expect {
          biz = subject.get_business
        }.to change { Business.count }.by 0
        expect(biz.listing).to eq({"new" => "listing"})
        expect(biz.expires_at).to be >= 23.hours.from_now
        expect(subject.status).to eq 200
      end
    end
  end
end
