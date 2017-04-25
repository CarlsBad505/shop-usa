class Message
  include ActiveAttr::Model

  attribute :first_name
  attribute :last_name
  attribute :email_address
  attribute :phone
  attribute :url
  attribute :note

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email_address
  validates_format_of :email_address, :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates_presence_of :phone
  validates_format_of :phone, :with => /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/
  validates_presence_of :url
  validates_length_of :note, :maximum => 1000

end
