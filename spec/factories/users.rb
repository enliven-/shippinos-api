FactoryGirl.define do
  factory :user do
    email                 { Faker::Internet.email }
    password              'password'
    password_confirmation 'password'
    role                  :user
  end

  factory :manager, class: User do
    email                 { Faker::Internet.email }
    password              'password'
    password_confirmation 'password'
    role                  :manager
  end

  factory :admin, class: User do
    email                 { Faker::Internet.email }
    password              'password'
    password_confirmation 'password'
    role                  :admin
  end

  factory :invalid_user, class: User do
    email                 'someone@example'
    password              'password'
    password_confirmation 'password'
  end
end
