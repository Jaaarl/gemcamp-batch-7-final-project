class Client::Me::LotteryHistoryController < ApplicationController
  def index
    @lotteries = Ticket.includes(:item).where(user: current_client_user).page(params[:page]).per(5).order(created_at: :desc)
  end
end