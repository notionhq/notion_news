class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

  	application.setStatusBarHidden(true, withAnimation:false)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    tableViewController = TopicTableViewController.alloc.init
    @window.rootViewController = tableViewController
    @window.backgroundColor = UIColor.redColor
    @window.makeKeyAndVisible
    true
  end
end
