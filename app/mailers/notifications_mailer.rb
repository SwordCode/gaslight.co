class NotificationsMailer < ActionMailer::Base
  default from: "Gaslight Website <hello@teamgaslight.com>"
  default to: "hello@teamgaslight.com"

  def new_message(message)
    @name = message.name
    @email = message.email
    @phone = message.phone
    @timeline = message.timeline
    @budget = message.budget
    @project = message.project
    @ip_address = message.remote_ip
    @user_agent = message.user_agent

    @email_with_name = "#{@name} <#{@email}>".html_safe

    mail(subject: "Fwd: Contact Form",
         bcc: ENV.fetch('HIGHRISE_DROPBOX'),
         cc: 'hello@teamgaslight.com',
         to: @email_with_name)
  end
end
