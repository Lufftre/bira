//
//  ItemCell.swift
//  bira
//
//  Created by Erik Linder-Norén on 2014-09-02.
//  Copyright (c) 2014 Ludvig Noring. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    var procenthalt: String = ""
    var ölnamn: String = " "
    var ölpris: String = ""
    var ölmärke: String = ""
    var ölvolym: String = ""
    var ölbryggeri: String = ""
    var ölförpackning: String = ""
    var ölursprungsland: String = ""
    var ölid: String = ""
    var ölsmak: String = ""
    var ölbild: UIImage?
    var apk: String = ""
    
    
    @IBOutlet weak var nr: UILabel!
    @IBOutlet weak var bild: UIImageView!
    @IBOutlet weak var vol: UILabel!
    @IBOutlet weak var ölLabel: UILabel!
    @IBOutlet weak var märke: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var alkoholhalt: UILabel!
    @IBOutlet weak var pris: UILabel!
    @IBOutlet weak var APK: UILabel!
    
    
    
    
}
