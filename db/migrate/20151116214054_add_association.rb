class AddAssociation < ActiveRecord::Migration
  def change
    change_table :tracks do |t|
      t.references :user
    end
  end
end
