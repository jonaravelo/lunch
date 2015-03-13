//
//  LunchItem.swift
//  Lunch
//
//  Created by Jonathan Ravelo on 09/03/2015.
//  Copyright (c) 2015 jona. All rights reserved.
//

import Foundation

//we want to be to add Items to our app, so we create our model first.
//Every item needs at least these properties (ie name and quantity)

class Item {
    
    //instead of usuing an initializer here we have used two empty strings
    //we use a string for quanitiy as we want to be able to write grams, packs ect
    var name = ""
    var quantity = ""
    var iconName = "Other"
    
}
