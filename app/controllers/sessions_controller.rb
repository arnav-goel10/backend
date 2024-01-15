class SessionsController < ApplicationController
  def new
  end

  def create
    time = Time.now + 24.hours.to_i
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      payload = { user_id: user.id }
      jwt = JWT.encode(payload, Rails.application.secrets.secret_key_base,exp: time.strftime("%m-%d-%Y %H:%M"))
      render json: { jwt: jwt }, status: :created
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    render json: { message: 'Signed out successfully' }
  end
end
