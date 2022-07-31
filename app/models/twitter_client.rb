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
      text = fix_text(work)
      @client.update(text)
      Rails.logger.info "Post to twitter.\n#{text}"
    rescue => e
      Rails.logger.error { "#{e.message} #{e.backtrace.join("\n")}" }
    end
  end

  def create_direct_message(work)
    text = <<~EOS
      【 新規投稿通知!! 】
      作品名:「#{ work.title }」 #{ work.user.penname }著
      お題: 【 #{ work.show_three_words } 】
      作成日: #{ I18n.l(work.created_at, format: :long) }
      #三文小説
      https://sanmonsyousetu.com/works/#{ work.id }
    EOS
    @client.create_direct_message('1018477898682920960', "#{ text }")
  end

  private

  def fix_text(work)
    if work.created_at > Time.zone.today.beginning_of_day
      text = <<~EOS
        【 NEW! 新しい三文小説が投稿されました！ 】
        作品名:「#{ work.title }」 #{ work.user.penname }著
        お題: 【 #{ work.show_three_words } 】
        #三文小説
        https://sanmonsyousetu.com/works/#{ work.id }
      EOS
    else
      text = <<~EOS
        【 過去作品紹介！ 新しい作品待ってます！ 】
        作品名:「#{ work.title }」 #{ work.user.penname }著
        お題: 【 #{ work.show_three_words } 】
        #三文小説
        https://sanmonsyousetu.com/works/#{ work.id }
      EOS
    end
  end
end
