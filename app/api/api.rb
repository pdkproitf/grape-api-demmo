class API < Grape::API
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers
  mount Shop::ProductApi
end
