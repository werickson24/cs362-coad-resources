FactoryBot.define do
  factory :user do
    email {generate(:email)}
    password {"password"}

    before(:create) { |user| user.skip_confirmation! }


    # trait :organization_approved do
    #   role {:organization}
    #   organization_id {create(:organization, :approved).id}
    #
    # trait :organization_unapproved do
    #   role {:organization}
    #   organization_id {create(:organization).id}

    trait :admin do
      role{:admin}
    end
  end

  factory :organization do
    email {generate(:email)}
    name {generate(:name)}
    phone {'+41 44 111 22 33'}
    status {:submitted}
    primary_name {generate(:name)}
    secondary_name {generate(:name)}
    secondary_phone {'+41 44 111 22 33'}
  end

  factory :region do
    name {generate(:name)}

    trait :unspecified do
      name {'Unspecified'}
    end

    factory :unspecified_region, traits: [:unspecified]
  end


  factory :resource_category do
    name {generate(:name)}
  end

  factory :ticket do
    name {generate(:name)}
    phone {'+41 44 111 22 33'}
    organization
    region
    resource_category
  end


  # -------- Sequences -----------

  sequence :name do |n|
    "name#{n}"
  end

  sequence :email do |n|
    "email#{n}@example.com"
  end

end
