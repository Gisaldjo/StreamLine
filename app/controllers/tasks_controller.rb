require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = get_calendar_events
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.save
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @task.update(task_params)
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
  end

  def get_calendar_events
    # Initialize Google Calendar API
    service = Google::Apis::CalendarV3::CalendarService.new
    # Use google keys to authorize
    service.authorization = google_secret.to_authorization
    # Request for a new aceess token just incase it expired
    service.authorization.refresh!
    # Get a list of calendars
    tasks_list = service.list_events(
      'primary', 
      single_events: true,
      order_by: 'startTime',
      time_min: Time.now.iso8601)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :date_range, :start, :end, :color)
    end

    def google_secret
      Google::APIClient::ClientSecrets.new(
        { "web" =>
          { "access_token" => current_user.oauth_token,
            "refresh_token" => current_user.oauth_refresh_token,
            "client_id" => Rails.application.secrets.google_client_id,
            "client_secret" => Rails.application.secrets.google_client_secret,
          }
        }
      )
    end
end
