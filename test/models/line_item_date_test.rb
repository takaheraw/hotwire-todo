# == Schema Information
#
# Table name: line_item_dates
#
#  id         :bigint           not null, primary key
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  task_id    :bigint           not null
#
# Indexes
#
#  index_line_item_dates_on_task_id  (task_id)
#
# Foreign Keys
#
#  fk_rails_...  (task_id => tasks.id)
#
require "test_helper"

class LineItemDateTest < ActiveSupport::TestCase
  test "#previous_date returns the task's previous date when it exists" do
    assert_equal line_item_dates(:today), line_item_dates(:next_week).previous_date
  end

  test '#previous_date returns nil when the task has no previous date' do
    assert_nil line_item_dates(:today).previous_date
  end
end
