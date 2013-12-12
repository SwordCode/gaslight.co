require 'spec_helper'

feature "Purchasing an online course", js: true do
  # increase the capybara wait time to account for stripe
  before do
    @origional_wait_time = Capybara.default_wait_time
    Capybara.default_wait_time = 12
  end
  after { Capybara.default_wait_time = @origional_wait_time }

  let(:course) { FactoryGirl.create(:course, online: true) }
  let!(:section) { FactoryGirl.create(:section, course: course) }
  let!(:chapter) { FactoryGirl.create(:chapter, course: course) }
  let(:registration_page) { RegistrationPage.new }

  describe "without a discount code" do
    scenario do
      registration_page.visit_page(course)
      registration_page.submit_form()
      expect(registration_page).to be_successful
    end
  end
end