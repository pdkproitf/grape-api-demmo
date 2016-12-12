require 'grape-swagger'
module Shop
  class ProductApi < Grape::API
    prefix  :api
    version 'v1', using: :accept_version_header

    resource :products do
# => /api/v1/products
      desc "show all products", entity: Shop::Entities::ProductWithRoot
      get do
        products = Product.all
        present({ products: products }, with: Entities::ProductWithRoot)
      end
# => /api/v1/messages/:id
      desc "get a product", entity: Entities::ProductWithRoot
      get ':id' do
        product = Product.find(params[:id])
        # present product, with: Entities::ProductEntity
      end
# => /api/v1/messages/
      desc "create new product", entity: Entities::ProductWithRoot
      # => this take care of parametter validation
      params do
        requires :product, type: Hash do
          requires :title, type: String, desc: "Product's Title"
          requires :price,  type: BigDecimal, desc: "Price of a product"
        end
      end
      # => this takes care of creating product
      post 'products' do
        product = Product.new(declared(params, include_missing: false)[:product])
        product.save
        present product , with: Entities::ProductEntity
      end
# => /api/v1/product/:id
      desc 'Update a product', entity: Entities::ProductWithRoot
      params do
        requires :id, type: Integer, desc: "Product id"
        requires :title, type: String, desc: "Product's Title"
        requires :price,  type: BigDecimal, desc: "Price of a product"
      end
      put ':id' do
        product = Product.find(params[:id])
        product.update!({
            title: params[:title],
            price: params[:price]
            })
      end
# => /api/v1/product/:id
      desc 'Destroy a product'
      params do
        requires :id, type: Integer, desc: 'Product id'
      end

      delete ':id' do
        product = Product.find(params[:id])
        product.destroy!
      end
    end
    add_swagger_documentation(
      api_version: 'v1',
      hide_doccumentation_path: true,
      hide_format: true,
      info: {
        title: "ProductApi"
      }
    )
  end
end
