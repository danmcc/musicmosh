require 'spec_helper'

describe 'Artist' do

  describe 'creation' do

    context 'valid attributes' do

      it 'should be valid' do
        artist = FactoryGirl.build(:artist)

        expect(artist).to be_valid

      end

    end

    context 'invalid attributes' do

      it 'should not be valid' do
        artist = FactoryGirl.build(:artist, name: '')

        expect(artist).not_to be_valid
      end

    end

  end

end