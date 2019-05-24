FactoryBot.define do
  factory :ctws_user, class: User do
    email {"email@test.com"}
    password {"ruby123"}
    password_confirmation {"ruby123"}
  end
end
