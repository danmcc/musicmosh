require 'spec_helper'

describe 'Venue' do

  describe 'creation' do

    context 'valid attributes' do

      it 'should be valid' do
        venue = FactoryGirl.build(:venue)

        expect(venue).to be_valid

      end

    end

    context 'invalid attributes' do

      it 'should not be valid' do
        venue = FactoryGirl.build(:venue, name: '')

        expect(venue).not_to be_valid
      end

    end

  end

end