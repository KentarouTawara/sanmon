class TwitterClient
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.credentials.twitter[:consumer_key]
      config.consumer_secret     = Rails.application.credentials.twitter[:consumer_secret]
      config.access_token        = Rails.application.credentials.twitter[:access_token]
      config.access_token_secret = Rails.application.credentials.twitter[:access_token_secret]
    end
  end

  def tweet(work)
    begin
      text = <<~EOS
        【過去作品紹介！ 新しい作品待ってます！】
        作品名:「#{ work.title }」 #{ work.user.penname }著
        お題: 【 #{work.show_three_words} 】
        #三文小説
        https://sanmonsyousetu.com/works/#{ work.id }
      EOS
      @client.update(text)
      Rails.logger.info "Post to twitter.\n#{text}"
    rescue => e
      Rails.logger.error { "#{e.message} #{e.backtrace.join("\n")}" }
    end
  end
end
