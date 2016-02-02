FactoryGirl.define do
  factory :ship_request do
    from_city             { City.all.sample }
    to_city               { City.all.sample }
    from_date             { Faker::Date.between(2.days.ago, 10.days.from_now) }
    until_date            { Faker::Date.between(from_date,  20.days.from_now) }
    size                  :small
    user                  { User.all.sample }
    reward                { (50..300).step(50).to_a.sample }
    message               "some message"
  end
end
