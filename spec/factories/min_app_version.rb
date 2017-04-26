FactoryGirl.define do
  factory :min_app_version, class: Ctws::MinAppVersion do
    codename { Faker::Lorem.words(3) }
    description { Faker::Lorem.sentences(1) }
    platform {['ios', 'android', 'other'].sample}
    min_version {"#{Faker::Number.digit}.#{Faker::Number.digit}.#{Faker::Number.digit}"}
    store_uri { Faker::Internet.url }
  end
end