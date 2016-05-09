//
//  MemeTextFieldDelegate.swift
//  MemeMe 1
//
//  Created by Jennifer Person on 5/9/16.
//  Copyright © 2016 Jennifer Person. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate : NSObject, UITextFieldDelegate {
    // Text Field Delegate Methods
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        func textFieldDidBeginEditing(textField: UITextField) {
            textField.text = ""
        }
        
        // Figure out what the new text will be, if we return true
        var newText: NSString = textField.text!
        newText = newText.stringByReplacingCharactersInRange(range, withString: string)
        
        

        // returning true gives the text field permission to change its text
        return true;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}
