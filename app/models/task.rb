# require "google/apis/calendar_v3"
# require "google/api_client/client_secrets.rb"

class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  attr_accessor :date_range

  def all_day_task?
    self.start.localtime == self.start.localtime.midnight && self.end.localtime == self.end.localtime.midnight ? true : false
  end

  def changed_only_color task_params
    return true if title == task_params["title"] && start == task_params["start"].to_time.utc && self.end == task_params["end"].to_time.utc && description == task_params["description"] && color != task_params["color"]
  end
end
