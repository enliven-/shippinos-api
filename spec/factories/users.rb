FactoryGirl.define do
  factory :user do
    email                 { Faker::Internet.email }
    password              'password'
    password_confirmation 'password'
  end

  factory :invalid_user, class: User do
    email                 'someone@example'
    password              'password'
    password_confirmation 'password'
  end
end
