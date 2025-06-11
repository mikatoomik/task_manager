class List < ApplicationRecord
  before_save :normalize_title
  before_destroy :ensure_no_incomplete_tasks

  has_many :tasks, dependent: :destroy

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  private

  def normalize_title
    self.title = title.strip.capitalize if title.present?
  end

  def ensure_no_incomplete_tasks
    if tasks.incomplete.exists?
      errors.add(:base, "Impossible de supprimer une liste avec des tâches incomplètes.")
      throw(:abort)
    end
  end
end
