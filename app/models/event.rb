class Event < ApplicationRecord
  mount_uploader :image,ImageUploader
  has_many :user_events,dependent: :destroy
  has_many :users,through: :user_events
  validates :title,presence:true
  validates :place,presence:true
  validates :description,presence:true
  validates :start_date,presence:true
  validates :end_date,presence:true
  validates :deadline_date,presence:true
  validate :start_end_check
  validate :deadline_start_check


  def start_end_check
    if self.start_date.present? && end_date.present?
      errors.add(:end_date, "が開始時刻を上回っています。正しく記入してください。") if self.start_date > self.end_date
    end
  end
  def deadline_start_check
    if self.deadline_date.present? && start_date.present?
      errors.add(:deadline_date, "が開始時刻を上回っています。正しく記入してください。") if self.start_date < self.deadline_date
    end
  end
  def notification_event_just_to_slack
    notification_to_slack("イベント名：#{self.title}は参加者の募集を締め切りました。http://localhost:3001/events/#{self.id}")
  end
  def notification_event_before_to_slack
    notification_to_slack("イベント名：#{self.title}は参加者の募集を締め切り3時間前です。http://localhost:3001/events/#{self.id}")
  end
  def notification_to_slack(message)
    notifier = Slack::Notifier.new( # この中で通知内容の設定
    ENV["SLACK_WEBHOOK_URL"], #slackと連携するためのurl
    channel: "##{ENV['SLACK_CHANNEL']}", # どのチャンネルに通知するか
    username: "イベント管理者" # どの名前で通知するか。ここは自分の名前で置き換えてみてください。
    )
    notifier.ping message # この一行で通知が飛ぶ。
  end
end

