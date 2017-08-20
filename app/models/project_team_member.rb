class ProjectTeamMember < ApplicationRecord
  belongs_to :employee
  belongs_to :project_team
end
