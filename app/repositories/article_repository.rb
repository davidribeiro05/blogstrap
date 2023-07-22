class ArticleRepository
  def find_articles_by_category(category_id, limit)
    Article.includes(%i[user category])
           .filter_by_category(category_id)
           .desc_order_by_created_at
           .first(limit)
  end

  def articles_without_highlits(highlights_id, category_id, current_page)
    Article.includes(%i[user])
           .without_highlights(highlights_id)
           .filter_by_category(category_id)
           .desc_order_by_created_at
           .page(current_page)
  end
end
