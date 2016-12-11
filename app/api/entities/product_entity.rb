module Entities
  class ProductEntity < Grape::Entity
    root 'pdkpro'
    format_with(:iso_timestamp) { |dt| dt.to_i }
    expose  :id, documentation: { type: 'integer', values: [1] }
    expose  :title, documentation: { type: 'string', values: ["Hello!"] }
    expose  :price, documentation: { type: 'float', values: [1.1] }

    with_options(format_with: :iso_timestamp) do
      expose  :created_at, documentation: { type: 'integer', values: [1481461392] }
      expose  :updated_at, documentation: { type: 'integer', values: [1481461392] }
    end
  end
end
