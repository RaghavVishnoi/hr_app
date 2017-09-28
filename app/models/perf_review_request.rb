class PerfReviewRequest < ApplicationRecord
  belongs_to :employee
  serialize :reviewer_id, Array

  def reviewee
    Employee.find(reviewee_id)
  end

  def reviewers
    self.reviewer_id.map { |id| Employee.find(id.to_i).email }.to_sentence
  end

end

