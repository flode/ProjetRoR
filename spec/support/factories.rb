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

  factory :author do
    sequence(:forename) { |n| "Author #{n}" }
    sequence(:surname) { |n| "AuthorName #{n}" }

    user
  end

  factory :publication do
    sequence(:name) { |n| "Author #{n}" }
    sequence(:date) { |n| "199#{n}" }
    authors {[FactoryGirl.create(:author)]}
#    association :user_id, factory: :user
  end
end

