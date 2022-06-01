class League < ApplicationRecord
  has_many :items, dependent: :restrict_with_error

  scope :not_private, -> { where(private: false) }
  scope :permanent, -> { where(ends_at: nil) }
  scope :temporary, -> { where.not(ends_at: nil) }
end
