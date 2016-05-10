//
//  Meme.swift
//  MemeMe 1
//
//  Created by Jennifer Person on 5/9/16.
//  Copyright © 2016 Jennifer Person. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topTextField: NSString!
    var bottomTextField:NSString!
    var image: UIImage!
    var memedImage: UIImage!
    
    init(topTextField:NSString, bottomTextField:NSString,
        image: UIImage, memedImage: UIImage){
            self.topTextField = topTextField
            self.bottomTextField = bottomTextField
            self.image = image
            self.memedImage = memedImage
    }
}
