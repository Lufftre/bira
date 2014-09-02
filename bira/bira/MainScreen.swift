
//
//  ViewController.swift
//  bira
//
//  Created by Ludvig Noring on 01/09/14.
//  Copyright (c) 2014 Ludvig Noring. All rights reserved.
//

import UIKit

class MainScreen: UIViewController {
    
    
    @IBOutlet weak var picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var pic = NSData(contentsOfFile: "/Supporting Files/toast-beer.jpg")
        picture.image = UIImage(data: pic)
    }

}

