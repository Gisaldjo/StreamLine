OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '727516764491-jnin4n5pgethaohjnj8u4ujihpvt0uoo.apps.googleusercontent.com', 'eQjc_EQteEXgdM_bz9AUOz3W', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end