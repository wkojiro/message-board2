class AddColumnToMessage < ActiveRecord::Migration
  def change
    
    #追加
    add_column :messages, :description, :string
    
  end
end
