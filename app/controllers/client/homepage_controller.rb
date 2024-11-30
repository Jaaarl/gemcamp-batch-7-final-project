class Client::HomepageController < ApplicationController
  def index
    @banners = Banner.active.where('online_at <= ? AND offline_at > ?', Date.current, Date.current)
    @news_tickers = NewsTicker.active
  end
end