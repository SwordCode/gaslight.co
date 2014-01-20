require 'spec_helper'

describe ContactController do
  describe "POST 'create'" do
    context "when valid" do
      before(:each) do
        CRM.stub(:create_deal).and_return(true)
        post :create, message: { name: 'Chris Moore', email: 'chris@cdmwebs.com', project: 'This is the body', human: 'yes' }
      end

      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end

    context "when invalid" do
      before(:each) do
        post :create, message: { name: 'Chris' }
      end

      it { should respond_with(:success) }
      it { should render_template('contact/new') }
      it { should_not set_the_flash }
    end
  end
end
