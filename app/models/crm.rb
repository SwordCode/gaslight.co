require 'pipedrive-ruby'

class CRM
  def self.create_deal(message)
    crm = self.new
    @deal = crm.create_deal(message)
    @deal
  end

  def initialize
    @crm ||= Pipedrive.authenticate(ENV.fetch('PIPEDRIVE_API_TOKEN'))
  end

  def create_deal(params)
    person = Pipedrive::Person.create(name: params[:name], email: params[:email], phone: params[:phone])
    deal = Pipedrive::Deal.create(title: generated_deal_name(params[:name]), person_id: person.id)
    Pipedrive::Note.create(deal_id: deal.id, content: params[:project])
    deal
  end

  def generated_deal_name(deal_name)
    "#{deal_name} - Website Contact"
  end
end
