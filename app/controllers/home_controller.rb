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
