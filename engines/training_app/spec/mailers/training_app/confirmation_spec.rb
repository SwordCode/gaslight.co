require "spec_helper"

module TrainingApp
  describe Confirmation do

    before do
      TrainingApp::Registration.any_instance.stub(:charge_stripe).and_return(true)
    end

    let(:registration) { FactoryGirl.create(:registration) }
    let(:registration_mail) { TrainingApp::Confirmation.registered(registration) }
    it "renders the email" do
      expect(registration_mail.body).to match registration.course.title
      expect(registration_mail.body).to match "code=#{registration.code}#/courses/#{registration.course.id}"
      expect(registration_mail.body).to match "https://exam"
    end
  end
end

