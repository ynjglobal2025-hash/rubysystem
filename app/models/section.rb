class Section < ApplicationRecord
  enum status: {
    pending:     0,
    in_progress: 1,
    completed:   2
  }

  validates :title, presence: true
  validates :status, presence: true

  scope :for_mobile_sync, -> { where(status: [:in_progress, :completed]).order(updated_at: :desc) }
  scope :active, -> { where(status: :in_progress) }
end
