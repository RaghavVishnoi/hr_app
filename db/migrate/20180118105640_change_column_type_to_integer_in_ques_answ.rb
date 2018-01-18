class ChangeColumnTypeToIntegerInQuesAnsw < ActiveRecord::Migration[5.0]
  def change
  	change_column :ques_answs,:answer,'float USING CAST(answer AS float)'
  end
end
