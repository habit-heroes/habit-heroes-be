require 'rails_helper'

RSpec.describe 'User Requests' do
  describe 'End Point 1' do
    it 'successfully finds a valid user' do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")

      get "/api/v1/users/#{grant.id}"

      expect(response).to be_successful
      expect(response.status).to eq (200)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:data)

      expect(parsed_json[:data]).to be_a (Hash)
      expect(parsed_json[:data]).to have_key (:id)
      expect(parsed_json[:data]).to have_key (:type)
      expect(parsed_json[:data]).to have_key (:attributes)

      expect(parsed_json[:data][:id]).to eq (grant.id)
      expect(parsed_json[:data][:type]).to eq ('user')
      expect(parsed_json[:data][:attributes]).to be_a (Hash)
      expect(parsed_json[:data][:attributes]).to have_key (:first_name)
      expect(parsed_json[:data][:attributes]).to have_key (:last_name)
      expect(parsed_json[:data][:attributes]).to have_key (:email)

      expect(parsed_json[:data][:attributes][:first_name]).to be_a (String)
      expect(parsed_json[:data][:attributes][:first_name]).to eq (grant.first_name)
      expect(parsed_json[:data][:attributes][:last_name]).to be_a (String)
      expect(parsed_json[:data][:attributes][:last_name]).to eq (grant.last_name)
      expect(parsed_json[:data][:attributes][:email]).to be_a (String)
      expect(parsed_json[:data][:attributes][:email]).to eq (grant.email)
    end

    it 'returns an error message if no user is found' do
      get '/api/v1/users/1'

      expect(response).to_not be_successful
      expect(response.status).to eq (404)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:error)

      expect(parsed_json[:error]).to be_a (String)
      expect(parsed_json[:error]).to eq ('User not found')
    end
  end
end