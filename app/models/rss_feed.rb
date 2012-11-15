class RssFeed

  DEFAULT_FEEDS = [
    'http://rss.cnn.com/rss/cnn_us.rss',
    'http://rss.cnn.com/rss/cnn_world.rss',
    'http://www.nytimes.com/services/xml/rss/nyt/World.xml',
    'http://www.nytimes.com/services/xml/rss/nyt/US.xml',
    'http://rss.nytimes.com/services/xml/rss/nyt/Business.xml'
  ]

  attr_reader :url, :items, :feed_parser, :uuid

  def self.all
    return @rss_feeds if @rss_feeds
    App::Persistence['rss_feeds'] = DEFAULT_FEEDS unless App::Persistence['rss_feeds']
    @rss_feeds = App::Persistence['rss_feeds'].map { |url| self.new(url) }
  end

  def self.parse_all
    @@results = []
    self.all.each { |feed| feed.parse }
  end

  def self.parse_next
    next_feed = self.all.find { |feed| !feed.parsed }
    next_feed.parse if next_feed
  end

  def initialize(url)
    @url = url
    @uuid = BubbleWrap.create_uuid
    @feed_parser = BW::RSSParser.new(self.url)
    @feed_parser.delegate = self
  end

  def parse
    @items = []
    self.feed_parser.parse do |item|
      @items << item
    end
  end

  def method_missing(*args)
    puts "MISSING", args.inspect
  end

  def when_parser_is_done
    Topic.add_rss_feed(self)
  end

end

