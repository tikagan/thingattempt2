class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def current_user
    if session[:user_id]
      return User.find(session[:user_id])
    end
  end

  def scrape_users

    # P1: Takes all the popular meetup groups on the homepage & stashes them in an array
    agent = Mechanize.new
    page = agent.get 'http://www.meetup.com'
    meetup_links = []
    people = []

    page.links.select{|link| link.href[/events/]}.each do |eventlink|
      url = eventlink.href
      url.gsub!(/(\/events\/).+/, "/members/?offset=0" )
      meetup_links << url
    end
 #P2: Takes each group link, and iterates through all the member pages(limited by user count), scraping each name into my array along the way
    meetup_links.each do |meetlink|
      page = HTTParty.get(meetlink)
      parsed_page = Nokogiri::HTML(page)
      offset = 0

      #so the app isn't tripped up byprivate group which don't show members 
      if parsed_page.css('.D_count').empty?
      	next
      else
      	user_limit =(parsed_page.css('.D_count').first.text.delete"(,)").to_i #gets member count from page, removes styling, and converts to integer
      end

      while offset <= user_limit do
        page = HTTParty.get(meetlink)
        parsed_page = Nokogiri::HTML(page)

        parsed_page.css('.memName').each do |user|
          people << user.text
        end

        offset += 20
        meetlink.gsub!((offset - 20).to_s, offset.to_s) #gsubs the old offset with the new one (As string to avoid implicit conversion errors)

        if people.length > 500
          render :json => people and return
        end

      end

    end

  end

  helper_method :current_user
end