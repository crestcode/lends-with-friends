require 'rails_helper'

describe FriendsController do
  it 'should be able to create a new user' do
    post :create, :friend => {first_name: 'Test', last_name: 'User', email: 'test@test.com', phone: '555-555-5555'}, format: :json

    expect(response.status).to eq(200)

    json_response = JSON.parse(response.body)
    expect(json_response['first_name']).to eql('Test')
    expect(json_response['last_name']).to eql('User')
    expect(json_response['email']).to eql('test@test.com')
    expect(json_response['phone']).to eql('555-555-5555')
  end

  it 'should respond with 204 status and error messages if invalid friend data' do
    post :create, :friend => {first_name: nil, last_name: 'Tester', email: 'test@test.com'}, format: :json

    expect(response.status).to eq(204)
    expect(JSON.parse(response.body)).to eql('friend' => {'first_name' => ['can\'t be blank']})
  end
end