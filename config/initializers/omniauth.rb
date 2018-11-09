OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '581915896146-qi2sh14npl5ogn01f9iumibcou8ktilp.apps.googleusercontent.com', 'P_Biu40zKF_QSykZL7Kj38vM', {
    client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}},
    access_type: "offline", 
    prompt: "consent",
    select_account: true,
    scope: 'userinfo.email, calendar'
  }
end