class ProductHunt::CLI
    def call
        puts "Welcome to Product Hunt!"
        make_products
        display_products
        get_user_input
    end

    def make_products
        products_array = ProductHunt::Scraper.scrape_products
        Product.create_from_collection(products_array)
    end

    def display_products
        Product.all.each do |product|
            if product.name != ""
                puts "#{product.name}".colorize(:blue)
                puts "  Description:".colorize(:light_blue) + " #{product.short_description}"
                puts "----------------------".colorize(:green)
            end
        end
    end

    def get_user_input
        puts "Enter which product you'd like to see more details about or 'exit' to leave:"
        user_input = gets.strip
        
        if valid_product(user_input)
            show_product_details(user_input)
        elsif user_input == "exit"
            puts "Thanks! Have a great day!"
        elsif !valid_product(user_input)
            puts "That product doesn't exist. Please check your spelling and try again."
            display_products
            get_user_input
        end
    end

    def show_product_details(product_name)
        attributes = ProductHunt::Scraper.scrape_specific_product(product_name)
        chosen_product = Product.all.select { |product| product.name == product_name}
        chosen_product[0].add_product_details(attributes)

        puts "#{chosen_product[0].name}".colorize(:blue)
        puts "  Upvotes:".colorize(:light_blue) + " #{chosen_product[0].upvotes}"
        puts "  Description:".colorize(:light_blue) + " #{chosen_product[0].long_description}"
        puts "  Makers:".colorize(:light_blue)
        chosen_product[0].makers.each do |maker|
            puts "\n#{maker}"
        end
        puts "----------------------".colorize(:green)
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