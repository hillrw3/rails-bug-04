require 'rails_helper'
require 'capybara/rails'

feature 'Tasks' do

  scenario 'User can view tasks' do
    user = create_user email: "user@example.com"
    TaskList.create!(name: "Work List")

    login(user)
    click_on "+ Add Task", match: :first
    fill_in "Description", with: "Something important"
    two_days_from_now = 2.days.from_now.to_date
    select two_days_from_now.strftime("%Y"), from: "task_due_date_1i"
    select two_days_from_now.strftime("%B"), from: "task_due_date_2i"
    select two_days_from_now.strftime("%-d"), from: "task_due_date_3i"
    click_on "Create Task"

    expect(page).to have_content("Something important")
    expect(page).to have_content("Task was created successfully!")
    save_and_open_page
    expect(page).to have_content("1 day")
  end

end