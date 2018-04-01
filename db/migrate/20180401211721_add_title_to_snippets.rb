class AddTitleToSnippets < ActiveRecord::Migration[5.1]
  def change
    add_column :snippets, :title, :string
  end
end

