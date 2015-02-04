require 'rails_helper'

feature 'Shows' do
  scenario 'User is on location page' do
    visit show_location_path('US', 'NY', 'New+York')

    expect(page).to have_content 'Currently'
  end
end