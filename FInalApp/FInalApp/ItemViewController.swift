//
//  ItemViewController.swift
//  FInalApp
//
//  Created by Quinn Berry on 11/24/20.
//  Copyright © 2020 Quinn Berry. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var photoSegControl: UISegmentedControl!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var currentTxt: UITextField!
    @IBOutlet weak var thresholdTxt: UITextField!
    @IBOutlet weak var priceLbl: UILabel!
    
    var selectedItem:PantryItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLabels()
        // Do any additional setup after loading the view.
    }
    
    func loadLabels() {
        itemNameLbl.text = selectedItem?.getName()
        let current = selectedItem?.getCurrent()
        let threshold = selectedItem?.getThreshold()
        currentTxt.text = String(current!)
        thresholdTxt.text = String(threshold!)
        
        if let image = selectedItem?.getImage() {
            itemImage.image = UIImage(data: image)
        }
    }
    
    @IBAction func addPhoto(_ sender: Any) {
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        let current = Double(currentTxt.text!)
        let threshold = Double(thresholdTxt.text!)
        if let image = itemImage.image {
            selectedItem?.setImage(image: image.pngData()!)
        }
        selectedItem?.setCurrent(current: current!)
        selectedItem?.setThreshold(threshold: threshold!)
    }
}
