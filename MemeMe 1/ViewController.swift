//
//  ViewController.swift
//  MemeMe 1
//
//  Created by Jennifer Person on 5/8/16.
//  Copyright © 2016 Jennifer Person. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
        

    }
    
    func imagePickerController(_picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            
       if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        imagePickerView.image = image
        }
            
        dismissViewControllerAnimated(true, completion: nil)
    }
    

}

