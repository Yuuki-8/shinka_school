namespace :attendance do
  desc '勤務終了時刻が入ってない場合にデフォルト値をセット'
  task end_time_add: :environment do
    puts "attendance:end_time_add... start"
    attendances = Attendance.where(end_time: nil)
    puts "該当件数：#{attendances.count}件"
    attendances.map do |attendance|
      attendance.end_time = attendance.start_time.since(8.hours)
      attendance.save!
    end
    puts "attendance:end_time_add... end"
  end
end