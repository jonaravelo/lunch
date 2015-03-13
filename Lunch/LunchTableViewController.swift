//
//  LunchTableViewController.swift
//  Lunch
//
//  Created by Jonathan Ravelo on 09/03/2015.
//  Copyright (c) 2015 jona. All rights reserved.
//

import UIKit

//Becoming a delegate Step 1:
//Declare yourself as a delegate by adding addItemViewControllerDelegate to the class declaration

class LunchTableViewController: UITableViewController, AddItemViewControllerDelegate {
    
    //this creates an empty array that will hold only item objects
    var items = [Item]()
    
    //This function is called when our view is loaded. Do setup like setting the title in here
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        self.title = "Lunch"
        
        //here we are creating a new item
        //first line assigns a new item object to a constant called item1
        let item1 = Item()
        //second two lines assigns values to this objects name and quantity properties
        item1.name = "Tomatoes"
        item1.quantity = "800g"
        item1.iconName = "FruitVeg"
        //the third uses += to add our item1 to the items array
        self.items += [item1]
        
        let item2 = Item()
        item2.name = "Seabass"
        item2.quantity = "4 fillets"
        item2.iconName = "Fish"
        self.items += [item2]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    //This function allows us to tell the table view how many rows of data we want to display
    //
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        //instead of returning a static value such as 1 we want to return the amount of items objects currently inside our array
        //to do this we use the .count method
        return items.count
    }
    
    
    //this function allows us to tell the table view how to display each row of data, Here we add in our prototype cell so the table view knows how to display its data
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //This line declares our resuable cell, we add in "ItemCell" where it said "reuseIdentifier" so we can tell the tableview to create this kind of cell for each row of data
        
        //step 1. add in reuse identifier
        //This function is run everytime a new row of data needs a cell
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        
        //step 2, this line access the item at the specified number inside our array
        // we use the indexPath to point to the correct row of data
        let item = self.items[indexPath.row]
        
        //println(indexPath.row)
        
        //Step 3, Set our text labels
        //first access our cell property textLabel
        //We use the ! to unwrap this optional value so we can set its properties
        //Note only use the ! when you definitly know there is a value
        //we then access the text property and finally assign it to the name of the current item.
        
        cell.textLabel!.text = item.name
        cell.detailTextLabel!.text = item.quantity
        //Here we want to display our icon inside of our cell.
        //our cell comes with an image view property
        //we can set this by accessing imageView's image property
        //to set this property we must use a UIimage object
        //as item.iconName is a string, we need to convert it
        //To do this we use UIImage method that allows us to set an image by its filename.
        cell.imageView!.image = UIImage(named: item.iconName)
        
        return cell
    }
    
    // MARK: - Protocol Methods
    
    //Step 2: Conform to the protocol set in the LunchAddItemViewController
    //To do this we need to fill out both protocol methods
    
    //Aim is to add our item  passed by LunchAddItemViewController to our table view
    func addItemViewControllerDidSave(controller: LunchAddItemViewController, item: Item) {
        
        //we want to use the insertRowsAtIndexPath method
        
        //This is what we need to create:
        //An array of NSIndexPath objects, representing a row in our table view
        
        //First get the row index
        //This counts how many items are in our array currently
        //at the moment we have 2 items in our array
        //this will be the number that will be returned
        //this actually will correspond to the third row in our table as our
        //table counts from 0, 1, 2
        let rowIndex = items.count
        //create a new index path combining our row and section number. If you
        //have one section, the section number will be 0 as we count from 0
        let indexPath = NSIndexPath(forItem: rowIndex, inSection: 0)
        
        //add our index path into an array
        let indexPathArray = [indexPath]
        
        //add our new intem to our items array.
        //we do this after the index path to ensure our row indez points to the
        //correct place
        
        self.items += [item]
        
        //now add our insertRowAtIndexPath method
        //with row animation allows us to choose which animation style we want the row
        //inserted with, this case .Automatic, .Top ect
        tableView.insertRowsAtIndexPaths(indexPathArray, withRowAnimation: .Automatic)
        
        //Dismiss our view controller
        dismissViewControllerAnimated(true, completion: nil)
        
        
        
    }
    
    //Aim of this one, Dismiss the LunchAddItemViewController
    func addItemViewControllerDidCancel(controller: LunchAddItemViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    //Step 3: Tell the other controller that we are it's delegate
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        //Only run this code if our segue is equal to "Add Item"
        if segue.identifier == "AddItem" {
            
            //Set the delegate property on our Add Item controller
            
            //First - Get a reference to our navigation controller
            //We have to tell Xcode what kind of object is going to be at the end of our segue
            //to do this we use 'as UINavigationController' to typecast the result
            let navigationController = segue.destinationViewController as
            UINavigationController
            
            //Second get a refernce to our add item view controller
            //here we use top view controller method to access what ever controller is on top
            //of the navigation stack
            
            //The navigation stack contains views and other navigation controllers
            //They sit on top of one another. The hierarchy would be as follows:
            
            //AddItemViewController
            //Navigation Controller
            //LunchTablViewController
            //Navigation Controller
            
            
            //Xcode cant be sure of what object is sitting on top of the navigation stack so
            //again we have to use typecasting to let it know - ' as LunchAddItemViewController'
            let addItemController = navigationController.topViewController as
            LunchAddItemViewController
            
            
            //Once we have a reference to the correct controller, we can access
            //it's delegate propery and set it to ourself.
            addItemController.delegate = self
            
            
        }
        
    }
    
    

    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            //when we delete items from a table view, we need to make sure we delete it from
            //our items array too.
            
            //when this function is called the cell that is in delete mode passes its indexPath to us.
            //we then use removeAtIndex and pass it indexPath.row to delete the correct item in our array.
            self.items.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    //here we want to rearrange the order of our items, in our items array, so that our order is preserved
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        //First get a reference to the item that is inside the row we want to move from
        let item = items[fromIndexPath.row]
        //next remove this item
        items.removeAtIndex(fromIndexPath.row)
        //insert the item back into our array at the correct position
        items.insert(item, atIndex: toIndexPath.row)
        println(item.name)
        
        
    }
    
    
    //this method allows us to rearrage our table view cells, but does not change the order of our items
    //in our items array.
    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    
    
    
    
}
