require 'spec_helper'

feature 'Contact Us' do
  before(:each) { CRM.stub(:create_deal).and_return(true) }

  scenario 'via the landing page' do
    contact_us_page.visit_page
    contact_us_page.complete_form
    contact_us_page.submit
    contact_us_page.should be_successful

    ActionMailer::Base.deliveries.should_not be_empty
    result = ActionMailer::Base.deliveries.select do |email|
      email.subject =~ /Contact/i && email.body =~ /might be a question/
    end
    result.should have_at_least(1).item
  end

  scenario 'via the landing page using AJAX', js: true do
    contact_us_page.visit_page
    contact_us_page.open_modal
    contact_us_page.submit
    contact_us_page.should_not be_successful

    contact_us_page.complete_form
    contact_us_page.complete_form
    contact_us_page.submit
    contact_us_page.should be_successful

    ActionMailer::Base.deliveries.should_not be_empty
    result = ActionMailer::Base.deliveries.select do |email|
      email.subject =~ /Contact/i && email.body =~ /might be a question/
    end
    result.should have_at_least(1).item
  end
end
