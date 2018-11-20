# require "google/apis/calendar_v3"
# require "google/api_client/client_secrets.rb"

class Task < ApplicationRecord
  # belongs_to :user
  validates :title, presence: true
  attr_accessor :date_range

  def all_day_task?
      self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end

  # def get_google_calendar_client
  #   CALENDAR_ID = 'primary'

  #   client = Google::Apis::CalendarV3::CalendarService.new
  #   return unless (@current_user.present? && @current_user.access_token.present? && @current_user.refresh_token.present?)

  #   secrets = Google::APIClient::ClientSecrets.new({
  #     "web" => {
  #       "access_token" => @current_user.oauth_token,
  #       "refresh_token" => @current_user.oauth_refresh_token,
  #       "client_id" => ENV["727516764491-jnin4n5pgethaohjnj8u4ujihpvt0uoo.apps.googleusercontent.com"],
  #       "client_secret" => ENV["eQjc_EQteEXgdM_bz9AUOz3W"]
  #     }
  #   })
  #   begin
  #     client.authorization = secrets.to_authorization
  #     client.authorization.grant_type = "refresh_token"

  #     if @current_user.expired?
  #       client.authorization.refresh!
  #       @current_user.update_attributes(
  #         oauth_token: client.authorization.access_token,
  #         oauth_refresh_token: client.authorization.refresh_token,
  #         oauth_expires_at: Time.at(client.authorization.expires_at)
  #       )
  #     end
  #   rescue => e
  #     raise e.message
  #   end
  #   client
  # end

  # def get_tasks
  #   @client = get_google_calendar_client
  #   @service = 
  #   @client.execute(api_method: @service.freebusy.query, 
  #   body: JSON.dump({timeMin: start_time,
  #   timeMax: end_time,
  #   timeZone: "EST",
  #   items: [calendar_id]}),
  #   headers: {'Content-Type' => 'application/json'})
  # end

end
