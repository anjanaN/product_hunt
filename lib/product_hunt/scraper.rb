class ProductHunt::Scraper
    
    def self.scrape_products
        doc = Nokogiri::HTML(open("https://www.producthunt.com/"))

        doc.css("div.container_88f8e.large_bbe28 li").collect do |product|
            {:name => product.css("h3.font_9d927.medium_51d18.semiBold_e201b.title_9ddaf.lineHeight_042f1.underline_57d3c").text,
            :url => product.css("a.link_523b9").attr("href"),
            :short_description => product.css("p.font_9d927.grey_bbe43.small_231df.normal_d2e66.tagline_619b7.lineHeight_042f1.underline_57d3c").text.strip}   
        end
    end

    def self.scrape_specific_product(product_name)
        chosen_product = Product.all.select { |product| product.name == product_name}
        doc = Nokogiri::HTML(open("https://www.producthunt.com#{chosen_product[0].url.value}"))
        
        product_details = {}

        product_details[:long_description] = doc.css("div.font_9d927.small_231df.normal_d2e66.lineHeight_042f1.underline_57d3c div").text.strip
        product_details[:upvotes] = doc.css("span.bigButtonCount_10448").text.strip

        product_details[:makers] = doc.css("div.makersContainer_c110b").collect do |maker|
            maker.css("div.font_9d927.small_231df.semiBold_e201b.title_2bd7a.lineHeight_042f1.underline_57d3c").text.strip
            # product_makers[:maker][:info] = maker.css("span.font_9d927.grey_bbe43.small_231df.normal_d2e66.lineHeight_042f1.underline_57d3c.ellipsis_82856").text.strip
        end

        product_details
    end
end

