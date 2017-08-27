class Tracker < ApplicationRecord
  has_many :tracker_logs, class_name: "TrackerLog", foreign_key: "tracker_id"

  belongs_to :project
  belongs_to :employee
end
