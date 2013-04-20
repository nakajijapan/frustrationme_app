# coding: utf-8
class ServiceFuman
  attr_accessor :user, :fuman

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
    @logger.warn params_item
    @logger.warn params_item[:product_id]
    @logger.warn params_fuman

    ActiveRecord::Base.transaction do

      #TODO 条件にservice_codeもいれる
      #TODO 二重で登録されているところあり
      item = Item.find_by_product_id(params_item[:product_id])

      @logger.warn item.inspect

      # create
      if item.nil?

        @logger.warn 'itemはそんざいしない'

        name = ApiBucket::Service.name(params_item[:service_code].to_i)

        @logger.warn name

        service = ApiBucket::Service.instance(:"#{name}")
        res     = service.lookup(params_item[:product_id])
        item    = res.items.first

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
        saved = item.save
        raise ActiveRecord::Rollback unless saved
      end

      @fuman = Fuman.find(:first, conditions: {user_id: @user.id, item_id: item.id})
      if @fuman.present?
        return true
      end

      # create
      params_fuman.merge!({
        user_id: @user.id,
        item_id: item.id
      })

      fuman = Fuman.new(params_fuman)
      saved = fuman.save
      raise ActiveRecord::Rollback unless saved
    end

    @fuman = fuman

    true
  end

end