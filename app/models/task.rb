class Task < ApplicationRecord
  include NormalizeTitle

  belongs_to :list

  validates :title, presence: true
  validates :title, uniqueness: { scope: :list }

  scope :incomplete, -> { where(completed: false) }
  scope :completed, -> { where(completed: true) }
  scope :by_priority, ->(priority) { where(priority: priorities[priority]) if priorities.key?(priority) }

  enum :priority, { low: 0, medium: 1, high: 2 }
end
