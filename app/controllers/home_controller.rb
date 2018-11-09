class HomeController < ApplicationController
  def show
    @tasks = Task.all
    @notes = Note.all
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
