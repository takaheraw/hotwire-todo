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
class LineItemDate < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :task

  validates :date, presence: true, uniqueness: { scope: :task_id }

  scope :ordered, -> { order(date: :asc) }

  def previous_date
    task.line_item_dates.ordered.where('date < ?', date).last
  end
end
