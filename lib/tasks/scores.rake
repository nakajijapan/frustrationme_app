desc "send score data to google spreadsheet"
require 'google_drive'

namespace :batches do

  task total_scores: :environment do |t, args|
    fail 'no username' if ENV['GOOGLE_USERNAME'].blank?
    fail 'no password' if ENV['GOOGLE_PASSWORD'].blank?

    session = GoogleDrive.login(ENV['GOOGLE_USERNAME'], ENV['GOOGLE_PASSWORD'])
    spreadsheet = session.spreadsheet_by_key("0Av-NN50CHlLkdDByMWxmMXZWWVFmM3czbHFqMDY2UUE")
    worksheet = spreadsheet.worksheet_by_title(Rails.env)
    analyze_data = {
      date:           Time.now.strftime("%Y-%m-%d"),
      users_num:      User.all.count,
      items_num:      Item.all.count,
      comments_num:   Comment.all.count,
      categories_num: Category.all.count
    }
    worksheet.list.push(analyze_data)
    worksheet.save()
  end

end