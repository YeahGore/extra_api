class Team < ApplicationRecord

  has_many :users, dependent: :nullify

  validates :name, presence: true
  validates :team_type, presence: true

  enum team_type: { chats: 0, calls: 1}

end