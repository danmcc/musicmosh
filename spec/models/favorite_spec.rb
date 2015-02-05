require 'spec_helper'

describe 'Favorite' do

  describe 'creation' do

    context 'valid attributes' do

      it 'should be valid' do
        favorite = FactoryGirl.build(:favorite)

        expect(favorite).to be_valid

      end

    end

    context 'invalid attributes' do

      it 'should not be valid' do
        favorite = FactoryGirl.build(:favorite, user: nil)

        expect(favorite).not_to be_valid
      end

    end

    context 'duplicate' do

      it 'should not be valid' do
        show = FactoryGirl.build(:show)
        user = FactoryGirl.build(:user)

        FactoryGirl.create(:favorite, show: show, user: user)

        favorite = FactoryGirl.build(:favorite, show: show, user: user)

        expect(favorite).not_to be_valid
      end

    end

  end

end