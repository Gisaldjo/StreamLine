require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

class HomeController < ApplicationController
  def show
    @tasks = Task.all
    @notes = nil
    if (!!current_user)
      @notes = current_user.notes
    end
    respond_to do |format|
      format.html
      format.js { @currNote = params[:id] }
    end
  end
end
