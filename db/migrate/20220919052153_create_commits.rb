# frozen_string_literal: true

class CreateCommits < ActiveRecord::Migration[6.1]
  def change
    create_table :commits do |t|
      t.references :contributor
      t.text :hash
      t.date :committed_on
      t.text :message

      t.timestamps
    end
  end
end
