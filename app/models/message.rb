class Message

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :phone, :project, :timeline, :budget, :newsletter, :remote_ip, :user_agent, :human

  validates :name, :email, presence: true
  validates :email, format: { with: %r{.+@.+\..+} }, allow_blank: true
  validates :human,
    format: { with: /ye[asp]/i, message: 'Just a "yes" will do.' },
    allow_blank: false

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def process
    valid? ? NotificationsMailer.new_message(self).deliver : false
  end

  private

  def persisted?
    false
  end
end

