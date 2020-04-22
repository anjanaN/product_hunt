class Product

    attr_accessor :name, :url, :description

    @@all = []

    def initialize(product_hash)
        new_product = product_hash.each {|key, value| self.send(("#{key}="), value)}
        @@all << self
    end

    def self.create_from_collection(products_array)
        products_array.each do |product|
          new_product = Product.new(product)
        end
    end

    def self.all
        @@all
    end
end