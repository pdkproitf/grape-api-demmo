module Shop
  class SessionApi < Grape::API
    prefix  :api
    version 'v1', using: :accept_version_header

    resource :sessions do
# => /api/v1/session/
      desc "login" #, entity: Entities::ProductWithRoot
      # => this take care of parametter validation
      params do
        requires :user, type: Hash do
          requires :email, type: String, desc: "User's Email"
          requires :password,  type: String, desc: "password"
        end
      end
      post 'sessions' do
        desc "Authenticate user"
        post "login" do
          @user = User.find_for_authentication(email: params[:email])
          if @user && @user.valid_password?(params[:password])
            sign_in @user
          else
            error!('401 Unauthorized!', 401)
          end
        end
      end
# => /api/v1/session/:id
      desc 'Destroy a user'
      params do
        requires :id, type: Integer, desc: 'user id'
        requires :email, type: String, desc: "User's Email"
      end

      delete ':id' do
        user = User.find(params[:id])
        # user.generate_authentication_token!
        # user.save
      end
    end
  end
end
