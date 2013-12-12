# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :discount_code, class: TrainingApp::DiscountCode do
    code "yehudasentme"
    price 100
    course
  end
end
