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
    
    
    
    @IBOutlet weak var märke: UILabel!
    @IBOutlet weak var nameAndPrice: UILabel!
    
    
    
}
