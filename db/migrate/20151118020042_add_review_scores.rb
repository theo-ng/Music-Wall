class AddReviewScores < ActiveRecord::Migration
  def change
    change_table :reviews do |t|
      t.integer :score
    end
  end
end
