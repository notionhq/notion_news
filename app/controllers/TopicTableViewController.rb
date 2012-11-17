class TopicTableViewCellView < UITableViewCell
  def initWithFrame(frame)
    if super
      self.opaque = true
    end
    self
  end

  def drawRect(rect)

  end
end

class TopicTableViewCell < UITableViewCell
  def initWithStyle(style, reuseIdentifier:reuseIdentifier)
    if super
    end
    self
  end
end

class TopicTableViewController < UITableViewController
  def init
    if super

    end
    self
  end

  def viewWillDisappear(animated)
    App.notification_center.unobserve @reload_observer
  end

  def viewWillAppear(animated)
    @reload_observer = App.notification_center.observe Topic::RefreshNotification do |notification|
      puts "Reloading Table"
      self.tableView.reloadData
    end
  end

  def viewDidLoad
    view.dataSource = view.delegate = self
  end

  def tableView(tableView, numberOfRowsInSection:section)
    Topic.all.count
  end

  CELLID = 'CellIdentifier'
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELLID) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:CELLID)
      cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton
      cell
    end

    cell.textLabel.text = Topic.all[indexPath.row].title
    cell
  end
end
