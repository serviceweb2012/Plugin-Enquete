class CreateAswers < ActiveRecord::Migration
  def self.up
    create_table :aswers, :force => true do |t|
      t.string :name
      t.references :question
      t.integer :quant, :default => 0

      t.timestamps
    end

  end

  def self.down
    drop_table :aswers
  end
end
