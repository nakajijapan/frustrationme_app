desc "move db userinfo for rails(2013)"
require 'mysql2'
require 'nkf'

namespace :batches do
  #-----------------------------------------------------------------------------
  # data around user
  #-----------------------------------------------------------------------------
  task :move_db_userinfo => :environment do |t, args|

    include Frustrationme::Mysql

    puts "----- start -----\n"
    puts "args = #{ENV['username']}\n"

    # Users
    if ENV['username'].nil?
      users = query("select * from t_user where password <> '' order by id")
    else
      users = query("select * from t_user where password <> '' and username = '#{ENV['username']}'")
    end

    puts "------ convert #{users.count} users ------\n"

    # by the user
    users.each_with_index do |row_user, user_index|

      ActiveRecord::Base.transaction do
        puts "start #{row_user['username']}\n"

        # duplicate check
        if User.exists?(username: row_user['username'])
          puts "skip user: #{row_user['username']} exists in DB for Rails\n"
          next
        end

        row_setting = query("select * from t_setting where user_id = #{row_user['id']}").first

        # User
        user                  = User.new
        user.mode             = :social
        user.username         = row_user['username'].strip
        user.email            = row_user['mail']
        user.crypted_password = row_user['password']
        user.icon_name        = open('http://hoge.com' + row_setting['icon_name']) if row_setting['icon_name'].present?
        user.created_at       = row_user['created']
        user.updated_at       = row_user['modified']
        user.save!
        puts "finish user\n"

        # Categories
        categories_map = {}
        row_categories = query("select * from t_category where user_id = #{row_user['id']}");
        row_categories.each_with_index do |row_category, index|
          category            = Category.new
          category.user_id    = user.id
          category.name       = row_category['name']
          category.created_at = row_category['created']
          category.updated_at = row_category['modified']
          category.save!

          categories_map[row_category['id']] = category.id
          puts "finish category #{category.name}"
        end

        # Fumans
        row_fumans = query("select * from t_fuman where user_id = #{row_user['id']}");

        # show count
        puts "fumans count is #{row_fumans.count}"

        row_fumans.each_with_index do |row_fuman, index|

          # the premise item already created
          item = Item.find_by_old_id(row_fuman['item_id'])
          fuman             = Fuman.new
          fuman.user_id     = user.id
          fuman.status      = row_fuman['status']
          fuman.category_id = categories_map[row_fuman['category_id']]
          fuman.item_id     = item.id
          fuman.created_at  = row_fuman['created']
          fuman.updated_at  = row_fuman['modified']
          fuman.save!
          puts "finish fuman #{fuman.id}: #{item.title}"

          # Comment
          unless row_fuman['content'].blank?
            comment = Comment.new
            comment.user_id    = user.id
            comment.item_id    = item.id
            comment.text       = row_fuman['content']
            comment.created_at = row_fuman['created']
            comment.updated_at = row_fuman['modified']
            comment.save!
            puts "finish comment #{comment.id} : #{comment.text}"
          end
        end

        #raise ActiveRecord::Rollback # test
      end # transaction
    end
  end

  #-----------------------------------------------------------------------------
  # item
  #-----------------------------------------------------------------------------
  task :move_db_items => :environment do |t, args|

    include Frustrationme::Mysql

    puts "----- start -----\n"

    # Items
    items = query("select * from t_item order by id")

    #------------------------------------------------
    # Items
    #------------------------------------------------
    items.each_with_index do |row, index|

      ActiveRecord::Base.transaction do
        puts "start items #{index} #{row['title']}\n"

        # save
        item      = Item.new
        item.service_code = row['type']
        item.product_id   = row['product_id']
        item.url          = row['url']
        item.preview_url  = row['preview_url']
        item.title        = row['title']
        item.description  = row['description']
        item.release_date = row['date']
        item.image_s      = row['image_s']
        item.image_m      = row['image_m']
        item.image_l      = row['image_l']
        item.is_adult     = row['adult_flg']
        item.price        = row['price']
        item.created_at   = row['created']
        item.updated_at   = row['updated']
        item.old_id       = row['id']
        item.save!

        #raise ActiveRecord::Rollback
      end # transaction
    end
  end
end
