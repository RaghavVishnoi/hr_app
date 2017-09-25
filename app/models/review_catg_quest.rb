class ReviewCatgQuest < ApplicationRecord
  has_many :answers, class_name: "QuesAnsw", foreign_key: "question_id"
end
