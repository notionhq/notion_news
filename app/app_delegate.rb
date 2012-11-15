class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    puts "#{App.name} (#{App.documents_path})"
    # RssFeed.parse_all
    true
  end
end
