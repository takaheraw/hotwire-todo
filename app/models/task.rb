# == Schema Information
#
# Table name: tasks
#
#  id              :bigint           not null, primary key
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_tasks_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
class Task < ApplicationRecord
  has_many :line_item_dates, dependent: :destroy
  has_many :line_items, through: :line_item_dates

  belongs_to :organization

  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  broadcasts_to ->(task) { [task.organization, 'tasks'] }, inserts_by: :prepend

  def total_days
    line_items.sum(&:total_days)
  end
end
