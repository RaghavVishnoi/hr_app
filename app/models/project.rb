class Project < ApplicationRecord
  has_many :trackers, class_name: "Tracker", foreign_key: "project_id"	 
  belongs_to :project_team, foreign_key: :assigned_to
end
