class TopController < ApplicationController
  skip_before_action :require_login

  def index
    @today_words = Word.today_three_words
  end
end
