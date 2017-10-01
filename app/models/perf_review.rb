class PerfReview < ApplicationRecord

  def employee
    Employee.find(employee_id)
  end

  def update_flag
    PerfReviewReviewer.find(request_id).update flag: 1
  end

  def request
    PerfReviewReviewer.find_by(reviewer_id: reviewer_id)
  end

  def calculate_avg_point
    category_wise_points = Hash.new
    PerfReviewCatg.all.each do |category|
      each_quest_points = Array.new
      category.questions.each do |question|
        each_quest_points << question.answer(id)
      end
      sum_of_array = each_quest_points.sum.to_i
      average_point = sum_of_array/each_quest_points.length
      category_wise_points[category.id] = average_point
    end
    category_wise_points
  end

  def update_average_point
    total_avg = calculate_avg_point.values.sum/PerfReviewCatg.count
    self.update avg: total_avg
  end

end
