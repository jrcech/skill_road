# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Article < ApplicationRecord
  belongs_to :user

  has_many :linked_next_article, foreign_key: :previous_article_id, class_name: 'LinkedArticle'
  has_many :next_articles, through: :linked_next_article, source: :next_article

  has_many :linked_previous_article, foreign_key: :next_article_id, class_name: 'LinkedArticle'
  has_many :previous_articles, through: :linked_previous_article, source: :previous_article
end
