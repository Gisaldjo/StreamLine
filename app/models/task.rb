class Task < ApplicationRecord
  belongs_to :user

  CALENDAR_ID = 'primary'
  def self.get_event task
      event = {
      summary: task.title,
      description: task.description,
      start: task.start_date,
      end: task.end_date,
      sendNotifications: true,
      reminders: {
          use_default: true
      }
      }

      event[:id] = task.event if task.event

      event
  end

  def self.get_google_calendar_client
      client = Google::Apis::CalendarV3::CalendarService.new
      
      return unless (@current_user.present? && @current_user.oauth_token.present? && @current_user.oauth_refresh_token.present?)
      secrets = Google::APIClient::ClientSecrets.new({
        "web" => {
            "access_token" => @current_user.oauth_token,
            "refresh_token" => @current_user.oauth_refresh_token,
            "client_id" => ENV["581915896146-qi2sh14npl5ogn01f9iumibcou8ktilp.apps.googleusercontent.com"],
            "client_secret" => ENV["P_Biu40zKF_QSykZL7Kj38vM"]
        }
      })
      

      
      begin
        client.authorization = secrets.to_authorization
        client.authorization.grant_type = "refresh_token"

        if @current_user.expired?
            client.authorization.refresh!
            @current_user.update_attributes(
              oauth_token: client.authorization.access_token,
              oauth_refresh_token: client.authorization.refresh_token,
              oauth_expires_at: client.authorization.expires_at.to_i
            )
        end
        rescue => e
        raise e.message
      end
      client
  end

  def self.get_events
      client = self.get_google_calendar_client
      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client
      # debugger
      service.list_events(CALENDAR_ID)
  end
end
