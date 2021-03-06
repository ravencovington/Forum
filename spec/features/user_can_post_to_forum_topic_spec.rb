require 'rails_helper'
require 'feature_helper'

RSpec.feature 'User can post to forum topic' do
  before do
    log_in_with 'raven@bignerdranch.com', 'password'
    create_new_forum_topic 'BNR iOS book'
  end

  scenario 'user can post to forum topic' do
    expect(page).to have_content("You're at the Forum Topic Page")
    click_button('Create a new post')
    expect(page).to have_content('BNR iOS book')
    fill_in 'Content', with: 'This book is awesome!'
    click_button('Submit')
    expect(page).to have_content('This book is awesome!')
  end

  scenario 'user submits blank content' do
    expect(page).to have_content('BNR iOS book')
    click_button('Create a new post')
    fill_in 'Content', with: ''
    click_button('Submit')
    expect(page).to have_content("Content can't be blank")
  end

  scenario 'user can see markdown in his post' do
    click_button('Create a new post')
    fill_in 'Content', with: '**hello**'
    click_button('Submit')
    expect(page.html).to include('<p><strong>hello</strong></p>')
  end

  scenario 'user can preview post before submitting it' do
    click_button('Create a new post')
    fill_in 'Content', with: '**hello**'
    click_button('Preview')
    expect(page.html).to include('<strong>hello</strong>')
    click_button('Submit')
    expect(page).to have_content('Post successfully created')
  end
end
