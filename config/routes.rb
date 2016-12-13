Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # devise_for :users
  # mount Shop::ProductApi => '/'
  mount API => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
end
