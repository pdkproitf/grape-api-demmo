Rails.application.routes.draw do
  devise_for :users
  # mount Shop::ProductApi => '/'
  mount API => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
end
