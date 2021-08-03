namespace :attendance do
  desc '勤務終了時刻が入ってない場合にデフォルト値をセット'
  task end_time_add: :environment do
    attendances = Attendance.where(end_time: nil)
    attendances.map do |attendance|
      attendance.end_time = attendance.start_time.since(8.hours)
      attendance.save!
    end
  end
end