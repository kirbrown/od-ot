FactoryBot.define do
  factory :user do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    password_confirmation { password }
  end

  factory :todo_list do
    title { FFaker::Lorem.phrase }
    user
  end

  factory :todo_item do
    content { FFaker::Lorem.sentence }
  end
end
