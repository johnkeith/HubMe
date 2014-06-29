FactoryGirl.define do
  factory :user do
    sequence(:uid) { |n| "123456#{n}" }
    provider 'github'
    username 'johnkeith'
    avatar_url 'github.com'
    email 'johnkeith@outlook.com'
  end
end
