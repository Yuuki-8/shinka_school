class TemporarySchedule < ApplicationRecord
  belongs_to :mentor


  def to_ja_wday
    wday = { '0': '日', '1': '月', '2': '火', '3': '水', '4': '木', '5': '金', '6': '土' }
    wday[:"#{self.start_time.wday.to_s}"]
  end
end
