require 'rails_helper'

def send_post_request(params)
  post '/contact_emails', contact_email: params
end

RSpec.describe 'ContactEmail request', :type => :request do
  describe 'POST /contact_email' do
    before do
      @default_params = {
          name: 'test',
          email: 'test@example.com',
          message: 'message'
        }
    end

    context 'with valid data' do
      it 'returns status code 200' do
        send_post_request(@default_params)
        expect(response).to be_success
      end

      it 'creates a new ConctactEmail' do
        expect { send_post_request(@default_params) }
          .to change(ContactEmail, :count).by(1)
      end

      it 'returns created ContactEmail' do
        send_post_request(@default_params)
        json = JSON.parse(response.body)

        [:name, :email, :message].each do |param|
          expect(json[param.to_s]).to eq @default_params[param]
        end
      end
    end

    context 'with invalid data' do
      before do
        @default_params[:email] = ''
      end

      it 'returns status code 400' do
        send_post_request(@default_params)
        expect(response).to have_http_status(:bad_request)
      end

      it 'does not create new ContactEmail' do
        expect { send_post_request(@default_params) }
          .not_to change(ContactEmail, :count)
      end

      it 'returns error messages' do
        send_post_request(@default_params)
        json = JSON.parse(response.body)

        expect(json).to include 'email'
        expect(json['email'].length).to be >= 1
      end
    end
  end
end
