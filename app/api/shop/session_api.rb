module Shop
  class SessionApi < Grape::API
    prefix  :api
    version 'v1', using: :accept_version_header

    resource :sessions do
# => /api/v1/session/
      desc "Authenticate user and return user object / access token"

      params do
       requires :email, type: String, desc: "User email"
       requires :password, type: String, desc: "User Password"
      end

      post do
       email = params[:email]
       password = params[:password]

       if email.nil? or password.nil?
         error!({error_code: 404, error_message: "Invalid Email or Password."},401)
         return
       end

       user = User.where(email: email.downcase).first
       if user.nil?
         error!({error_code: 404, error_message: "Invalid Email or Password."},401)
         return
       end

       if !user.valid_password?(password)
         error!({error_code: 404, error_message: "Invalid Email or Password."},401)
         return
       else
         current_user = user
         {status: 'ok', token: user.auth_token}.to_json
       end
      end

      desc 'Destroy the access token'
      params do
        requires :auth_token, type: String, desc: 'User Access Token'
      end
      delete ':auth_token' do
        auth_token = params[:auth_token]
        user = User.where(auth_token: auth_token).first
        if user.nil?
          error!({error_code: 404, error_message: 'Invalid access token.'}, 401)
          return
        else
          user.generate_authentication_token!
          user.save
          {status: 'ok'}
        end
      end
    end
  end
end
