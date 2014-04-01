class AddSubredditToBlogAppPost < ActiveRecord::Migration
  def change
    add_column :blog_app_posts, :subreddit, :string  
  end
end
