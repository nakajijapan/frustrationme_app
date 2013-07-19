# coding: utf-8
class ServiceFuman
  attr_accessor :user, :fuman, :service

  def initialize(user)
    @user = user
    @logger = ActionController::Base.logger
  end

  # item[:service_code]
  # item[:product_id]
  # fuman[:status]
  # fuman[:category_id]
  # fuman[:content]
  def create_with_item(params_item, params_fuman)
    ActiveRecord::Base.transaction do

      #TODO 条件にservice_codeもいれる
      #TODO 二重で登録されているところあり
      item = Item.find_by_product_id(params_item[:product_id])

      # create
      if item.nil?

        name = ApiBucket::Service.name(params_item[:service_code].to_i)

        if Rails.env.test?
          item     = @service.lookup(params_item[:product_id])
        else
          service = ApiBucket::Service.instance(:"#{name}")
          res     = service.lookup(params_item[:product_id])
          item    = res.items.first
        end

        params_item.merge!({
          url:          item.detail_url,
          preview_url:  item.preview_url,
          title:        item.title,
          description:  item.description,
          release_date: item.release_date,
          image_s:      item.image[:l][:url],
          image_m:      item.image[:l][:url],
          image_l:      item.image[:l][:url],
          price:        item.price
        })

        item = Item.new(params_item)
        raise ActiveRecord::Rollback unless item.save
      end

      @fuman = Fuman.where(user_id: @user.id).where(item_id: item.id).first
      return true if @fuman.present?

      # create
      params_fuman.merge!({
        user_id: @user.id,
        item_id: item.id
      })

      @fuman = Fuman.new(params_fuman)
      raise ActiveRecord::Rollback unless @fuman.save
    end

    true
  end

  # item[:service_code]
  # item[:title]
  # item[:url]
  # item[:image_l]
  # fuman[:status]
  # fuman[:category_id]
  def create_with_item_using_frustration(params_item, params_fuman)

    ActiveRecord::Base.transaction do
      params_item.merge!({
        price:    nil,
        image_l:  params_item[:image_l],
        image_m:  params_item[:image_l],
        image_s:  params_item[:image_l]
      })

      item = Item.new(params_item)
      raise ActiveRecord::Rollback unless item.save

      # create
      params_fuman.merge!({
        user_id: @user.id,
        item_id: item.id
      })

      @fuman = Fuman.new(params_fuman)
      raise ActiveRecord::Rollback unless @fuman.save
    end

    true
  end
end