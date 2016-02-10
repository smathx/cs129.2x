# Support for step definitions in merge_articles feature

# | name | profile |

And /^the following users are present:$/ do |users|
	users.hashes.each do |user|
		User.create!(
		  :login => user['name'], 
		  :password => "12345",
		  :name => user['name'],
		  :email => "#{user['name'].downcase}@test.com",
		  :profile_id => Profile.find_by_label("#{user['profile']}").id)
	end
end

# | title | body | author |

And /^the following articles are present:$/ do |articles|
	articles.hashes.each do |article|
		article['user_id'] = User.find_by_name(article['author']).id
		Article.create!(article).publish!
	end
end

And /^article "([^\"]+)" has ([1-9]) comments?$/ do |article_title, comment_count|
  article = Article.find_by_title article_title
  
  comment_count.to_i.times do |num|
    article.add_comment({ :body => "#{article_title} - Comment #{num+1}", :author => "Anonymous" }).save
  end
end

When /^(?:|I )fill in "([^"]*)" with the "([^"]*)" id$/ do |field, value|
  fill_in(field, :with => Article.find_by_title(value).id)
end
