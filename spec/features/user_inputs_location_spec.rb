require 'rails_helper'

feature 'User plays shows at location' do
  scenario 'they see the form on the landing page' do
    visit root_path

    fill_in 'city', with: 'New York'
    click_button 'Go!'

    expect(page).to have_css '.foobar-name', 'My foobar'
  end
end