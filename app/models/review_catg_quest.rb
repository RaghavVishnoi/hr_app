class ReviewCatgQuest < ApplicationRecord
  has_many :answers, class_name: 'QuesAnsw', foreign_key: 'question_id'

  def answer(review_id)
    self.answers.where(review_id: review_id).first.try(:answer)
  end
end
