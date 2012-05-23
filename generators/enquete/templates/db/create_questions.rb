class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions, :force => true do |t|
      t.string :name
      t.boolean :cadastro
      t.boolean :situation, :default => true

      t.timestamps
    end

  end

  def self.down
    drop_table :questions
  end
end
