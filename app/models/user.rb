class User < ApplicationRecord

  has_many :links

  validates :chatwoot_id, presence: true
  validates :chatwoot_name, presence: true
  validates :role, presence: true

  enum role: { support: 0, admin: 1, okk: 2 }

end
