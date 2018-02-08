class PerfReviewCatg < ApplicationRecord
  has_many :questions, class_name: "ReviewCatgQuest", foreign_key: "category_id"

  def questions_points(perf_review_request)
    if perf_review_request.reviewers.map{|reviewer| reviewer.perf_review}.compact.present?
        question_wise_points = Hash.new
        self.questions.each do |question|
          questions_points = QuesAnsw.where(review_id: perf_review_request.reviewers.map{|reviewer| reviewer.perf_review.id if reviewer.perf_review.present?},question_id: question.id).pluck(:answer)
          question_wise_points[question.id] = (questions_points.sum(&:to_f)/questions_points.length)
        end
        question_wise_points
    else
      []
    end
  end

  def categories_points(perf_review_request)
    category_wise_points = Hash.new
    PerfReviewCatg.all.each do |category|
      question_ids = category.questions.pluck(:id)
      categories_points = QuesAnsw.where(review_id: perf_review_request.reviewers.map{|reviewer| reviewer.perf_review.id if reviewer.perf_review.present?},question_id: question_ids).pluck(:answer)
      if categories_points.length > 0
        category_wise_points[category.id] = (categories_points.sum(&:to_f)/categories_points.length).round(2)
      else
        category_wise_points[category.id] = 0
      end
    end
    category_wise_points
  end
end
