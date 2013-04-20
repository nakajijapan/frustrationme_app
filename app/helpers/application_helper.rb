module ApplicationHelper
  def icon_image_tag(src, options={})
    src = '/assets/users/icon.gif' if src.blank? or src.to_s.index('missing')
    image_tag(src, options)
  end
end
