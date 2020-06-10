class ProductHunt::CLI
    def call
        puts "Welcome to Product Hunt!"
        sleep(1)
        puts "Loading today's products..."
        sleep(1)
        puts "\n\n"
        make_products
        display_products
        get_user_input
    end

    def make_products
        products_array = ProductHunt::Scraper.scrape_products
        Product.create_from_collection(products_array)
    end

    def display_products
        Product.all.delete_if { |product| product.name == "" || !product.url.value.start_with?("/posts/") }
        Product.all.each.with_index(1) do |product, index|
            puts "#{index}. #{product.name}".colorize(:blue)
            puts "  Upvotes:".colorize(:light_blue) + " ⬆ #{product.upvotes}"
            puts "  Description:".colorize(:light_blue) + " #{product.short_description}"
            puts "----------------------".colorize(:green)
        end
    end

    def get_user_input
        puts "Enter the Product ID of the product you'd like to see more details about or 'exit' to leave:"
        user_input = gets.strip
        
        if valid_product(user_input)
            show_product_details(user_input)
        elsif user_input.downcase == "exit"
            puts "Thanks! Have a great day!"
        elsif !valid_product(user_input)
            puts "That Product ID doesn't exist. Please try again."
            sleep(3)
            display_products
            get_user_input
        end
    end

    def show_product_details(product_id)
        attributes = ProductHunt::Scraper.scrape_specific_product(product_id)
        chosen_product = Product.all[product_id.to_i - 1]
        chosen_product.add_product_details(attributes)

        puts "\n\n"
        puts "#{chosen_product.name}".colorize(:blue)
        puts "\n  Upvotes:".colorize(:light_blue) + " #{chosen_product.upvotes}"
        puts "  Description:".colorize(:light_blue) + " #{chosen_product.long_description}"
        puts "----------------------".colorize(:green)

        display_more_info
    end

    def display_more_info
        puts "Type 'open' to open this product page in your browser or 'menu' to go back to listed products"
        input = gets.strip

        if valid_action(input)
            if input == "open"
                open_product_site(product_id)
                display_products
                get_user_input
            elsif input == "menu"
                display_products
                get_user_input
            end
        elsif !valid_action(input)
            puts "Your input was invalid.\n"
            display_more_info
        end
    end

    def open_product_site(product_id)
        chosen_product = Product.all[product_id.to_i - 1]
        open_link = "https://www.producthunt.com#{chosen_product.url.value}"
        `open #{open_link}`
    end

    def valid_product(product_id)
        if product_id.to_i > 0 && product_id.to_i <= Product.all.length
            true
        else
            false
        end
    end

    def valid_action(action)
        if action == "open" || action == "menu"
            true
        else
            false
        end
    end
end