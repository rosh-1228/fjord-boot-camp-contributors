# frozen_string_literal: true

module ApplicationHelper
  def default_meta_tags
    {
      site: 'FjordBotCamp CONTRIBUTORS', title: 'FjordBotCamp CONTRIBUTORS',
      reverse: true, charset: 'utf-8',
      description: 'フィヨルドブートキャンプ アプリのリポジトリに対するcommit数を集計し、ランキングを表示するサイトです。',
      keywords: 'FjordBotCamp,Contributors,Ruby', canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') },
        {
          href: image_url('https://fjord-boot-camp-contributors-production.up.railway.app/assets/twitter-card-img.png'),\
          rel: 'apple-touch-icon', sizes: '1230x630', type: 'image/png'\
        }
      ],
      og: {
        site_name: :site, title: :title, description: :description,
        type: 'website', url: request.original_url,
        image: image_url('https://fjord-boot-camp-contributors-production.up.railway.app/assets/twitter-card-img.png'), local: 'ja-JP'
      },
      twitter: { card: 'summary_large_image', site: '@rosh_1228', image: image_url('twitter-card-img.png') }
    }
  end
end
