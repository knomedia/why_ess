require 'rails_helper'

RSpec.describe Yelp::Client do

  describe "listing_url" do
    it 'builds correct yelp url for an id' do
      subject = Yelp::Client.new("some-id")
      expected = "https://api.yelp.com/v3/businesses/some-id"
      expect(subject.listing_url).to eq expected
    end
  end
  describe "request_headers" do
    it 'requests json' do
      subject = Yelp::Client.new('some-id')
      expect(subject.request_headers["Accept"]).to eq "application/json"
    end
    it 'includes Bearer token in Authorization' do
      subject = Yelp::Client.new('some-id')
      expect(subject.request_headers["Authorization"]).to match(/Bearer/)
    end
    
  end
end
