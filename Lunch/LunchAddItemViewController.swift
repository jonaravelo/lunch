//
//  LunchAddItemViewController.swift
//  Lunch
//
//  Created by Jonathan Ravelo on 10/03/2015.
//  Copyright (c) 2015 jona. All rights reserved.
//

import UIKit


//Aim is to connect up our save button to allow us to pass information
//back to our list table

//Step 1 - Add in our protocol class for our delegate

protocol AddItemViewControllerDelegate : class {
    //This method allows us to send our Item back to our list table view controller
    func addItemViewControllerDidSave(controller: LunchAddItemViewController, item: Item)
    //This method will allow us to dismiss our current view controller
    func addItemViewControllerDidCancel(controller: LunchAddItemViewController)
}





class LunchAddItemViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var saveButtonPressed: UIBarButtonItem!
    @IBOutlet weak var segmentButtonPressed: UISegmentedControl!
    
    //Step 2 - Add an empty property that will be filled with our delegate
    //we add in a delegate variable with an instance of our delegate so we can access its methods inside of our class
    weak var delegate : AddItemViewControllerDelegate?
    // we add in a property called iconPressed so that we can set the value of our segmented control
    //to it
    //we can then assign it to our iconName inside our project
    
    var iconPressed = "Other"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Add Item"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Step 3 - Add our save button functionallity - create a new Item Object.
    
    @IBAction func saveButton(sender: UIBarButtonItem) {
        let item = Item()
        item.name = nameTextField.text
        item.quantity = quantityTextField.text
        item.iconName = iconPressed
        println(item.iconName)
        //When our save button is clicked this sends the delegate method addItemViewControllerDidSave back to our
        //list table view controller, which then does something with our new item
        delegate?.addItemViewControllerDidSave(self, item: item)
        
    }
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        //when the cancel button is pressed the addItemViewControllerDidCancel method is called on our
        //list table view controller
        //we use self, as we are the controller sending the message
        delegate?.addItemViewControllerDidCancel(self)
        
    }
    
    @IBAction func segmentSelected(sender: UISegmentedControl) {
        
        /* 
        
        
        A switch statement considers a value and compares it against several possible matching values.
        
        switch someValueToConsider {
            case value1:
                    respond to value 1
            case value2:
                    respond to value 2
            case value2:
                    respond to value 3
            default
                    resonds to all other possibilites
        
        }
        
        
        Switch statements must be exhaustive, which means you must provide a response for every possible outcome. If thats not appropriate, use a default which appears last
        */
        
        switch segmentButtonPressed.selectedSegmentIndex {
            
        case 0:
            iconPressed = "FruitVeg"
            println(iconPressed)
        case 1:
            iconPressed = "Meat"
            println(iconPressed)
        case 2:
            iconPressed = "Fish"
            println(iconPressed)
        default:
            iconPressed = "Other"
            println(iconPressed)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
