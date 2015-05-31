class ContactEmailSender
  attr_reader :email, :recipients

  def self.send(*args)
    new(*args).send
  end

  def initialize(email_data, recipients: default_recipients)
    @email = email_data.try(:email)
    @email or raise ArgumentError, 'No email given'

    @name = email_data.try(:name)
    @message = email_data.try(:message)

    @recipients = recipients
  end

  def send
    ContactMailer.contact_mail(recipients, @name, @message).deliver
    ContactMailer.confirmation_mail(email, @name).deliver
  end

  private

  def default_recipients
    ['maciej@mkaszubowski.pl']
  end
end
