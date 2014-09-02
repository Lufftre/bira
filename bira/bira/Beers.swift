//
//  ViewController2.swift
//  bira
//
//  Created by Erik Linder-Norén on 2014-09-01.
//  Copyright (c) 2014 Ludvig Noring. All rights reserved.
//

import UIKit



class Beers: UITableViewController, XMLParserDelegate{
    
    var path: String = ""

    var parser = XMLParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parser.setFilePath(path)
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
        
        cell.nameAndPrice.text = parser.objects[indexPath.row]["Namn2"]
        let sum = parser.objects[indexPath.row]["Prisinklmoms"]! as NSString
        let pris = sum.substringWithRange(NSRange(location: 0, length: 5)) + "kr"
        
        
        if(cell.nameAndPrice.text == nil){
            cell.nameAndPrice.text = pris
        }else{
            cell.nameAndPrice.text = cell.nameAndPrice.text +  " - " + pris
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 100
    }
    
}
