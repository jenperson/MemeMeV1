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

    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var imagePickerView: UIImageView!
    //@IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    let memeDelegate = MemeTextFieldDelegate()
    
    // sets attributes of text
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set behaviors of text boxes
        self.bottomTextField.delegate = memeDelegate
        self.topTextField.delegate = memeDelegate
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.defaultTextAttributes = memeTextAttributes
    }
    
    override func viewWillAppear(animated: Bool) {
        // only enables camera button if the camera is available for taking pictures
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // notifies when keyboard appers and goes away
        self.subscribeToKeyboardNotifications()

    }
    
    // pops up camera roll to selecte photos
    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // enables user to take a photo
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    // sends photo user selected to image viewer and formats to fit screen
    func imagePickerController(_picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            
       if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        imagePickerView.image = image
        }
            
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // moves frame up when keyboard shows
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
                self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    // gets height of keyboard to move up frame
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as!NSValue
        return keyboardSize.CGRectValue().height
    }
    
    // moves frame back down after moving up keyboard
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y = 0
        }
    }
    
    // notifies when keyboard is raised
    func subscribeToKeyboardNotifications() {
     NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
    }
    
    // turns off notification
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // Unsubscribe
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        toolbar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar
        toolbar.hidden = false
        
        return memedImage
    }
        
    
    @IBAction func share(sender: AnyObject) {
        let memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { (s: String?, ok: Bool, items: [AnyObject]?, err: NSError?) -> Void in
            if ok {
                self.save()
                NSLog("Successfully saved image.")
            } else if err != nil {
                NSLog("Error: \(err)")
            } else {
                NSLog("Unknown cancel -- user likely clicked \"cancel\" to dismiss activity view.")
            }
        }
        
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    func save() {
        //Create the meme
        let meme = Meme(topTextField: topTextField.text!, bottomTextField: bottomTextField.text!, image:
            imagePickerView.image!, memedImage: generateMemedImage())
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
}



