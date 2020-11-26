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
    let picker = UIImagePickerController()
    
    var selectedItem:PantryItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
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
    
    func updateAlert() {
        let alert = UIAlertController(title: "Information Updated", message: nil, preferredStyle: .alert)
        
        let OK = UIAlertAction(title: "OK", style: .default, handler: {(action) in
        })
        
        alert.addAction(OK)
        self.present(alert, animated: true, completion: nil)
    }
    
    func noCameraAlert() {
        let alert = UIAlertController(title: "No Camera Available", message: nil, preferredStyle: .alert)
        
        let OK = UIAlertAction(title: "OK", style: .default, handler: {(action) in
        })
        
        alert.addAction(OK)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        if photoSegControl.selectedSegmentIndex == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerController.SourceType.camera
                picker.cameraCaptureMode = .photo
                present(picker, animated: true, completion: nil)
            }
            else {
                noCameraAlert()
            }
        }
        else {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        let current = Double(currentTxt.text!)
        let threshold = Double(thresholdTxt.text!)
        if let image = itemImage.image {
            selectedItem?.setImage(image: image.pngData()!)
        }
        selectedItem?.setCurrent(current: current!)
        selectedItem?.setThreshold(threshold: threshold!)
        
        updateAlert()
    }
}

extension ItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        itemImage.image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage
        picker .dismiss(animated: true, completion: nil)
    }
}
