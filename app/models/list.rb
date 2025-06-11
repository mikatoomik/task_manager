class List < ApplicationRecord
  include NormalizeTitle

  before_destroy :ensure_no_incomplete_tasks

  has_many :tasks, dependent: :destroy

  validates :title, presence: true, uniqueness: { case_sensitive: false }

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
end
