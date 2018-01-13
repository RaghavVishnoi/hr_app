class QuesAnsw < ApplicationRecord
  belongs_to :review, class_name: 'PerfReview', foreign_key: 'review_id'
  has_many :questions, class_name: 'ReviewCatgQuest', foreign_key: 'question_id'
end
