require 'rails_helper'

RSpec.describe Api::V1::BusinessesController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body).deep_symbolize_keys }

  describe 'show' do
    before :each do
      @business = FactoryBot.create(:business)
      @params = {id: @business.uuid}
    end
    context 'without authd Account' do
      it 'returns unauthorized' do
        get :show, params: @params
        expect(response.status).to eq(401)
      end
    end
    context 'with authd Account' do
      before :each do
        login_for_controller!(controller)
      end
      it 'returns business and uses Yelp::Utils status' do
        yd = double('Yelp::Utils')
        expect(yd).to receive(:get_business) { @business }
        expect(yd).to receive(:status) { 201 }
        allow(Yelp::Utils).to receive(:new).with(@business.uuid) { yd }
        get :show, params: @params
        expect(response.status).to eq(201)
        expect(json[:business][:id]).to eq(@business.id)
      end
    end
  end
end
