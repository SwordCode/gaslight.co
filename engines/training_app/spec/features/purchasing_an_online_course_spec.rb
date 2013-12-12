require 'spec_helper'

feature "Purchasing an online course", js: true do
  # increase the capybara wait time to account for stripe
  before do
    @origional_wait_time = Capybara.default_wait_time
    Capybara.default_wait_time = 10
  end
  after { Capybara.default_wait_time = @origional_wait_time }

  let(:course) { FactoryGirl.create(:course, online: true) }
  let(:registration_page) { RegistrationPage.new }

  describe "without a discount code" do
    scenario do
      registration_page.visit_page(course)
      registration_page.submit_form()
      expect(registration_page).to be_successful
    end
  end

  describe "with a discount code" do
    let(:discount_code) { 123 }
    scenario do
      registration_page.visit_page(course)
      registration_page.submit_form({ discount_code: discount_code })
      expect(registration_page).to be_successful
    end
  end
end