class HomeController < ApplicationController
  def show
    @tasks = Task.all
  end
  def login
    render "layouts/login"
  end
end
