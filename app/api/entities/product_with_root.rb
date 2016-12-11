module Entities
  class ProductWithRoot < Grape::Entity
    expose :products, using: Entities::ProductEntity, documentation: { type: "Entities::ProductEntity", is_array: true }
  end
end
