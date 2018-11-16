class Task < ApplicationRecord
  # belongs_to :user
  validates :title, presence: true
  attr_accessor :date_range

  def all_day_task?
      self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end
end
