class Topic

  class RefreshNotification

  end

  attr_accessor :items, :title

  @@topics = []

  def self.all
    @@topics
  end

  def self.words
    @@topics.map { |t| {:title => t.title, :count => t.items.count } }
  end

  def self.find(word)
    word = word.gsub(/[^\w]/, '').downcase
    return nil if BORING_WORDS.include?(word) || word.empty?
    topic = @@topics.find { |topic| topic.title == word }
    return topic if topic
    topic = self.new(word)
    @@topics << topic
    topic
  end

  def self.add_rss_feed(rss_feed)
    rss_feed.items.each do |item|
      item.title.split(/\s/).each do |word|
        topic = self.find(word)
        topic.items << item if topic
      end
    end
    @@topics.sort_by! { |t| -t.items.count }

    App.notification_center.post Topic::RefreshNotification
  end

  def initialize(title)
    @title = title
    @items = []
  end

  def subtitle
    return @subtitle if @subtitle
    @words = []
    self.items.each do |i|

    end
    "A"
  end

  BORING_WORDS = %w{
and
in
to
the
for
of
on
a
new
is
what
after
from
about
you
at
can
no
up
by
with
video
}


end
