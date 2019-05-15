//
//  ViewController.swift
//  Auto Complete With TextView
//
//  Created by Apple on 15/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import DropDown

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.last == "#" {
            
            let endPosition: UITextPosition = textView.endOfDocument
            
            //Get courser position to show dropdown
            let rect = textView.caretRect(for: endPosition)
            
            //Create a custom view to provide anchorView to DropDown
            let customView = UIView(frame: CGRect(x: rect.origin.x, y: rect.origin.y, width: 200, height: 0))
            textView.addSubview(customView)
            
            dropDown.anchorView = customView  // UIView or UIBarButtonItem
            
            // The list of items to display. Can be changed dynamically
            dropDown.dataSource = ["Car", "Motorcycle", "Truck"]
            
            // Action triggered on selection
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                //remove Custom view as we no longer needed it.
                customView.removeFromSuperview()
                
                //Set your text accourding to selection from dropdown item.
                textView.text = textView.text.dropLast() + " " + "\(item)"
            }
            
            dropDown.show()
        }
    }
}

