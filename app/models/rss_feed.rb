class RssFeed

  DEFAULT_FEEDS = [
    'http://rss.cnn.com/rss/cnn_us.rss',
    'http://rss.cnn.com/rss/cnn_world.rss'
  ]

  attr_reader :url, :titles

  def self.all
    return @rss_feeds if @rss_feeds
    App::Persistence['rss_feeds'] = DEFAULT_FEEDS unless App::Persistence['rss_feeds']
    @rss_feeds = App::Persistence['rss_feeds'].map { |url| self.new(url) }
  end

  def self.parse_all
    self.all.each { |feed| feed.parse }
  end

  def self.parse_next
    next_feed = self.all.find { |feed| !feed.parsed }
    next_feed.parse if next_feed
  end

  def initialize(url)
    @url = url
  end

  def feed_parser
    @feed_parser = BW::RSSParser.new(self.url)
  end

  def parse
    @titles = []
    self.feed_parser.parse do |item|
      @titles << item.title
    end
  end

  def parsed
    !!@parsed
  end

  def when_parser_initializes
    # p "The parser is ready!"
  end

  def when_parser_parses
    # p "The parser started parsing the document"
  end

  def when_parser_is_done
    @parsed = true
    # p "The parser started parsing the document"
    # RssFeed.parse_next
  end

end
