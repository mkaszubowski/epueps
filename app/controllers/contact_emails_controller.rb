class ContactEmailsController < ApplicationController
  def new
  end

  def create
    @contact_email = ContactEmail.new(contact_email_params)

    if @contact_email.save
      ContactEmailSender.send(@contact_email)
      render json: @contact_email
    else
      render json: @contact_email.errors, status: :bad_request
    end
  end

  private

  def contact_email_params
    params.require(:contact_email).permit(:name, :email, :message)
  end
end
