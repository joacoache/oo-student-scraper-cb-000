require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper


  def self.scrape_index_page(index_url)
    array = []
    html = Nokogiri::HTML(File.read(index_url))
    html.css('.student-card').each do |student|
      name = student.css('h4').text
      location = student.css('p').text
      profile_url = student.css('a').attribute('href').value
      array.push(name: name, location: location, profile_url: profile_url)
    end
#  binding.pry
  array
  end


  def self.scrape_profile_page(profile_url)
    student = {}
    profile = open(profile_url)
    html = Nokogiri::HTML(profile)
#    html.css('.social-icon-container').each do |profile|
#      linkedin = profile.css('a').attribute('href').value if include?("linkedin")
#      github = profile.css('a').attribute('href').value if include?("github")
#      twitter = profile.css('a').attribute('href').value if include?("twitter")
#      blog = profile.css('a').attribute('href').value if include? (".com") unless include?("linkedin" || "github" || "twitter")
#      hash.push(:linkedin=> linkedin,:github=> github,:blog=> blog)
#    html.css(".social-icon-container a").each do |link|
#      if link.attribute("href").value.include?("twitter")
#        student[:twitter] = link.attribute("href").value
#      elsif link.attribute("href").value.include?("linkedin")
#        student[:linkedin] = link.attribute("href").value
#      elsif link.attribute("href").value.include?("github")
#        student[:github] = link.attribute("href").value
#      else
#        student[:blog] = link.attribute("href").value
#      end
#    end
#    student[:bio] = html.css('p').text
#    student[:profile_quote] = html.css('.profile_quote').text
#    student
#    binding.pry
    links = html.css(".social-icon-container").children.css("a").map {|x| x.attribute('href').value}
      links.each do |link|
        if link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?("twitter")
          student[:twitter] = link
        else
          student[:blog] = link
        end
      end
      student[:profile_quote] = html.css(".profile-quote").text if profile_page.css(".profile-quote")
      student[:bio] = html.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

      student

  end

end

#Scraper.scrape_index_page('./fixtures/student-site/index.html')
#Scraper.scrape_profile_page('./fixtures/student-site/students/eric-chu.html')

#h4 = name
#p = location
#a = profile_url

#doc.css('.post').each do |post|
#      course = Course.new
#      course.title = post.css('h2').text
#      course.schedule = post.css('.date').text
#      course.description = post.css('p').text
#    end

# site = Nokogiri::HTML(File.read('./fixtures/student-site/index.html'))
#"./fixtures/student-site/index.html"
# [{name: "", location: "", profile_url: ""}, {}, {}]
