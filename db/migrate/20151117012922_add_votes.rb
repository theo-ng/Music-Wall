class AddVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.references :track
    end
  end
end
