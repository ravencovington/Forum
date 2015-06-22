require 'rails_helper'
require 'feature_helper'

RSpec.feature "User creates forum topic" do

  before do
    log_in_with "raven@bignerdranch.com", "password"
  end

  scenario 'user creates a new forum topic' do
    click_on('Create New Forum Topic')
    fill_in 'Title', with: 'BNR iOS book'
    click_on('Save Forum topic')
    expect(page).to have_content("You're at the Forum Topic Page")
    expect(page).to have_selector(:link_or_button, 'Archive')
  end

  scenario 'user updates state of forum' do
    click_on('Create New Forum Topic')
    fill_in 'Title', with: 'BNR iOS book'
    click_on('Save Forum topic')
    expect(page).to have_content("You're at the Forum Topic Page")
    expect(page).to have_selector(:link_or_button, "Archive")
    click_on("Archive")
    expect(page).to have_selector(:link_or_button, "Un-Archive")
  end

  scenario 'user enters blank forum topic title' do
    click_on('Create New Forum Topic')
    fill_in 'Title', with: ''
    click_on('Save Forum topic')
    expect(page).to have_content("Title can't be blank")
    expect(page.current_path).to eq(forum_topics_path)
  end

  scenario 'user enters identical forum topic title' do
    click_on('Create New Forum Topic')
    fill_in 'Title', with: 'BNR iOS book'
    click_on('Save Forum topic')
    expect(page).to have_content('Title has already been taken')
    expect(page.current_path).to eq(forum_topics_path)
  end
end
