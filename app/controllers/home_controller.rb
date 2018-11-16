require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

class HomeController < ApplicationController
  def show
    @tasks = Task.all
    @notes = Note.all

    respond_to do |format|
      format.html
      format.js { @currNote = params[:id] }
    end
  end
  def login
    render "layouts/login"
  end
  def profile
    render "layouts/profile"
  end
  def settings
    render "layouts/settings"
  end
  def edit_user
  end
end
