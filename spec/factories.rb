FactoryBot.define do
  factory :business do
    sequence(:uuid) {|n| "name-#{n}"}
    sequence(:listing) {|n| {} }
    expires_at { 24.hours.from_now }
  end

  factory(:account) do
    sequence(:name) {|n| "Name#{n}"}
    sequence(:token) {|n| "token#{n}"}
  end
end
