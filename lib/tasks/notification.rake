namespace :notification do
  desc 'イベントの締め切り時刻1時間前に通知'
  task event_before_one_hour_to_slack: :environment do
    events = Event.where("deadline_date >= ? and deadline_date <= ?", Time.zone.now + 8.hour, Time.zone.now + 9.hour)
    if events.present?
      events.map do |event|
        unless event.is_before_one_hour_notification
          event.notification_to_slack_before_one_hour
          event.is_before_one_hour_notification = true
          event.save!
        end
      end
    end
  end
  desc 'イベントの締め切り時刻に通知'
  task event_just_to_slack: :environment do
    events = Event.where("deadline_date <= ?", Time.zone.now + 9.hour)
    if events.present?
      events.map do |event|
        unless event.is_just_notification
          event.notification_to_slack
          event.is_just_notification = true
          event.save!
        end
      end
    end
  end
end