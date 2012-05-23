class CreateCustomerEnquetes < ActiveRecord::Migration
  def self.up
    create_table :customer_enquetes, :force => true do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :city
      t.references :question
      t.boolean :situation, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :customer_enquetes
  end
end
