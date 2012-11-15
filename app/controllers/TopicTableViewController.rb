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

  def viewDidLoad
    view.dataSource = view.delegate = self
  end

  def tableView(tableView, numberOfRowsInSection:section)
  10
  end

  CELLID = 'CellIdentifier'
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELLID) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:CELLID)
      cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton
      cell
    end

    cell.textLabel.text = 'Hello World'
    cell
  end
end