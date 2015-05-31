class ContactMailer < ApplicationMailer
  default from: 'maciej.kaszubowski94@gmail.com'

  def contact_mail(email, name, message)
    @name = name
    @message = message
    mail(to: email, subject: 'ePUEPS Kontakt')
  end

  def confirmation_mail(email, name)
    @name = name
    mail(to: email, subject: 'ePUEPS - potwierdzenie wiadomości')
  end
end
