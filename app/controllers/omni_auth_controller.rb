class OmniAuthController < ApplicationController
  rescue_from OAuth::Unauthorized, with: Proc.new{redirect_to root_path}

  def callback
    case params['provider']
    when 'evernote'
      current_user.socials.evernote.where(username: request_auth["extra"]["raw_info"].username).
        first_or_create.update(
          uid: request_auth["uid"].to_s,
          token: request_auth["credentials"]["token"],
          token_expires: Time.at(request_auth['extra']['access_token'].params[:edam_expires].to_i).utc.to_datetime,
          verified: DateTime.now
      )
        flash[ :notice ] = "You've successfully Authorized with Evernote"
        session[:return_to] ||= root_path
    end
    redirect_to session.delete(:return_to) || root_path
  end

  def oauth_failure
    redirect_to root_path
  end

  private
  def request_auth
    request.env['omniauth.auth']
  end
end
