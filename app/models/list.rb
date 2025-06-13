class List < ApplicationRecord
  include NormalizeTitle

  before_destroy :ensure_no_incomplete_tasks

  has_many :tasks, dependent: :destroy

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  scope :with_incomplete_tasks, -> { joins(:tasks).merge(Task.incomplete).distinct }

  def percent_complete
    return 0 if tasks.count == 0
    (tasks.completed.count.to_f / tasks.count * 100).round
  end

  private

  def ensure_no_incomplete_tasks
    if tasks.incomplete.exists?
      errors.add(:base, "Impossible de supprimer une liste avec des tâches incomplètes.")
      throw(:abort)
    end
  end

  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: ->(attrs) { attrs['title'].blank? }

end
