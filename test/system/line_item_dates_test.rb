require 'application_system_test_case'

class LineItemDatesTest < ApplicationSystemTestCase
  include ActionView::Helpers::NumberHelper

  setup do
    login_as users(:accountant)
    @task = tasks(:first)
    @line_item_date = line_item_dates(:today)
    visit task_path(@task)
  end

  test 'Creating a new line item date' do
    assert_selector 'h1', text: 'First task'

    click_on 'New date'
    assert_selector 'h1', text: 'First task'
    fill_in 'Date', with: Date.current + 1.day

    click_on 'Create date'
    assert_text I18n.l(Date.current + 1.day, format: :long)
  end

  test 'Updating a line item date' do
    assert_selector 'h1', text: 'First task'

    within id: dom_id(@line_item_date, :edit) do
      click_on 'Edit'
    end

    assert_selector 'h1', text: 'First task'

    fill_in 'Date', with: Date.current + 1.day
    click_on 'Update date'

    assert_text I18n.l(Date.current + 1.day, format: :long)
  end

  test 'Destroying a line item date' do
    assert_text I18n.l(Date.current, format: :long)

    accept_confirm do
      within id: dom_id(@line_item_date, :edit) do
        click_on 'Delete'
      end
    end

    assert_no_text I18n.l(Date.current, format: :long)
    assert_text number_to_currency(@task.total_days)
  end
end
