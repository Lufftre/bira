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
    
    var ölnamn: String = " "
    var ölmärke: String = " "
    var ölpris: String = " "
    var procenthalt: String = " "
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parser.setFilePath(path, root: "artikel")
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
    
    // Här sätts variablerna som motsvarar märket på ölen, dess namn och priset.
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell") as ItemCell
        cell.märke.text = parser.objects[indexPath.row]["Namn"]!
        
        
        cell.nameAndPrice.text = parser.objects[indexPath.row]["Namn2"]
        let sum = parser.objects[indexPath.row]["Prisinklmoms"]! as NSString
        
        cell.ölpris = sum.substringWithRange(NSRange(location: 0, length: 5)) + "kr"
        cell.ölmärke = parser.objects[indexPath.row]["Namn"]!
        cell.ölbryggeri = parser.objects[indexPath.row]["Producent"]!
        cell.ölförpackning = parser.objects[indexPath.row]["Forpackning"]!
        cell.ölursprungsland = parser.objects[indexPath.row]["Ursprunglandnamn"]!
        cell.ölid = parser.objects[indexPath.row]["Varnummer"]!
        
        
        var volym = parser.objects[indexPath.row]["Volymiml"]!.toInt()!
        if(volym >= 1000){
            var dec = String(volym % 1000)
            var liters = String(volym / 1000)
            if(dec == "0"){
                cell.ölvolym = liters + "l"
            }
            else{
                cell.ölvolym = liters + "." + dec + "l"
            }
        }
        else{
            var ml = String(volym % 10)
            var cl = String(volym / 10)
            if(ml == "0"){
                cell.ölvolym = cl + "cl"
            }
            else{
                cell.ölvolym = cl + "." + ml + "cl"
            }
        }
        
        cell.procenthalt = parser.objects[indexPath.row]["Alkoholhalt"]!
        
        
        
        
        
        
        if(cell.nameAndPrice.text == nil){
            cell.nameAndPrice.text = cell.ölpris
        }else{
            cell.ölnamn = parser.objects[indexPath.row]["Namn2"]!
            cell.nameAndPrice.text = cell.nameAndPrice.text +  " - " + cell.ölpris
        }
        
        // Skapar pilen vid cellens högra kortsida.
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        let senderObject = sender as ItemCell
        let vc = segue.destinationViewController as BeerInfo
        let infoParser: XMLParser = XMLParser()
        infoParser.setFilePath("http://systembolagetapi.se/?id=" + senderObject.ölid + "&format=xml", root: "item")
        infoParser.delegate = self
        println(infoParser.filePath)
        infoParser.parse{
            if(infoParser.objects[0]["image"] != nil){
                vc.bärsbild.image = UIImage(data: NSData(contentsOfURL: NSURL(string: infoParser.objects[0]["image"]!)))
            }
            if(infoParser.objects[0]["fragrance"] != nil){
                vc.smakbeskrivning.text = infoParser.objects[0]["fragrance"]!
            }
            if(infoParser.objects[0]["countryFlag"] != nil){
                vc.flagga.image = UIImage(data: NSData(contentsOfURL: NSURL(string: infoParser.objects[0]["countryFlag"]!)))
            }
            
        }
        vc.ölmärke = senderObject.ölmärke
        vc.ölnamn = senderObject.ölnamn
        vc.procenthalt = senderObject.procenthalt
        vc.ölvolym = senderObject.ölvolym
        vc.ölpris = senderObject.ölpris
        vc.ölbryggeri = senderObject.ölbryggeri
        vc.ölförpackning = senderObject.ölförpackning
        vc.ölursprungsland = senderObject.ölursprungsland
        vc.ölid = senderObject.ölid
        
        
        
    }
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 100
    }
    
}
