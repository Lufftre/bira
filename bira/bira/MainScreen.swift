
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
        title = "BraBärs"
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!){
        println(segue.identifier)
        let vc = segue.destinationViewController as Beers
        switch segue.identifier{
        case "mörk":
            vc.title = "Mörk Lager"
            vc.path = "/Users/Erik/Systembolaget/öltyper/mörk.xml"
        case "ljus":
            vc.title = "Ljus Lager"
            vc.path = "/Users/Erik/Systembolaget/öltyper/ljus.xml"
        case "ale":
            vc.title = "Ale"
            vc.path = "/Users/Erik/Systembolaget/öltyper/ale.xml"
        case "flera":
            vc.title = "Flera typer"
            vc.path = "/Users/Erik/Systembolaget/öltyper/flera.xml"
        case "special":
            vc.title = "Special"
            vc.path = "/Users/Erik/Systembolaget/öltyper/special.xml"
        case "porter":
            vc.title = "Porter och Stout"
            vc.path = "/Users/Erik/Systembolaget/öltyper/porter.xml"
        default:
            println("Okänd typ") //Kommer aldrig hända
        }
    }

}

