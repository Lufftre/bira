
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
        var pic = NSData(contentsOfFile: "/Users/Erik/Systembolaget/öltyper/bärs.jpg")
        picture.image = UIImage(data: pic)
        
        var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        titleLabel.font = UIFont(name: "Helvetica Light", size: 20)
        titleLabel.text = "BraBärs"
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.redColor()
        self.navigationItem.titleView = titleLabel
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!){
        println(segue.identifier)
        let vc = segue.destinationViewController as Beers
        switch segue.identifier{
        case "mörk":
            vc.titleText = "Mörk Lager"
            vc.path = "/Users/Erik/Systembolaget/öltyper/mörk.xml"
        case "ljus":
            vc.titleText = "Ljus Lager"
            vc.path = "/Users/Erik/Systembolaget/öltyper/ljus.xml"
        case "ale":
            vc.titleText = "Ale"
            vc.path = "/Users/Erik/Systembolaget/öltyper/ale.xml"
        case "flera":
            vc.titleText = "Flera typer"
            vc.path = "/Users/Erik/Systembolaget/öltyper/flera.xml"
        case "special":
            vc.titleText = "Special"
            vc.path = "/Users/Erik/Systembolaget/öltyper/special.xml"
        case "porter":
            vc.titleText = "Porter och Stout"
            vc.path = "/Users/Erik/Systembolaget/öltyper/porter.xml"
        default:
            println("Okänd typ") //Kommer aldrig hända
        }
    }

}

