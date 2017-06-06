class AddFileToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :file, :string
  end
end
