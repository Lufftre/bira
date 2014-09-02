//
//  ViewController2.swift
//  bira
//
//  Created by Erik Linder-Norén on 2014-09-01.
//  Copyright (c) 2014 Ludvig Noring. All rights reserved.
//

import UIKit

let path: String =  "/Users/Erik/Systembolaget/öltyper/mörk.xml"

class Beers: UITableViewController, XMLParserDelegate{

    
    
    var parser = XMLParser(filePath: path)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mörk Lager"
        parser.delegate = self
        parser.parse{
            self.tableView.reloadData()
        }
        
        
    }
    
    func XMLParserError(parser: XMLParser, error: String) {
        println(error)
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return parser.objects.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell") as ItemCell
        cell.name.text = parser.objects[indexPath.row]["Namn"]
        cell.name2.text = parser.objects[indexPath.row]["Namn2"]
        if(cell.name2.text == nil){
            cell.name2.text = parser.objects[indexPath.row]["Alkoholhalt"]
        }else{
            cell.name2.text = cell.name2.text +  ", " + parser.objects[indexPath.row]["Alkoholhalt"]!
        }
        let pris = parser.objects[indexPath.row]["Prisinklmoms"]! as NSString
        
        cell.price.text = pris.substringWithRange(NSRange(location: 0, length: 5)) + "kr"
        
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 100
    }
    
}
