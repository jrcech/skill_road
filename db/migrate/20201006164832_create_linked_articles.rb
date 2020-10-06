class CreateLinkedArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :linked_articles do |t|
      t.references :next_article, references: :linked_articles, foreign_key: { to_table: :articles}
      t.references :previous_article, references: :linked_articles, foreign_key: { to_table: :articles}

      t.timestamps
    end
  end
end
