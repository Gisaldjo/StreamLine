require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_google_service, only: [:index, :create, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    # debugger
    if (current_user.populated == false) 
      populate_database
      current_user.populated = true
      current_user.save
    end
    @tasks = current_user.tasks.where(start: params[:start]..params[:end])
  end

  def populate_database
    tasks = get_calendar_events
    tasks.items.each do |task|
      tmp_task = Task.new
      tmp_task.user_id = current_user.id
      tmp_task.google_id = task.id
      tmp_task.title = task.summary
      tmp_task.start = task.start.date_time
      tmp_task.end = task.end.date_time
      tmp_task.save
    end
  end

  def get_calendar_events
    # Get a list of calendars
    if current_user.last_login.nil?
      tasks_list = @service.list_events(
      'primary', 
      single_events: true,
      order_by: 'startTime',
      time_min: Time.now.iso8601,
      )
    else
      tasks_list = @service.list_events(
      'primary', 
      single_events: true,
      order_by: 'startTime',
      updated_min: current_user.last_login.iso8601
      )
    end
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
    # Request for a new aceess token just incase it expired
    @service.authorization.refresh!
    event = Google::Apis::CalendarV3::Event.new({
      start: {date_time: @task.start.iso8601},
      end: {date_time: @task.end.iso8601},
      summary: @task.title
    })

    event = @service.insert_event("primary", event)

    @task.google_id = event.id
    @task.user_id = current_user.id

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def set_google_service
      # Initialize Google Calendar API
      @service = Google::Apis::CalendarV3::CalendarService.new
      # Use google keys to authorize
      @service.authorization = google_secret.to_authorization
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :date_range, :start, :end, :color)
    end
end
