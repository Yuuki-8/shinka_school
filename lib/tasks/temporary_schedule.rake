# frozen_string_literal: true

namespace :temporary_schedule do
  desc "初回メンターの仮のスケジュール3ヶ月分作成"
  task first_make_and_delete_schedules: :environment do
    puts "temporary_schedule:first_make_and_delete_schedules... start"
    mentors = Mentor.all
    puts "対象メンター数：#{mentors.count}件,仮スケジュール作成開始"

    temporary_schedules = []
    mentors.map do |mentor|
      settings = mentor.mentor_setting.mentor_schedule_settings.group_by { |s| s.weekday_code } # mentor毎の設定全てを呼び出し
      beginning_month = Date.today.beginning_of_month # 開始月の月初
      end_month = beginning_month.since(3.months).end_of_month.to_date # 3ヶ月後の月末
      (beginning_month..end_month).each do |date|
        settings[MentorScheduleSetting.weekday_codes.invert[date.wday]].map do |setting|
          setting.start_time.to_i.step(setting.end_time.to_i, 3600).map { |m| Time.zone.at(m).strftime("%F %T") }.map do |time|
            next if time.in_time_zone == setting.end_time
            # settingのstart_timeからend_timeまでの時間で1時間毎にずらしてインスタンスを作成してtemporary_schedulesに入れる
            start_time = "#{date} #{time.to_datetime.strftime("%H:%M")}"
            end_time = "#{date} #{time.to_datetime.since(1.hour).strftime("%H:%M")}"
            temporary_schedules << TemporarySchedule.new(mentor: setting.mentor_setting.mentor, start_time: start_time, end_time: end_time)
          end
        end
      end
    end
    puts "仮スケジュール登録件数：#{temporary_schedules.count}件"
    TemporarySchedule.import(temporary_schedules)
    puts "仮スケジュールを#{temporary_schedules.count}件、作成完了しました"
    puts "temporary_schedule:first_make_and_delete_schedules... end"
  end
  desc "月初0:00にメンターの仮のスケジュール1ヶ月分作成&過去のデータ削除"
  task batch_make_and_delete_schedules: :environment do
    puts "temporary_schedule:batch_make_and_delete_schedules... start"
    mentors = Mentor.all
    puts "対象メンター数：#{mentors.count}件,仮スケジュール作成開始"

    temporary_schedules = []
    mentors.map do |mentor|
      settings = mentor.mentor_setting.mentor_schedule_settings.group_by { |s| s.weekday_code } # mentor毎の設定全てを呼び出し
      beginning_month = Date.today.since(3.months).beginning_of_month # 月初
      end_month = beginning_month.end_of_month # 月末
      (beginning_month..end_month).each do |date|
        settings[MentorScheduleSetting.weekday_codes.invert[date.wday]].map do |setting|
          setting.start_time.to_i.step(setting.end_time.to_i, 3600).map { |m| Time.zone.at(m).strftime("%F %T") }.map do |time|
            next if time.in_time_zone == setting.end_time
            # settingのstart_timeからend_timeまでの時間で1時間毎にずらしてインスタンスを作成してtemporary_schedulesに入れる
            start_time = "#{date} #{time.to_datetime.strftime("%H:%M")}"
            end_time = "#{date} #{time.to_datetime.since(1.hour).strftime("%H:%M")}"
            temporary_schedules << TemporarySchedule.new(mentor: setting.mentor_setting.mentor, start_time: start_time, end_time: end_time)
          end
        end
      end
    end
    puts "仮スケジュール登録件数：#{temporary_schedules.count}件"
    TemporarySchedule.import(temporary_schedules)
    puts "仮スケジュールを#{temporary_schedules.count}件、作成完了しました"
    puts "過去の仮スケジュール削除開始"
    destroy_targets = TemporarySchedule.where("end_time <= ?", Date.today.ago(1.month).end_of_month)
    puts "削除対象件数：#{destroy_targets}件を削除します"
    destroy_targets.delete_all
    puts "過去の仮スケジュール削除終了"
    puts "temporary_schedule:batch_make_and_delete_schedules... end"
  end
end
