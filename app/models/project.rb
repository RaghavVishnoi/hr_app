class Project < ApplicationRecord
  belongs_to :project_team, foreign_key: :assigned_to
end
