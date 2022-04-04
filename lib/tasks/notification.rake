# frozen_string_literal: true
namespace :notification do
  desc "イベントの締め切り時刻に通知"
  task event_just_to_slack: :environment do
    puts "notification:event_just_to_slack... start"
    events = Event.where("deadline_date <= ?", Time.zone.now)
    puts "対象件数：#{events.count}件"
    if events.present?
	    events.map do |event|
        unless event.is_just_notification
          event.notification_event_just_to_slack # 処理実行
          event.is_just_notification = true
          event.save!
        end
      end
    end
    puts "notification:event_just_to_slack... end"
  end

  desc "イベントの締め切り時刻3時間前に通知"
  task event_before_to_slack: :environment do
    puts "notification:event_before_to_slack... start"
    events = Event.where("deadline_date = ?", 3.hours.since)
    byebug
    puts "対象件数：#{events.count}件"
    if events.present?
	    events.map do |event|
        unless event.is_before_one_hour_notification
          event.notification_event_before_to_slack # 処理実行
          event.is_before_one_hour_notification = true
          event.save!
        end
      end
    end
    puts "notification:event_before_to_slack... end"
  end
end