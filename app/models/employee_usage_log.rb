class EmployeeUsageLog < ApplicationRecord
  belongs_to :employee


  def self.in_log
    where(entry_type: "IN").first.created_at.to_time
  end

   def self.out_log
    where(entry_type: "OUT").last.created_at.to_time
  end


end
