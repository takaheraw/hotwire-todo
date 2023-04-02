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
class LineItem < ApplicationRecord
  belongs_to :line_item_date

  validates :name, presence: true
  validates :man_day, presence: true, numericality: { only_integer: true, greater_than: 0 }

  delegate :task, to: :line_item_date

  def total_days
    man_day
  end
end
