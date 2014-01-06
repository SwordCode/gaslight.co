module TrainingApp
  class Confirmation < ActionMailer::Base
    default from: "Gaslight <training@gaslight.co>"

    def registered(registration)
      @registration = registration
      @registration_link = classroom_index_url(code: @registration.code, anchor: "/courses/#{registration.course.id}", protocol: 'https')
      mail(to: registration.email, subject: "[Gaslight] Thank you for your purchase!")
    end
  end
end

