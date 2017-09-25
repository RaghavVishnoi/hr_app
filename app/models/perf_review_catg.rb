class PerfReviewCatg < ApplicationRecord
  has_many :questions, class_name: "ReviewCatgQuest", foreign_key: "category_id"
end
