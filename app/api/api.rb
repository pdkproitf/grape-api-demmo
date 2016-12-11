class API < Grape::API
  mount Shop::ProductApi
end
