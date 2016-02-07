# Support for step definitions in merge_articles feature

And /^the following articles are present:$/ do |articles|
	articles.hashes.each do |article|
		Article.create! article
	end
end

And /^article "([^\"]+)" has ([1-9]) comments?$/ do |article_title, comment_count|
  article = Article.find_by_title article_title
  
  comment_count.to_i.times do |num|
    article.add_comment({ :body => "#{article_title} - Comment #{num}" })
  end
end
