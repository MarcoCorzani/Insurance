//
//  ViewController.swift
//  Insurance
//
//  Created by Marco F.A. Corzani on 24.11.14.
//  Copyright (c) 2014 Alphaweb. All rights reserved.
//

import UIKit
import CoreData

class PatternsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var patterns : [Pattern] = []
    
    var selectedPatterns : Pattern? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.delegate = self
    
        //createTestPatterns()
    }

    override func viewWillAppear(animated: Bool) {
        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
        var request = NSFetchRequest(entityName: "Pattern")
        var results = context.executeFetchRequest(request, error: nil)
        if results != /*is not*/ nil {
            self.patterns = results! as [Pattern]
        }
    }
    
    
    func createTestPatterns(){
        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    
        var pattern = NSEntityDescription.insertNewObjectForEntityForName("Pattern", inManagedObjectContext: context) as Pattern
    
        pattern.name = "The Pantz"
        pattern.frontImage = UIImageJPEGRepresentation(UIImage(named: "Ebay-Iphone_5 273.JPG"), 1)
        pattern.backImage = UIImageJPEGRepresentation(UIImage(named: "Ebay-Iphone_5 272.JPG"), 1)
        context.save(nil)
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.patterns.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        var pattern = self.patterns[indexPath.row]
        cell.textLabel!.text = pattern.name
        cell.imageView!.image = UIImage(data: pattern.frontImage)
        
        return cell
    }
    
    // Wenn der Eintrag gewählt wird....nehme diesen Segue!
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedPatterns = self.patterns[indexPath.row]
        self.performSegueWithIdentifier("patternDetailSegue", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)  // gewählter Eintrag erscheint nicht grau hinterlegt
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Identifier im If Statement, weil 2 Segues abgehen!
        if segue.identifier == "patternDetailSegue" {
        var detailViewController = segue.destinationViewController as PatternDetailViewController
        detailViewController.pattern = self.selectedPatterns
        }
    }

}

