class CreateChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :channels do |t|
      t.timestamps
      t.string :name, null: false
    end
  end
end
