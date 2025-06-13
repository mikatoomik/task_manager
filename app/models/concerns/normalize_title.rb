# frozen_string_literal: true

module NormalizeTitle
  extend ActiveSupport::Concern

  included do
    before_save :normalize_title
  end

  private

  def normalize_title
    self.title = title.strip.capitalize if title.present?
  end
end
