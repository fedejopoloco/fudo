# product_store.rb
class ProductStore
    @@products = []
    @@next_id = 1
      
    def self.create(name)
      product = { id: @@next_id, nombre: name, estado: 'PENDING', fecha_creacion: Time.now.utc.iso8601 }
      @@products << product
      @@next_id += 1
      product
    end

    def self.find_by_id(id)
      @@products.find { |product| product[:id] == id }
    end

    def self.all
      @@products
    end

  end