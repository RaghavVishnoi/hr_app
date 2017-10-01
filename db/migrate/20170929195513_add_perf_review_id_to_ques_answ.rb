class AddPerfReviewIdToQuesAnsw < ActiveRecord::Migration[5.0]
  def change
    add_column :ques_answs, :review_id, :integer
  end
end
