FactoryBot.define do
  factory :weapon do
    name { FFaker::Lorem.word }
    description { FFaker::Lorem.word }
    power_base { FFaker::Random.rand(1000..5000) }
    power_step { FFaker::Random.rand(100..500) }
    level { FFaker::Random.rand(1..99) }
  end
end
