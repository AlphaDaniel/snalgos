class CreateEditorSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :editor_sessions do |t|
      t.string :mode
      t.integer :snippet_id
    end
  end
end
