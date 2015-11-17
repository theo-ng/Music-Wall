class AddCounterCache < ActiveRecord::Migration
  def change
    change_table :tracks do |t|
      t.integer 'vote_count'
    end
  end
end
