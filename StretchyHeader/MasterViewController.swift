//
//  MasterViewController.swift
//  StretchyHeader
//
//  Created by Taylor Benna on 2016-06-07.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit

private let kTableHeaderHeight = 250

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects:[NewsItem] = []
    @IBOutlet var headlineTableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    
    struct NewsItem {
        var category:Categories
        var header:String
    }
    
    enum Categories:String {
        case World = "World"
        case Americas = "Americas"
        case Europe = "Europe"
        case MiddleEast = "Middle East"
        case Africa = "Africa"
        case AsiaPacific = "Asia Pacific"
    }
    
    func getCategoryColour(category: Categories) -> UIColor{
        switch category {
        case .World:
            return UIColor.redColor()
        case .Americas:
            return UIColor.blueColor()
        case .Europe:
            return UIColor.greenColor()
        case .MiddleEast:
            return UIColor.yellowColor()
        case .Africa:
            return UIColor.orangeColor()
        case .AsiaPacific:
            return UIColor.purpleColor()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(MasterViewController.insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        headlineTableView.rowHeight = UITableViewAutomaticDimension
        headlineTableView.estimatedRowHeight = 80.0
        
        self.navigationController?.navigationBarHidden = true
        
        populateArray()
        
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .NoStyle
        
        let dateString = formatter.stringFromDate(NSDate())
        
        dateLabel.text = dateString
        
        headlineTableView.tableHeaderView = nil;
        headlineTableView.addSubview(headerView)
        

        headlineTableView.contentInset.top = CGFloat(kTableHeaderHeight)
        headlineTableView.contentOffset.y = CGFloat(0 - kTableHeaderHeight)
    }
    
    func populateArray () {
        objects.append(NewsItem(category: .World, header: "Climate change protests, divestments meet fossil fuels realities"))
        objects.append(NewsItem(category: .Europe, header: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"))
        objects.append(NewsItem(category: .MiddleEast, header: "Airstrikes boost Islamic State, FBI director warns more hostages possible"))
        objects.append(NewsItem(category: .Africa, header: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"))
        objects.append(NewsItem(category: .AsiaPacific, header: "Despite UN ruling, Japan seeks backing for whale hunting"))
        objects.append(NewsItem(category: .Americas, header: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"))
        objects.append(NewsItem(category: .World, header: "South Africa in $40 billion deal for Russian nuclear reactors"))
        objects.append(NewsItem(category: .Europe, header: "'One million babies' created by EU student exchanges"))
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewWillAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
//        objects.insert(NSDate(), atIndex: 0)
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                let object = objects[indexPath.row] as! NSDate
//                let controller = segue.destinationViewController as! DetailViewController
//                controller.detailItem = object
//            }
//        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("headlineCell", forIndexPath: indexPath) as! HeadlineTableViewCell
        let currentItem = objects[indexPath.row]
        
        cell.categoryLabel.textColor = getCategoryColour(currentItem.category)

        cell.categoryLabel.text = currentItem.category.rawValue
        cell.headlineLabel.text = currentItem.header
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: Int(headlineTableView.bounds.width), height: kTableHeaderHeight)
        if headlineTableView.contentOffset.y < CGFloat(-kTableHeaderHeight) {
            headerRect.origin.y = headlineTableView.contentOffset.y
            headerRect.size.height = -headlineTableView.contentOffset.y
        }
        headerView.frame = headerRect
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }

}

