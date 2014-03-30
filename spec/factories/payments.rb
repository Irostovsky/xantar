FactoryGirl.define do
  factory :payment do
    first_name 'John'
    last_name 'Doe'
    card_type 'Visa'
    card_number '4676949199749717'
    card_verification 123
    card_expires_on {Time.zone.now + 1.month}
    post

    factory :success_payment do
      card_number '4111111111111111'
    end

    factory :failure_payment do
      card_number '4222222222222'
    end
  end
end