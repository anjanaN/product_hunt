class ProductHunt::Scraper
    
    def self.scrape_products
        doc = Nokogiri::HTML(open("https://www.producthunt.com/"))

        doc.css("div.container_88f8e.large_bbe28 li").collect do |product|
            {:name => product.css("h3.font_9d927.medium_51d18.semiBold_e201b.title_9ddaf.lineHeight_042f1.underline_57d3c").text,
            :url => product.css("a.link_523b9").attr("href"),
            :description => product.css("p.font_9d927.grey_bbe43.small_231df.normal_d2e66.tagline_619b7.lineHeight_042f1.underline_57d3c").text.strip}   
        end
    end
end

