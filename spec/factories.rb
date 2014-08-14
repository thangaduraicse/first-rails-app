#FactoryGirl.define do
#  factory :user do
#    name     "Paranthaman"
#    email    "paranthamancse@gmail.com"
#    password "HiVJbkb3!"
#    password_confirmation "HiVJbkb3!"
#  end
#end
FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  	factory :admin do
  		admin true
  	end
  end
end