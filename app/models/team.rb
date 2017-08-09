class Team < ApplicationRecord
  has_many :employees, through: :team_members
  has_many :team_members, dependent: :destroy
  has_many :exams, dependent: :destroy
end
