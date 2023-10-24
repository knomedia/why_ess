FactoryBot.define do
  factory(:account) do
    sequence(:name) {|n| "Name#{n}"}
    sequence(:token) {|n| "token#{n}"}
  end
end
