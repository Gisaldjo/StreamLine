# require "google/apis/calendar_v3"
# require "google/api_client/client_secrets.rb"

class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  attr_accessor :date_range

  def all_day_task?
      self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end
end
