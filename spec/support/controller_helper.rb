def login_for_controller!(controller, account=nil)
  account = account || FactoryBot.create(:account)
  allow(controller).to receive(:current_account){ account }
  account
end
