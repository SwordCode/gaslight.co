class ContactController < ApplicationController

  def create
    respond_to do |format|
      if message.process
        CRM.create_deal(params[:message])
        flash[:success] = "Ok, we've got it!"
        @message = Message.new
        format.html { redirect_to contact_path }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  protected

  def message
    @message ||= Message.new(params[:message] || {})
    @message.remote_ip = request.remote_ip
    @message.user_agent = request.user_agent
    @message
  end
  helper_method :message

end
