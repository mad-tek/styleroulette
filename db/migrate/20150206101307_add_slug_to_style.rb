class AddSlugToStyle < ActiveRecord::Migration
  def change
    add_column :styles, :slug, :string
  end
end
