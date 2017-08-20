module LeavesHelper
  def employee_status(leave)
    progress = 0
    progress = 1 if leave.employee_accepted_at?
    progress = 2 if leave.tl_accepted_at?
    progress = 3 if leave.tm_accepted_at?
    progress = 4 if leave.hr_accepted_at?
    progress = 5 if leave.president_accepted_at?
    progress
  end

  def progress_class(progress, p_bar)
    if (progress) >= p_bar
      "complete"
    elsif progress +1 > p_bar
      "active"
    else
      "disabled"
    end
  end
end
