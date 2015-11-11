import UIKit

class MasterViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(DiffCell.self, forCellReuseIdentifier: "Cell")
    }

    func stringForRow(row: Int) -> NSAttributedString {
        let path = NSBundle.mainBundle().pathForResource("Test\(row)", ofType: "txt")!
        let rawString = try! String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
        let attributedString = NSAttributedString(string: rawString, attributes: [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName: UIFont(name: "Menlo", size: 14)!,
/*
            The following line is causing huge performance problems
            When commented out memory peak is at ~350 MB when activated: 1.3 GB and app is terminated
*/
            NSBackgroundColorAttributeName: UIColor.whiteColor() // <---- this line
            ])
        return attributedString
    }

    // MARK: - Table View

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DiffCell

        cell.string = stringForRow(indexPath.row)
        
        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return DiffCell.heightForModel(stringForRow(indexPath.row), constrainingWidth: tableView.frame.width)
    }
}
