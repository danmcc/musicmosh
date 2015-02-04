require 'spec_helper'

describe 'Show' do

  describe 'creation' do

    context 'valid attributes' do

      it 'should be valid' do
        show = FactoryGirl.build(:show)

        expect(show).to be_valid

      end

    end

    context 'invalid attributes' do

      it 'should not be valid' do
        show = FactoryGirl.build(:show, artist: nil)

        expect(show).not_to be_valid
      end

    end

  end

end