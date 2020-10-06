# == Schema Information
#
# Table name: linked_articles
#
#  id                  :bigint           not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  next_article_id     :bigint
#  previous_article_id :bigint
#
# Indexes
#
#  index_linked_articles_on_next_article_id      (next_article_id)
#  index_linked_articles_on_previous_article_id  (previous_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (next_article_id => articles.id)
#  fk_rails_...  (previous_article_id => articles.id)
#
FactoryBot.define do
  factory :linked_article do
    article { nil }
  end
end
