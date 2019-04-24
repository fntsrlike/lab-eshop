class MessengerProvider < Facebook::Messenger::Configuration::Providers::Base
  def valid_verify_token?(verify_token)
    verify_token == ENV['FACEBOOK_VERIFY_TOKEN']
  end

  def app_secret_for(*)
    ENV.fetch('FACEBOOK_SECRET')
  end

  def access_token_for(recipient)
    Subscription.find_by(oid: recipient['id']).token
  end

  def fetch_app_secret_proof_enabled?
    ENV.fetch('FACEBOOK_APP_SECRET_PROOF_ENABLED') == 'true'.freeze
  end
end
