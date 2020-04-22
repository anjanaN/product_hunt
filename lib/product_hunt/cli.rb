class ProductHunt::CLI
    def call
        puts "Welcome to Product Hunt!"
        make_products
        display_products
        get_user_product
    end

    def make_products
        products_array = ProductHunt::Scraper.scrape_products
        Product.create_from_collection(products_array)
    end

    def display_products
        Product.all.each do |product|
          puts "#{product.name}".colorize(:blue)
          puts "  Description:".colorize(:light_blue) + " #{product.description}"
          puts "----------------------".colorize(:green)
        end
        puts "Enter which product you'd like to see more details about:"
    end

    def get_user_product
        chosen_product = gets.strip
        if valid_product(chosen_product)
            open_product_site(chosen_product)
        end
    end

    def open_product_site(product_name)
        chosen_product = Product.all.select { |product| product.name == product_name}
        open_link = "https://www.producthunt.com#{chosen_product[0].url.value}"
        `open #{open_link}`
    end

    def valid_product(product_name)
        Product.all.any? { |product| product.name == product_name}
    end
end