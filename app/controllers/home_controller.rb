class HomeController < ApplicationController
  def show
    @notes = Note.all
    @events = Event.all
  end
  def login
    render "layouts/login"
  end
end
