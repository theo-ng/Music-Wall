class ChangeColumn < ActiveRecord::Migration
  def change
    rename_column(:tracks, :vote_count, :votes_count)
  end
end
