require 'nokogiri'
require 'httparty'
require 'watir'
require 'byebug'

class ContentsController < ApplicationController
  before_action :set_content, only: [:show, :edit, :update, :destroy, :msn_money]

  # GET /contents
  # GET /contents.json
  def index
    browser = Watir::Browser.new(:chrome)
    browser.goto("https://www.msn.com/en-my/money/stockdetails/fi-126.1.AAPL.NAS?symbol=AAPL&form=PRFIMQ")
    security_name = "chipotle"
    browser.text_field(id:"finance-autosuggest").set security_name
    browser.send_keys :enter
    sleep 1
    parsed_page = Nokogiri::HTML(browser.html)

    ####### COMPANY ########
    company = {}
    company = {
      ticker: parsed_page.css("div.live-quote-subtitle").text.split.last,
      company_name: parsed_page.css("div.live-quote-title").text.split.first,
      twitter: parsed_page.css("div.live-quote-subtitle").text.split.last.insert(0,'$'),
      twitter_mention: parsed_page.css("div.live-quote-subtitle").text.split.last.insert(0,'@'),
      price: parsed_page.css("div.live-quote-bottom-tile span").first.text,
      change_percent: parsed_page.css("div.live-quote-bottom-tile div div:nth-child(2)")[0].text,
      change_price: parsed_page.css("div.live-quote-bottom-tile div div:nth-child(1)")[0].text 
    }

    #### ARTICLES ######
    articles = []
    article = {}
    news_links = parsed_page.css(".bingNewsContainer a")

    news_links.each do |x|
      article = {
        body: x.css("h3").text,
        link: x.attributes["href"].value,
        source: x.css("span.sourcename").text,
        timeframe: x.css("span.dt").text 
        }

      articles << article
    end

    ######### company description
    browser.div(class: "dynaloadable").ul.li(id: "profile").click
    parsed_page = Nokogiri::HTML(browser.html)
    browser.div(class:"rdmr-sels-btns").click
    parsed_page = Nokogiri::HTML(browser.html)
    @company_description = parsed_page.css("div.company-description").text
    @company_link = parsed_page.css("a.companyprofile-link").attribute('href').value
    @company_sector = parsed_page.css("p.captionData").first.text

    ########## twitter ################
    browser.goto("https://twitter.com/search?f=tweets&q=#{company[:twitter]}")
    parsed_page = Nokogiri::HTML(browser.html)
    tweets = parsed_page.css('div.tweet')
    security_tweets = []
    tweets.each do |twat|
      tweet = {
      fullname: twat.css('strong.fullname').text,
      username: twat.css('span.username').text,
      when: twat.css('span.u-hiddenVisually').first.text,
      content: twat.css('p.TweetTextSize').text,
      avatar: twat.css('img.avatar').first.attribute('src').value
      }
      security_tweets << tweet
    end
    ###### LOGO's ###########
    browser.goto("https://www.bing.com/images/search?q=#{company[:company_name]}%20logo")
    sleep 1
    parsed_page = Nokogiri::HTML(browser.html)
    logo = parsed_page.at_css("div.img_cont img").attribute('src').value
    ###### Background ######
    browser.goto("https://www.bing.com/images/search?&q=#{company[:company_name]}%20logo&qft=+filterui:imagesize-custom_1000_320&FORM=IRFLTR")
    sleep 1
    parsed_page = Nokogiri::HTML(browser.html)
    cover = parsed_page.at_css("div.img_cont img").attribute('src').value
    browser.close
    @cover = cover
    @logo = logo
    @company = company
    @articles = articles
    @tweets = security_tweets
  end

  # GET /contents/1
  # GET /contents/1.json
  def show
  end

  # GET /contents/new
  def new
    @content = Content.new
  end

  # GET /contents/1/edit
  def edit
  end

  # POST /contents
  # POST /contents.json
  def create
    @content = Content.new(content_params)

    respond_to do |format|
      if @content.save
        format.html { redirect_to @content, notice: 'Content was successfully created.' }
        format.json { render :show, status: :created, location: @content }
      else
        format.html { render :new }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contents/1
  # PATCH/PUT /contents/1.json
  def update
    respond_to do |format|
      if @content.update(content_params)
        format.html { redirect_to @content, notice: 'Content was successfully updated.' }
        format.json { render :show, status: :ok, location: @content }
      else
        format.html { render :edit }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.json
  def destroy
    @content.destroy
    respond_to do |format|
      format.html { redirect_to contents_url, notice: 'Content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def msn_money
    browser = Watir::Browser.new(:chrome)
    browser.goto("https://www.msn.com/en-my/money/stockdetails/fi-126.1.AAPL.NAS?symbol=AAPL&form=PRFIMQ")
    security_name = "apple"
    sleep 1
    browser.text_field(id:"finance-autosuggest").set security_name
    browser.send_keys :enter
    sleep 1
    parsed_page = Nokogiri::HTML(browser.html)

    ####### COMPANY ########
    company = {}
    company = {
      ticker: parsed_page.css("div.live-quote-subtitle").text.split.last,
      comany_name: parsed_page.css("div.live-quote-title").text.split.first,
      twitter: parsed_page.css("div.live-quote-subtitle").text.split.last.insert(0,'$'),
      price: parsed_page.css("div.live-quote-bottom-tile span").first.text,
      change_percent: parsed_page.css("div.live-quote-bottom-tile div div:nth-child(2)")[0].text,
      change_price: parsed_page.css("div.live-quote-bottom-tile div div:nth-child(1)")[0].text
    }
    @comapny = company[:comany_name]

    #### ARTICLES ######
    articles = []
    article = {}
    news_links = parsed_page.css(".bingNewsContainer a")

    news_links.each do |x|
      picture = nil
      if x.css("img").any?
        if x.css("img").attribute("src").value =~ /^[a-z]/
          picture = x.css("img").attribute("src").value
        end
      end
      article = {
        body: x.css("h3").text,
        link: x.attributes["href"].value,
        picture: picture

        }

      articles << article
    end

    articles.each do |x|
      if x[:picture] != nil 
        x[:picture]
      end
    end

    ######### company description
    browser.div(class: "dynaloadable").ul.li(id: "profile").click
    parsed_page = Nokogiri::HTML(browser.html)
    browser.div(class:"rdmr-sels-btns").click
    parsed_page = Nokogiri::HTML(browser.html)
    sleep 1
    company_description = parsed_page.css("div.company-description").text
    company_link = parsed_page.css("a.companyprofile-link").attribute('href').value
    company_sector = parsed_page.css("p.captionData").first.text

    ########## twitter ################
    browser.goto("https://twitter.com/search?f=tweets&q=#{company[:twitter]}")
    parsed_page = Nokogiri::HTML(browser.html)
    tweets = parsed_page.css('div.tweet')
    security_tweets = []
    tweets.each do |twat|
      tweet = {}
      tweet['fullname'] = twat.css('strong.fullname').text
      tweet['username'] = twat.css('span.username').text
      tweet['when'] = twat.css('span.u-hiddenVisually').first.text
      tweet['content'] = twat.css('p.TweetTextSize').text
      tweet['avatar'] = twat.css('img.avatar').first.attribute('src').value
      security_tweets << tweet
    end

    browser.close
    @tweets = security_tweets 
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_params
      params.require(:content).permit(:name, :address)
    end
end
