class Product

    attr_accessor :name, :url, :upvotes, :short_description, :long_description, :makers

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

    def add_product_details(attributes_hash)
        attributes_hash.each {|key, value| self.send(("#{key}="), value)}
    end

    def self.all
        @@all
    end
end