//
//  BeerInfo.swift
//  bira
//
//  Created by Erik Linder-Norén on 2014-09-03.
//  Copyright (c) 2014 Ludvig Noring. All rights reserved.
//

import UIKit

class BeerInfo: UIViewController {

    
    var ölmärke: String = ""
    var ölnamn: String = " "
    var procenthalt: String = ""
    var ölpris: String = ""
    var ölvolym: String = ""
    var bild: UIImage = UIImage(contentsOfFile: "/Users/Erik/Systembolaget/öltyper/toast-beer.jpg")
    var ölbryggeri: String = ""
    var ölförpackning: String = ""
    var ölursprungsland: String = ""

    @IBOutlet weak var pris: UILabel!
    @IBOutlet weak var namn: UILabel!
    @IBOutlet weak var märke: UILabel!
    @IBOutlet weak var alkoholhalt: UILabel!
    @IBOutlet weak var bärsbild: UIImageView!
    @IBOutlet weak var tillgänglighet: UILabel!
    @IBOutlet weak var bryggeri: UILabel!
    @IBOutlet weak var förpackning: UILabel!
    @IBOutlet weak var ursprungsland: UILabel!
    
    override func viewDidLoad() {
        märke.text = ölmärke
        namn.text = ölnamn
        alkoholhalt.text = ölvolym + " - " + procenthalt
        println(ölvolym)
        pris.text = ölpris
        bärsbild.image = bild
        bärsbild.layer.borderColor = UIColor.lightGrayColor().CGColor;
        bärsbild.layer.borderWidth = 1.5;
        bärsbild.layer.cornerRadius = 5.0
        bärsbild.clipsToBounds = true
        title = ölmärke
        bryggeri.text = ölbryggeri
        förpackning.text = ölförpackning
        ursprungsland.text = ölursprungsland
        
        
    }
    
    
}
