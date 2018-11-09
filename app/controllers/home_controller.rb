class HomeController < ApplicationController
  def show
    @notes = Note.all
    @events = Event.all
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
end
