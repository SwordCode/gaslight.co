require 'spec_helper'

feature "Purchasing an online course", js: true do
  # increase the capybara wait time to account for stripe
  before do
    @origional_wait_time = Capybara.default_wait_time
    Capybara.default_wait_time = 12
  end
  after { Capybara.default_wait_time = @origional_wait_time }

  let(:registration_page) { RegistrationPage.new }
  let(:course) { FactoryGirl.create(:course, online: true, price: 200) }
  let(:last_registration) { TrainingApp::Registration.last }

  describe "without a discount code" do
    scenario do
      registration_page.visit_page(course)
      registration_page.submit_form()
      expect(registration_page.regular_price).to eq(200)
      expect(registration_page).to be_successful
      expect(last_registration.amount).to eq(200)
    end
  end

  describe "with a discount code" do
    let!(:discount_code) { FactoryGirl.create(:discount_code, code: "testies", price: 100) }

    scenario do
      registration_page.visit_page(course)
      expect(registration_page.regular_price).to eq(200)
      registration_page.apply_discount("testies")
      expect(registration_page.discounted_price).to eq(100)
      registration_page.submit_form()
      expect(registration_page).to be_successful
      expect(last_registration.amount).to eq(100)
      expect(last_registration.discount_code).to_not be_nil
    end
  end

  describe "with a discount code" do
    let!(:discount_code) { FactoryGirl.create(:discount_code, code: "testies", price: 100) }

    scenario do
      registration_page.visit_page(course)
      expect(registration_page.regular_price).to eq(200)
      registration_page.apply_discount("testies")
      expect(registration_page.discounted_price).to eq(100)
      registration_page.submit_form()
      expect(registration_page).to be_successful
      expect(last_registration.amount).to eq(100)
    end
  end
end