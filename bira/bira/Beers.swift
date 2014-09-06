//
//  ViewController2.swift
//  bira
//
//  Created by Erik Linder-Norén on 2014-09-01.
//  Copyright (c) 2014 Ludvig Noring. All rights reserved.
//

import UIKit



class Beers: UITableViewController, XMLParserDelegate, UISearchBarDelegate, UISearchDisplayDelegate{
    
    var path: String = ""

    var parser = XMLParser()
    
    var searchResults = [Dictionary<String, String>()]
    
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
        
        if(tableView == self.searchDisplayController.searchResultsTableView){
            return searchResults.count
        }else{
            return parser.objects.count
        }
        
    }
    
    // Här sätts variablerna som motsvarar märket på ölen, dess namn och priset.
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("ItemCell") as ItemCell
        
        if(tableView == self.searchDisplayController!.searchResultsTableView){
            if(searchResults[indexPath.row]["Prisinklmoms"] != nil){
                let sum = searchResults[indexPath.row]["Prisinklmoms"]! as NSString
                cell.pris.text = sum.substringWithRange(NSRange(location: 0, length: 5)) + "kr"
                cell.ölpris = sum.substringWithRange(NSRange(location: 0, length: 5)) + "kr"
            }
            if(searchResults[indexPath.row]["Namn"] != nil){
                cell.ölmärke = searchResults[indexPath.row]["Namn"]!
                cell.märke.text = cell.ölmärke
            }
            if(searchResults[indexPath.row]["Producent"] != nil){
                cell.ölbryggeri = self.searchResults[indexPath.row]["Producent"]!
            }
            if(searchResults[indexPath.row]["Forpackning"] != nil){
                cell.ölförpackning = searchResults[indexPath.row]["Forpackning"]!
            }
            if(searchResults[indexPath.row]["Ursprunglandnamn"] != nil){
                cell.ölursprungsland = searchResults[indexPath.row]["Ursprunglandnamn"]!
            }
            if(searchResults[indexPath.row]["Varnummer"] != nil){
                cell.ölid = searchResults[indexPath.row]["Varnummer"]!
            }
            if(searchResults[indexPath.row]["Volymiml"] != nil){
                var volym = searchResults[indexPath.row]["Volymiml"]!.toInt()!
                
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
            }
            if(searchResults[indexPath.row]["Alkoholhalt"] != nil){
                cell.procenthalt = searchResults[indexPath.row]["Alkoholhalt"]!
                cell.alkoholhalt.text = cell.procenthalt
            }
            
            cell.name.text = searchResults[indexPath.row]["Namn2"]
            if(cell.name.text == nil){
                cell.name.text = ""
            }else{
                cell.ölnamn = searchResults[indexPath.row]["Namn2"]!
                cell.name.text = cell.ölnamn
            }
            

        }

        else{
            if(parser.objects[indexPath.row]["Prisinklmoms"] != nil){
                let sum = parser.objects[indexPath.row]["Prisinklmoms"]! as NSString
                cell.pris.text = sum.substringWithRange(NSRange(location: 0, length: 5)) + "kr"
                cell.ölpris = sum.substringWithRange(NSRange(location: 0, length: 5)) + "kr"
            }

            cell.ölmärke = parser.objects[indexPath.row]["Namn"]!
            cell.märke.text = cell.ölmärke
            
            if(parser.objects[indexPath.row]["Producent"] != nil){
                cell.ölbryggeri = self.parser.objects[indexPath.row]["Producent"]!
            }
            if(parser.objects[indexPath.row]["Forpackning"] != nil){
                cell.ölförpackning = parser.objects[indexPath.row]["Forpackning"]!
            }
            if(parser.objects[indexPath.row]["Ursprunglandnamn"] != nil){
                cell.ölursprungsland = parser.objects[indexPath.row]["Ursprunglandnamn"]!
            }
            if(parser.objects[indexPath.row]["Varnummer"] != nil){
                cell.ölid = parser.objects[indexPath.row]["Varnummer"]!
            }
            if(parser.objects[indexPath.row]["Volymiml"] != nil){
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
            }
            if(parser.objects[indexPath.row]["Alkoholhalt"] != nil){
                cell.procenthalt = parser.objects[indexPath.row]["Alkoholhalt"]!
                cell.alkoholhalt.text = cell.procenthalt
            }
            
            cell.name.text = parser.objects[indexPath.row]["Namn2"]
            if(cell.name.text == nil){
                cell.name.text = ""
            }else{
                cell.ölnamn = parser.objects[indexPath.row]["Namn2"]!
                cell.name.text = cell.ölnamn
            }
        }
        // Skapar pilen vid cellens högra kortsida.
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        
        return cell

        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        let senderObject = sender as ItemCell
        let vc = segue.destinationViewController as BeerInfo
        let infoParser = XMLParser()
        infoParser.setFilePath("http://systembolagetapi.se/?id=" + senderObject.ölid + "&format=xml", root: "item")
        infoParser.delegate = self
        println(infoParser.filePath)
        infoParser.parse{
            if(infoParser.objects[0]["image"] != nil){
                vc.bärsbild.image = UIImage(data: NSData(contentsOfURL: NSURL(string: infoParser.objects[0]["image"]!)))
                vc.ÖL.text = ""
            }
            if(infoParser.objects[0]["fragrance"] != nil){
                vc.smakbeskrivning.text = infoParser.objects[0]["fragrance"]!
            }
            /*if(infoParser.objects[0]["countryFlag"] != nil){
                vc.flagga.image = UIImage(data: NSData(contentsOfURL: NSURL(string: infoParser.objects[0]["countryFlag"]!)))
            }*/
            
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
        vc.hemsida = "http://www.systembolaget.se/Sok-dryck/Dryck/?varuNr=" + senderObject.ölid
        
        
        
    }
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 100
    }
    
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        
        self.searchResults = self.parser.objects.filter({( object: Dictionary<String,String>) -> Bool in
            if(object["Namn"] == nil){
                return false
            }
            var stringMatchBrand: NSString = NSString(string: object["Namn"]!)
            
            return (stringMatchBrand.rangeOfString(searchText).location != NSNotFound)
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }
    
    
}
