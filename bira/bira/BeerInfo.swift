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

    @IBOutlet weak var pris: UILabel!
    @IBOutlet weak var namn: UILabel!
    
    @IBOutlet weak var märke: UILabel!
    @IBOutlet weak var alkoholhalt: UILabel!
    
    
    @IBOutlet weak var bärsbild: UIImageView!
    @IBOutlet weak var tillgänglighet: UILabel!
    
    override func viewDidLoad() {
        märke.text = ölmärke
        namn.text = ölnamn
        alkoholhalt.text = ölvolym + " - " + procenthalt
        println(ölvolym)
        pris.text = ölpris
        bärsbild.image = bild
        title = ölmärke
        
        
    }
    
    
}
