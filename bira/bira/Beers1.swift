//
//  ViewController2.swift
//  bira
//
//  Created by Erik Linder-Norén on 2014-09-01.
//  Copyright (c) 2014 Ludvig Noring. All rights reserved.
//

import UIKit

let path: String =  "/Users/Erik/Systembolaget/öltyper/mörk.xml"

class Beers1: UITableViewController, XMLParserDelegate{
    
    
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        cell.textLabel.text = parser.objects[indexPath.row]["Namn"]
        cell.detailTextLabel.text = parser.objects[indexPath.row]["Varugrupp"]
        return cell
    }
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 120
    }
    
}
