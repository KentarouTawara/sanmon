module ApplicationHelper
  def default_meta_tags
    {
      site: "三文小説",
      title: "三文小説 | 日替わりの3つの単語で小さな物語を創るサイト。創作の腕試しに！",
      reverse: true,
      charset: 'utf-8',
      separator: '|',
      description: '広がりのある、あなたの小さな物語を。',
      keywords: '三文小説,さんもんしょうせつ、sannmon,sannmonsyousetu,三題噺,140字小説',
      canonical: request.original_url,
      icon: [
        { href: image_url('favicon.ico') },
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        url: request.original_url,
        image: image_url('ogp.png'),
        type: 'website',
        locale: 'ja_JP'
      },
      twitter: {
        site: '@kentaroutawara',
        card: 'summary_large_image'
      }
    }
  end

  def page_title(page_title = '')
    base_title = "三文小説"
    root_title = "三文小説 | 小さな物語を"

    page_title.empty? ? root_title : page_title + ' | ' + base_title
  end
end