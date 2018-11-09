class HomeController < ApplicationController
  def show
    @tasks = Task.all
    @notes = Note.all
  end
  def login
    render "layouts/login"
  end
end
