include Warden::Test::Helpers
Warden.test_mode!

# Feature: User index page
#   As a administrator
#   I want to see a list of users
#   So I can see who has registered
feature 'User index page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User listed on index page
  #   Given I am signed in as admin
  #   When I visit the user index page
  #   Then I see my own email address
  scenario 'admin sees his own email address' do
    user = FactoryGirl.create(:user, :admin)
    login_as(user, scope: :user)
    visit users_path
    expect(page).to have_content user.email
  end

  # Scenario: Accessing index page
  #   Given I am signed in as assitant
  #   When I visit the user index page
  #   I will get the error 'xxx'
  scenario 'assitant vists the index page' do
    user = FactoryGirl.create(:user, :assistant)
    login_as(user, scope: :user)
    visit users_path
    expect(page).not_to have_content user.email
  end

end
