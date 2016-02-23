# Feature: Create a new person
#   as authorized user
#   I want to create a new person

feature 'Person new', :devise do
  # an administrator can create a new person
  #   Given I exist as a user
  #   And I am signed in
  #   And I am administrator
  #   When I visit the page for creating a person
  #   Then the page for creating a person is shown
  scenario 'show page to create Person' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    visit new_person_path
    expect(page).to have_content 'New Person'
  end

  # scenarion with German language
  #   Given I exist as a user
  #   And I am signed in
  #   And I am administrator
  #   When I visit the page for creating a person
  #   Then 
=begin
  scenario 'show German page to create Person' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    I18n.locale = :de
    visit new_person_path
    expect(page).to have_content 'astname'
  end
=end

  # an administrator can create a new person
  #   Given I exist as a user
  #   And I am signed in
  #   And I am administrator
  #   When I create a person
  #   Then the page for the newly created person is shown
  scenario 'create Person' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    visit new_person_path(locale: :de)
    fill_in 'Lastname', with: 'Test-Nachname'
    click_button 'Person erstellen'
    expect(page).to have_content 'Test-Nachname'
  end

end
