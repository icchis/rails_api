class CreatePostComments < ActiveRecord::Migration
   def change
      create_table :post_comments, id: false do |t|
         t.integer  :post_id
         t.integer  :comment_id
         t.references :post, index: true
         t.references :comment, index: true
      end
   end
end
