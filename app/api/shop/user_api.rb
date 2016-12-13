module Shop
  class UserApi < Grape::API
    prefix  :api
    version 'v1', using: :accept_version_header

     use ApiErrorHandler

    resource :users do
# => /api/v1/users
      desc "show all users" #, entity: Shop::Entities::ProductWithRoot
      get do
        users = User.all
        # present({ users: products }, with: Entities::ProductWithRoot)
      end
# => /api/v1/users/:id
      desc "get a user" #, entity: Entities::ProductWithRoot
      get ':id' do
        user = User.find(params[:id])
      end
# => /api/v1/users/
      desc "create new user" #, entity: Entities::ProductWithRoot
      # => this take care of parametter validation
      params do
        requires :user, type: Hash do
          requires :email, type: String, desc: "User's Email"
          requires :password,  type: String, desc: "password"
          requires :password_confirmation,  type: String, desc: "password_confirmation"
        end
      end
      # => this takes care of creating product
      post 'users' do
        user = User.new(declared(params, include_missing: false)[:user])
        if user.save
        else
        end
        # present product , with: Entities::ProductEntity
      end
# => /api/v1/product/:id
      desc 'Update a user' #, entity: Entities::ProductWithRoot
      params do
        requires :user, type: Hash do
          requires :email, type: String, desc: "User's Email"
        end
      end
      put ':id' do
        user = User.find(params[:id])
        user.update!({
            email: params[:email]
            })
      end
# => /api/v1/product/:id
      desc 'Destroy a user'
      params do
        requires :id, type: Integer, desc: 'user id'
      end

      delete ':id' do
        user = User.find(params[:id])
        user.destroy!
      end
    end
  end
end
