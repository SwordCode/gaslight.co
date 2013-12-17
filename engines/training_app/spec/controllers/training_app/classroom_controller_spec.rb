require 'spec_helper'

module TrainingApp
  describe ClassroomController do
    let!(:registration) {FactoryGirl.create(:registration, code: "123")}
    describe "GET classroom" do
      it "sets the registration.code on the session" do
        get :index, code: "123", use_route: :training
        expect(session[:registration_code]).to eq("123")
      end
    end
  end
end