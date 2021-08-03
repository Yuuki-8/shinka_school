class Event < ApplicationRecord
  has_many :user_events
  has_many :users, through: :user_events

  default_scope -> { order(start_date: :asc) }

  validate  :start_end_check
  validate  :deadline_start_check
  validates :title, presence: true
  validates :place, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :deadline_date, presence: true


  #時間の矛盾を防ぐ
  def start_end_check
    if self.start_date.present? && self.end_date.present?
      errors.add(:end_date, "が開始時刻を上回っています。正しく記入してください。") if self.start_date > self.end_date
    end
  end

  def deadline_start_check
    if self.deadline_date.present? && self.start_date.present?
      errors.add(:deadline_date, "が開始時刻を上回っています。正しく記入してください。") if self.start_date < self.deadline_date
    end
  end

  def notification_event_just_to_slack
    notifier = Slack::Notifier.new(
      ENV['SLACK_WEBHOOK_URL'],
      channel: "##{ENV['SLACK_CHANNEL']}",
      username: 'イベント管理者'
    )
    notifier.ping "イベント名：#{self.title}は参加者の募集を締め切りました。http://localhost:3000/events/#{self.id}"
  end

  def notification_event_before_one_hour_to_slack
    notifier = Slack::Notifier.new(
      ENV['SLACK_WEBHOOK_URL'],
      channel: "##{ENV['SLACK_CHANNEL']}",
      username: 'イベント管理者'
    )
    notifier.ping "イベント名：#{self.title}は参加者の募集締め切り1時間前です。http://localhost:3000/events/#{self.id}"
  end
end
