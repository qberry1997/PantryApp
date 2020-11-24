//
//  PantryItem+CoreDataClass.swift
//  FInalApp
//
//  Created by Quinn Berry on 11/24/20.
//  Copyright © 2020 Quinn Berry. All rights reserved.
//
//

import Foundation
import CoreData


public class PantryItem: NSManagedObject {
    // Getter and setter for name
    func getName() -> String? {
        return self.name
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    // Getter and setter for image
    func getImage() -> Data? {
        return self.image
    }
    
    func setImage(image: Data) {
        self.image = image
    }
    
    // Getter and setter for desc
    func getDesc() -> String? {
        return self.desc
    }
    
    func setDesc(desc: String) {
        self.desc = desc
    }
    
    // Getter and setter for current
    func getCurrent() -> Double? {
        return self.current
    }
    
    func setCurrent(current: Double) {
        self.current = current
    }
    
    // Getter and setter for threshold
    func getThreshold() -> Double? {
        return self.threshold
    }
    
    func setThreshold(threshold: Double) {
        self.threshold = threshold
    }
}
