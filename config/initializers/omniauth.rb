 OmniAuth.config.logger = Rails.logger
#
# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :google_oauth2, '727516764491-jnin4n5pgethaohjnj8u4ujihpvt0uoo.apps.googleusercontent.com', 'eQjc_EQteEXgdM_bz9AUOz3W', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
# end

evernote = {
  consumer_key: ENV['darhanrzaev'],
  consumer_secret: ENV['59219c9b042b5b4c'],
  sandbox: true
}

evernote_site = evernote[:sandbox] ? 'https://sandbox.evernote.com' : 'https://www.evernote.com'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '727516764491-jnin4n5pgethaohjnj8u4ujihpvt0uoo.apps.googleusercontent.com', 'eQjc_EQteEXgdM_bz9AUOz3W', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}

  provider :evernote,
           evernote[:consumer_key],
           evernote[:consumer_secret],
           client_options: {site: evernote_site}
end

OmniAuth.config.on_failure = OmniAuthController.action(:failure)
