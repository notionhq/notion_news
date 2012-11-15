class Topic

  attr_accessor :items, :title

  @@topics = []

  def self.all
    @@topics
  end

  def self.words
    @@topics.map { |t| {:title => t.title, :count => t.items.count } }
  end

  def self.find(word)
    topic = @@topics.find { |topic| topic.title == word.downcase }
    return topic if topic
    topic = self.new(word.downcase)
    @@topics << topic
    topic
  end

  def self.add_rss_feed(rss_feed)
    rss_feed.items.each do |item|
      item.title.split(/\s/).each do |word|
        topic = self.find(word)
        topic.items << item
      end
    end
  end

  def initialize(title)
    @title = title
    @items = []
  end

  def subtitle
    "awesome"
  end

end
