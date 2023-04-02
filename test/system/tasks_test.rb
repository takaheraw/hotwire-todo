require 'application_system_test_case'

class tasksTest < ApplicationSystemTestCase
  setup do
    login_as users(:accountant)
    @task = task.ordered.first
  end

  test 'showing a task' do
    visit tasks_path
    click_link @task.name

    assert_selector 'h1', text: @task.name
  end

  test 'updating a task' do
    visit tasks_path
    assert_selector 'h1', text: 'tasks'

    click_on 'Edit', match: :first
    fill_in 'Name', with: 'Updated task'

    assert_selector 'h1', text: 'tasks'
    click_on 'Update task'

    assert_selector 'h1', text: 'tasks'
    assert_text 'Updated task'
  end

  test 'destroying a task' do
    visit tasks_path
    assert_text @task.name

    click_on 'Delete', match: :first
    assert_no_text @task.name
  end

  test 'creating a new task' do
    visit tasks_path
    assert_selector 'h1', text: 'tasks'

    click_on 'New task'
    fill_in 'Name', with: 'Capybara task'

    assert_selector 'h1', text: 'tasks'
    click_on 'Create task'

    assert_selector 'h1', text: 'tasks'
    assert_text 'Capybara task'
  end
end
