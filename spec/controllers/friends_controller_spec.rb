require 'rails_helper'

describe FriendsController do
  describe '#index' do
    it 'should return json of array with friends list' do
      friend = FactoryGirl.create(:friend)
      get :index, format: :json

      expect(response.status).to eq(200)
      json_response = parse_json(response).first
      expect(json_response['first_name']).to eql(friend.first_name)
      expect(json_response['last_name']).to eql(friend.last_name)
      expect(json_response['email']).to eql(friend.email)
      expect(json_response['phone']).to eql(friend.phone)
    end
  end

  describe '#create' do
    it 'should be able to create a new user' do
      post :create, :friend => {first_name: 'Test', last_name: 'User', email: 'test@test.com', phone: '555-555-5555'}, format: :json

      expect(response.status).to eq(200)

      json_response = parse_json(response)
      expect(json_response['first_name']).to eql('Test')
      expect(json_response['last_name']).to eql('User')
      expect(json_response['email']).to eql('test@test.com')
      expect(json_response['phone']).to eql('555-555-5555')
    end

    it 'should respond with 204 status and error messages if invalid friend data' do
      post :create, :friend => {first_name: nil, last_name: 'Tester', email: 'test@test.com'}, format: :json

      expect(response.status).to eq(204)
      expect(parse_json(response)).to eql('friend' => {'first_name' => ['can\'t be blank']})
    end
  end
end