class ProjectTeam < ApplicationRecord
  has_many :project_team_members
  has_many :projects, foreign_key: :assigned_to, class_name: "Project"
  validates :project_id, uniqueness: true
  
  belongs_to :team_leader, class_name: "Employee", foreign_key: :team_leader_id
  belongs_to :team_manager, class_name: "Employee", foreign_key: :team_manager_id

  def project_title
    projects.pluck(:name)
  end
end
