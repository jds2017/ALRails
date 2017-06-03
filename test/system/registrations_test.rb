require "application_system_test_case"

class RegistrationsTest < ApplicationSystemTestCase
  test 'walkthrough for first demo' do
    assert !User.find_by(username: 'leahy').is_professor
    visit '/users?un=john'
    assert_text 'leahy'
    page.all('a', text: 'Edit')[2].click
    check 'Is professor'
    click_button 'Update User'
    click_on 'Back'
    assert User.find_by(username: 'leahy').is_professor

    visit '/courses?un=leahy'
    click_on 'New Course'
    fill_in 'Year', with: '2017'
    fill_in 'Semester', with: 'SUMMER'
    fill_in 'Name', with: 'CS2110'
    fill_in 'Student key', with: '33123'
    click_on 'Create Course'
    click_on 'Back'
    assert_text 'CS2110'

    click_on 'registrations'
    click_on 'New Registration'
    fill_in 'Role', with: 'ASSISTANT'
    select('jonathan', :from => 'registration[user_id]')
    select('CS2110', :from => 'registration[course_id]')
    click_on 'Create Registration'
    click_on 'Back'
    assert_text 'jonathan'

    visit '/courses?un=jonathan'
    click_on 'registrations'
    click_on 'New Registration'
    fill_in 'Role', with: 'STUDENT'
    select('astudent', :from => 'registration[user_id]')
    select('CS2110', :from => 'registration[course_id]')
    click_on 'Create Registration'
    click_on 'Back'
    assert_text 'astudent'

    visit '/courses?un=astudent'
    click_on 'registrations'
    assert_text 'CS2110'
  end
end
