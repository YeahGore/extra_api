class Link < ApplicationRecord

  belongs_to :user

  validates :source, presence: true
  validates :rec_time, presence: true
  validates :reason, presence: true

  enum approve: { waiting_for_approve: 0, approved: 1, not_approved: 2}
  enum reason: { other: 0}

end
