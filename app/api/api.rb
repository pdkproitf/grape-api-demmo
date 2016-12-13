require 'grape-swagger'
class API < Grape::API
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers
  mount Shop::ProductApi
  mount Shop::UserApi
  add_swagger_documentation(
    api_version: 'v1',
    hide_doccumentation_path: false,
    hide_format: true,
    info: {
      title: "Shop APi"
    }
    )
end
