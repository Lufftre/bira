//
//  BeerInfo.swift
//  bira
//
//  Created by Erik Linder-Norén on 2014-09-03.
//  Copyright (c) 2014 Ludvig Noring. All rights reserved.
//

import UIKit

class BeerInfo: UIViewController{

    
    
    var ölmärke: String = ""
    var ölnamn: String = " "
    var procenthalt: String = ""
    var ölpris: String = ""
    var ölvolym: String = ""
    var ölbryggeri: String = ""
    var ölförpackning: String = ""
    var ölursprungsland: String = ""
    var ölid: String = ""
    var smak: String = ""
    var hemsida: String = ""
    var systemetIkon = UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("bolaget", ofType: "png")!)
    var bild: UIImage?
    var apk: String = ""
    var hasLoadedImage = false

    @IBOutlet weak var APK: UILabel!
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
    @IBOutlet weak var ÖL: UILabel!
    @IBOutlet weak var produktsida: UIButton!
    
    
    @IBAction func produktsida(sender: AnyObject) {
        var url = NSURL(string: hemsida)
        UIApplication.sharedApplication().openURL(url)
    }
    override func viewDidLoad() {
        
        produktsida.setBackgroundImage(systemetIkon, forState: UIControlState())
        märke.text = ölmärke
        namn.text = ölnamn
        alkoholhalt.text = procenthalt
        pris.text = ölpris
        smakbeskrivning.text = smak
        smakbeskrivning.lineBreakMode = NSLineBreakMode.ByWordWrapping
        smakbeskrivning.numberOfLines = 0;
        smakbeskrivning.sizeToFit()
        
        var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        titleLabel.font = UIFont(name: "Helvetica Light", size: 20)
        titleLabel.text = ölmärke
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.grayColor()
        self.navigationItem.titleView = titleLabel
        
        self.APK.text = self.apk + "ml/kr"
        
        // And the other things
        //title = ölmärke
        bryggeri.text = ölbryggeri
        förpackning.text = ölförpackning
        ursprungsland.text = ölursprungsland
        volym.text = ölvolym
    
        
        ÖL.text = "ÖL"
        if(hasLoadedImage){
            ÖL.text = ""
            bärsbild.image = bild
        }
        bärsbild.backgroundColor = UIColor.whiteColor()
        bärsbild.layer.borderColor = UIColor.lightGrayColor().CGColor;
        bärsbild.layer.borderWidth = 2.0;
        bärsbild.layer.cornerRadius = 5.0
        bärsbild.clipsToBounds = true
        
    }
    
    func XMLParserError(parser: XMLParser, error: String) {
        println(error)
    }

    
    
    
    
}
