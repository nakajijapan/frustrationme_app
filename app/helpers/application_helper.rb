module ApplicationHelper
  def icon_image_tag(src, options={})
    src = '/assets/users/icon.gif' if src.blank?
    image_tag(src, options)
  end
end
