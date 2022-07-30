include Rails.application.routes.url_helpers

namespace :houry do
  desc "過去作品の投稿"
  task post_works_at_random: :environment do
    Rails.logger.info 'post_works_at_random start'
    # ランダムに作品を取得
    work = Work.order("RANDOM()").limit(1).last
    TwitterClient.new.tweet(work)
    Rails.logger.info 'post_works_at_random end'
  end
end
