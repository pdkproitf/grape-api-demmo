Rails.application.routes.draw do
  # mount Shop::ProductApi => '/'
  mount API => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
end
