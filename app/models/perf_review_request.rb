class PerfReviewRequest < ApplicationRecord
  belongs_to :employee
  has_many :perf_reviews, class_name: 'PerfReview', foreign_key: 'request_id'
  has_many :reviewers, class_name: 'PerfReviewReviewer', foreign_key: 'reviewer_id'

  after_create :default_values

  def reviewee
    Employee.find(reviewee_id)
  end

  def reviewer_name
    self.reviewers.pluck(:reviewer_id).map { | id | Employee.find(id).name }.to_sentence
  end

  def self.notify_review_request
      perf_review_requests = PerfReviewRequest.where('due_date >= ?  AND sent_reminder = ?',Date.today,false)
      perf_review_requests.each do |perf_review_request|
        if perf_review_request.due_date <= (Date.today + 1.day)
          reviewers = perf_review_request.reviewers
          reviewers.each do |reviewer|
            reviewee = Employee.find(perf_review_request.reviewee_id)
            ReviewRequestMailer.notify(reviewer.employee.email,reviewee,perf_review_request).deliver_now
          end
          perf_review_request.update(sent_reminder: true) 
        end
      end
    end

  def reviewers
    PerfReviewReviewer.where(perf_review_request_id: self.id)
  end
  
  def reviews(reviewer)
    data = {}
    perf_review = PerfReview.find_by(request_id: reviewer.id)
    if perf_review.present?
      if perf_review.present?
        data[:review_date] = perf_review.created_at.strftime("%d %b,%Y")
        data[:review_avg] = perf_review.avg
      else
        data[:review_date] = 'Not Available'
        data[:review_avg] = 'Not Available'
      end
    else
      data[:review_date] = 'Pending'
      data[:review_avg] = 'Pending'
    end
    data
  end

  def avg_on_category
    if self.reviewers.map{|reviewer| reviewer.perf_review}.compact.present?
      category_wise_points = Hash.new
      PerfReviewCatg.all.each do |category|
        question_ids = category.questions.pluck(:id)
        categories_points = QuesAnsw.where('review_id IN (?) AND question_id IN (?) AND answer > 0', self.reviewers.map{|reviewer| reviewer.perf_review.id if reviewer.perf_review.present?}.compact,question_ids).pluck(:answer)
        if categories_points.length > 0
          category_wise_points[category.id] = (categories_points.sum(&:to_f)/categories_points.length).round(2)
        else
          category_wise_points[category.id] = 0
        end
      end
      total_avg_category = ((category_wise_points.values.sum)/category_wise_points.values.length).round(2)
    else
      'Awaiting..'
    end
  end

  def master_request_avg
    if self.reviewers.map{|reviewer| reviewer.perf_review}.compact.present?
      category_wise_points = Hash.new
      PerfReviewCatg.all.each do |category|
        question_wise_points = Hash.new
        category.questions.each do |question|
          questions_points = QuesAnsw.where('review_id IN (?) AND question_id = ? AND answer > 0', self.reviewers.map{|reviewer| reviewer.perf_review.id if reviewer.perf_review.present?}.compact, question.id).pluck(:answer)
          question_wise_points[question.id] = (questions_points.sum(&:to_f)/questions_points.length)
        end
        category_wise_points[category.id] = (question_wise_points.values.sum/question_wise_points.values.length)
      end
      total_avg_category = ((category_wise_points.values.sum)/category_wise_points.values.length).round(2)
    else
      'Pending'
    end
  end

  def total_points_master
    if self.reviewers.map{|reviewer| reviewer.perf_review}.compact.present?
      category_wise_points = Hash.new
      PerfReviewCatg.all.each do |category|
        question_wise_points = Hash.new
        category.questions.each do |question|
          questions_points = QuesAnsw.where(review_id: self.reviewers.map{|reviewer| reviewer.perf_review.id if reviewer.perf_review.present?},question_id: question.id).pluck(:answer)
          question_wise_points[question.id] = (questions_points.sum(&:to_f)/questions_points.length)
        end
        category_wise_points[category.id] = (question_wise_points.values.sum/question_wise_points.values.length)
      end
      category_wise_points
    else
      'Pending'
    end
  end

  def pending_reviewer
    reviewers = self.reviewers
    pending_revr = []
    reviewers.each{|reviewer| pending_revr.push(reviewer.employee) if reviewer.perf_review.nil?}
    pending_revr
  end

  def reviewed_reviewers
    reviewers = self.reviewers
    reviewed_revr = []
    reviewers.each{|reviewer| reviewed_revr.push(reviewer.employee) if reviewer.perf_review.present?}
    reviewed_revr
  end

  private
    def default_values
      self.created_at ||= DateTime.current
    end

end

