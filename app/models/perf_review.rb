class PerfReview < ApplicationRecord

  belongs_to :employee
  belongs_to :reviewer,class_name: 'Employee',foreign_key: 'reviewer_id'
  belongs_to :team_lead,class_name: 'Employee',foreign_key: 'team_leader'

  validates :employee_id,presence: true
  validates :name,presence: true
  validates :time_in_position,presence: true
  validates :job_title,presence: true
  validates :last_appraisal,presence: true
  validates :team_leader,presence: true
  validates :first_prepared,presence: true
  validates :hiring_date,presence: true
  validates :reviewer_id,presence: true
  validates :prepared_by,presence: true
  validates :request_id,presence: true


  # def employee
  #   Employee.find(employee_id)
  # end

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
        if question.answer(id) != "0" && question.answer(id) != "0.0"
          each_quest_points << question.answer(id)
        end  
      end
      sum_of_array = each_quest_points.map { |id| id.to_i }.sum
      if sum_of_array > 0
        average_point = (Float(sum_of_array)/each_quest_points.length).round(2)
        category_wise_points[category.id] = average_point
      end  
    end
    category_wise_points
  end

  def update_average_point
    if PerfReviewCatg.count > 0
      total_avg = calculate_avg_point.values.sum/PerfReviewCatg.count
      self.avg = total_avg
      self.save(validate: false)
    else
      0
    end  
  end

end
