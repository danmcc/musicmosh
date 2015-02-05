require 'spec_helper'

describe 'User' do

  describe 'creation' do

    context 'valid attributes' do

      it 'should be valid' do
        user = FactoryGirl.build(:user)

        expect(user).to be_valid

      end

    end

    context 'invalid attributes' do

      it 'should not be valid without an email' do
        user = FactoryGirl.build(:user, email: '')

        expect(user).not_to be_valid
      end

    end

    context 'invalid attributes' do

      it 'should not be valid without a name' do
        user = FactoryGirl.build(:user, name: '')

        expect(user).not_to be_valid
      end

    end

  end

end