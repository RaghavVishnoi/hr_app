class ProjectTeam < ApplicationRecord
  has_many :project_team_members
  belongs_to :project
  validates :project_id, uniqueness: true
end
