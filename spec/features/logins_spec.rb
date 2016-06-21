require 'rails_helper'

RSpec.feature "Logins", type: :feature do
  context 'We are on the login page' do
    Steps 'Creating a login' do
      When 'I visit the login in page' do
        visit '/'
      end
      Then 'I can fill out a form with first name, last name, address, city, state, postal code, country, phone numbers, email, user id, password' do
        fill_in :firstName, with: 'Kenny'
        fill_in :lastName, with: 'Loggins'
        fill_in :address, with: '123 fake st'
        fill_in :city, with: 'San Diego'
        fill_in :state, with: 'Rhode Island'
        fill_in :postalCode, with: '90210'
        fill_in :country, with: 'USSR'
        fill_in :cellPhone, with: '555-555-5555'
        fill_in :workPhone, with: '333-333-3333'
        fill_in :homePhone, with: '222-222-2222'
        fill_in :email, with: 'someone@somewhere.com'
        fill_in :userId, with: 'KennyL'
        fill_in :password, with: 'letmein'
      end
      And 'I can submit the information' do
        click_button "Register"
      end
    end
  end

  context 'We are on the login page' do
    Steps 'submitting a login' do
      When 'I visit the login in page' do
        visit '/'
      end
      Then 'I can fill out a form with first name, last name, address, city, state, postal code, country, phone numbers, email, user id, password' do
        fill_in :firstName, with: 'Kenny'
        fill_in :lastName, with: 'Loggins'
        fill_in :address, with: '123 fake st'
        fill_in :city, with: 'San Diego'
        fill_in :state, with: 'Rhode Island'
        fill_in :postalCode, with: '90210'
        fill_in :country, with: 'USSR'
        fill_in :cellPhone, with: '555-555-5555'
        fill_in :email, with: 'someone@somewhere.com'
        fill_in :userId, with: 'KennyL'
        fill_in :password, with: 'letmein'
      end
      Then 'I can submit the information' do
        click_button "Register"
      end
      And 'I am taken to a confirmation page' do
        expect(page).to have_content 'Registration Confirmed'
        expect(page).to have_content 'Welcome Kenny Loggins'
        expect(page).to have_content 'Your user name is: KennyL'
      end
      And 'the user credentials are stored in the database' do
        expect(User.find_by_user_id('KennyL').password).to eq 'letmein'
      end
      And 'the users phones are also stored' do
        expect(Phone.where(user_id: User.find_by_user_id('KennyL').id).first.phone_type).to eq 'Cell'
      end

      When 'I visit the login in page' do
        visit '/'
      end
      Then 'I can fill out a form with first name, last name, address, city, state, postal code, country, phone numbers, email, user id, password' do
        fill_in :firstName, with: 'Kenny'
        fill_in :lastName, with: 'Loggins'
        fill_in :address, with: '123 fake st'
        fill_in :city, with: 'San Diego'
        fill_in :state, with: 'Rhode Island'
        fill_in :postalCode, with: '90210'
        fill_in :country, with: 'USSR'
        fill_in :workPhone, with: '555-555-5555'
        fill_in :email, with: 'someone@somewhere.com'
        fill_in :userId, with: 'Jimbo'
        fill_in :password, with: 'letmein'
      end
      Then 'I can submit the information' do
        click_button 'Register'
      end
      And 'I am taken to a confirmation page' do
        expect(page).to have_content 'Registration Confirmed'
        expect(page).to have_content 'Welcome Kenny Loggins'
        expect(page).to have_content 'Your user name is: Jimbo'
      end
      And 'the user credentials are stored in the database' do
        expect(User.find_by_user_id('Jimbo').password).to eq 'letmein'
      end
      And 'the users phones are also stored' do
        expect(Phone.where(user_id: User.find_by_user_id('Jimbo').id).first.phone_type).to eq 'Work'
      end
    end
  end

  context 'On landing page' do
    Steps 'logging in' do
      When 'I visit the landing page' do
        visit '/'
        fill_in :firstName, with: 'Kenny'
        fill_in :lastName, with: 'Loggins'
        fill_in :address, with: '123 fake st'
        fill_in :city, with: 'San Diego'
        fill_in :state, with: 'Rhode Island'
        fill_in :postalCode, with: '90210'
        fill_in :country, with: 'USSR'
        fill_in :workPhone, with: '555-555-5555'
        fill_in :email, with: 'someone@somewhere.com'
        fill_in :userId, with: 'Ballerman619'
        fill_in :password, with: 'money'
        click_button 'Register'
        visit '/'
      end
      Then 'I see an area where I can login' do
        expect(page).to have_content 'User ID:'
        expect(page).to have_content 'Password:'
      end
      And 'I can fill in my login information' do
        fill_in :logUserId, with: 'Ballerman619'
        fill_in :logPassword, with: 'money'
        click_button 'Log In'
      end
      Then 'I am taken to a welcome page' do
        expect(page).to have_content 'Hello Ballerman619'
        expect(page).to have_content 'Kenny'
        expect(page).to have_content 'Loggins'
        expect(page).to have_content '123 fake st'
        expect(page).to have_content 'San Diego'
        expect(page).to have_content 'Rhode Island'
        expect(page).to have_content '90210'
        expect(page).to have_content 'USSR'
        expect(page).to have_content '555-555-5555'
        expect(page).to have_content 'someone@somewhere.com'
        expect(page).to have_content 'Ballerman619'
      end
      And 'I can go to the root and fail login' do
        visit '/'
        fill_in :logUserId, with: 'Ballerman619'
        fill_in :logPassword, with: 'peso'
        click_button 'Log In'
      end
      Then 'I am returned to the landing page' do
        expect(page).to have_content 'Invalid login credentials'
      end
      And 'I create a new user without phones' do
        visit '/'
        fill_in :userId, with: 'mikeg'
        fill_in :password, with: 'hi'
        click_button 'Register'
        visit '/'
        fill_in :logUserId, with: 'mikeg'
        fill_in :logPassword, with: 'hi'
        click_button 'Log In'
      end
      Then 'I should see No Phone message' do
        expect(page).to have_content 'No Phone'
      end
    end
  end

  context 'creating a duplicate user id' do
    Steps 'create a duplicate user' do
      When 'I visit the landing page and create 2 users' do
        visit '/'
        fill_in :userId, with: 'mikeg'
        fill_in :password, with: 'hi'
        click_button 'Register'
        visit '/'
        fill_in :userId, with: 'mikeg'
        fill_in :password, with: 'yes'
        click_button 'Register'
      end
      Then 'I should be taken back to the landing page with a message' do
        expect(page).to have_content 'Login page'
        expect(page).to have_content 'User ID taken, try another'
      end
    end
  end

end
