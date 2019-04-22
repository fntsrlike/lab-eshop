class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth = request.env["omniauth.auth"]
    provider = OAuthProvider.from_omniauth(auth)

    update_provider_token(provider, auth['credentials'])

    # Link provider with exist user
    if user_signed_in?
      message = linking(current_user, provider)
      return redirect_to(shop_path, message)
    end

    # Sign in if provider exists
    if provider.user.nil?
      session['devise.facebook_data'] = request.env['omniauth.auth']
      message = '本身份還沒與使用者綁定，請先創立帳號、或是登入既有的帳號後進行綁定。'
      redirect_to(new_user_registration_url, notice: message)
    else
      sign_in_and_redirect(provider.user, event: :authentication)
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    end
  end

  def failure
    redirect_to new_user_session_path, alert: '無法獲得驗證！'
  end

  private
  def linking(user, provider)
    if provider.user.nil?
      provider.user = user
      provider.save
      message = {notice: '綁定成功！'}
    elsif provider.user == user
      message = {notice: '已經綁定過囉！'}
    else
      message = {alert: '該身份已經被其他使用者綁定了！請先解除再重新綁定。'}
    end
  end

  def update_provider_token(provider, credentials)
    return unless provider.expired?

    provider.token = credentials['token']
    provider.expires = credentials['expires']
    if provider.expires
      provider.expires_at = Time.at(credentials['expires_at']).to_datetime
    end
    provider.save
  end
end
