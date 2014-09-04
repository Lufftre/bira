//
//  BeerInfo.swift
//  bira
//
//  Created by Erik Linder-Norén on 2014-09-03.
//  Copyright (c) 2014 Ludvig Noring. All rights reserved.
//

import UIKit

class BeerInfo: UIViewController, XMLParserDelegate {

    
    var parser = XMLParser()
    
    var ölmärke: String = ""
    var ölnamn: String = " "
    var procenthalt: String = ""
    var ölpris: String = ""
    var ölvolym: String = ""
    var bild: UIImage = UIImage(contentsOfFile: "/Users/Erik/Systembolaget/öltyper/toast-beer.jpg")
    var ölbryggeri: String = ""
    var ölförpackning: String = ""
    var ölursprungsland: String = ""
    var ölid: String = ""
    var smak: String = ""

    @IBOutlet weak var pris: UILabel!
    @IBOutlet weak var namn: UILabel!
    @IBOutlet weak var märke: UILabel!
    @IBOutlet weak var alkoholhalt: UILabel!
    @IBOutlet weak var bärsbild: UIImageView!
    @IBOutlet weak var tillgänglighet: UILabel!
    @IBOutlet weak var bryggeri: UILabel!
    @IBOutlet weak var ursprungsland: UILabel!
    @IBOutlet weak var förpackning: UILabel!
    @IBOutlet weak var volym: UILabel!
    @IBOutlet weak var smakbeskrivning: UILabel!
    @IBOutlet weak var flagga: UIImageView!
    
    override func viewDidLoad() {
        märke.text = ölmärke
        namn.text = ölnamn
        alkoholhalt.text = procenthalt
        println(ölvolym)
        pris.text = ölpris
        smakbeskrivning.text = smak
        smakbeskrivning.lineBreakMode = NSLineBreakMode.ByWordWrapping
        smakbeskrivning.numberOfLines = 0;
        smakbeskrivning.sizeToFit()
        
        title = ölmärke
        bryggeri.text = ölbryggeri
        förpackning.text = ölförpackning
        ursprungsland.text = ölursprungsland
        volym.text = ölvolym
        
        bärsbild.layer.borderColor = UIColor.lightGrayColor().CGColor;
        bärsbild.layer.borderWidth = 1.5;
        bärsbild.layer.cornerRadius = 5.0
        bärsbild.clipsToBounds = true
        
        
        
        
        //http://systembolagetapi.se/?id=1203&format=xml
        
        
    }
    
    func XMLParserError(parser: XMLParser, error: String) {
        println(error)
    }

    
    
    
    
}
