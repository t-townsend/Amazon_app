require 'rails_helper'

RSpec.describe User, type: :model do
  def valid_attributes(new_attributes = {})
  {  first_name: 'Bob',
    last_name: 'Bobberson',
    email: 'bob@example.com',
    password: '12345678'

  }.merge(new_attributes)
  end

  describe 'Validations' do

    it 'requires a first name' do
      user = User.new(valid_attributes ({first_name: nil}))
      expect(user).to be_invalid
    end

    it 'requires a last name' do
      user = User.new(valid_attributes ({last_name: nil}))
      expect(user).to be_invalid
    end

    it 'requires an email' do
      user = User.new(valid_attributes ({email: nil}))
      expect(user).to be_invalid
    end

    it 'requires a unique email' do
      user = User.create(valid_attributes)
      user_2 = User.create(valid_attributes)
      expect(user_2.errors).to have_key(:email)
    end
  end

  describe 'full_name method' do
    it "returns the first_name and last_name concatenated and titlized"do
      bob_bobberson = 'Bob Bobberson'
      user = User.new(valid_attributes({first_name: 'bob'}))
      expect(user.full_name).to eq(bob_bobberson)
    end
  end
end
