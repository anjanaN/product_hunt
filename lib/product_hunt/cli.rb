class ProductHunt::CLI
    def call
        puts 'Welcome to Product Hunt'
        make_products
        display_products
    end

    def make_products
        products_array = ProductHunt::Scraper.scrape_products
        Product.create_from_collection(products_array)
    end

    def display_products
        Product.all.each do |product|
          puts "#{product.name}".colorize(:blue)
          puts "  Name:".colorize(:light_blue) + " #{product.name}"
          puts "  URL:".colorize(:light_blue) + " #{product.url}"
          puts "  Description:".colorize(:light_blue) + " #{product.description}"
          puts "----------------------".colorize(:green)
        end
      end

    # def get_user_product
    #     chosen_product = gets.strip
    #     if valid_product
    #         open product details
    #     end
    # end

    # def valid_product
    
    # end
end