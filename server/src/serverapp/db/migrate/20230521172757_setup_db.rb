class SetupDb < ActiveRecord::Migration[7.0]
  def change
    create_table :TodoItem do |t|
      t.string :text, null:false 
      t.integer :created_by, null:false
      t.integer :sort_order, null:false  
      t.boolean :check, null:false, default:false  
      t.boolean :question, null:false, default:false  
      t.boolean :danger, null:false, default:false  
      t.boolean :blocked, null:false, default:false 
      t.integer :parent_id

      create_table :User do |t|
        t.string :name, null:false 
        t.string :email, null:false
      end 
    end 
  end
end
