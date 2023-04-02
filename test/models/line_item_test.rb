# == Schema Information
#
# Table name: line_items
#
#  id                :bigint           not null, primary key
#  description       :text(65535)
#  man_day           :integer
#  name              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  line_item_date_id :bigint           not null
#
# Indexes
#
#  index_line_items_on_line_item_date_id  (line_item_date_id)
#
# Foreign Keys
#
#  fk_rails_...  (line_item_date_id => line_item_dates.id)
#
require "test_helper"

class LineItemTest < ActiveSupport::TestCase
  test "#total_days returns the total day of the line item" do
    assert_equal 10, line_items(:catering_today).total_days
  end
end
