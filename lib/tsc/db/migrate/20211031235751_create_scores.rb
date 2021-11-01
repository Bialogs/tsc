class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: true
      t.belongs_to :channel, null: false, foreign_key: true, index: true
      t.float :total_score, default: 0.0
      t.float :current_average, default: 0.0
      t.integer :messages_sent, default: 0
    end
  end
end
