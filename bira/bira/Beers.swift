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
    var titleText: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        titleLabel.font = UIFont(name: "Helvetica Light", size: 20)
        titleLabel.text = titleText
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.redColor()
        self.navigationItem.titleView = titleLabel
        
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
            return self.searchResults.count
        }else{
            return self.parser.objects.count
        }
        
    }
    
    // Här sätts variablerna som motsvarar märket på ölen, dess namn och priset.
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("ItemCell") as ItemCell
        
        if(tableView == self.searchDisplayController!.searchResultsTableView){
            setCellVariables(cell, dict: self.searchResults[indexPath.row])

        }

        else{
            setCellVariables(cell, dict: self.parser.objects[indexPath.row])
        }
        return cell
    }
        
        func setCellVariables(cell: ItemCell, dict: Dictionary<String,String>){
                if(dict["Prisinklmoms"] != nil){
                    let sum = dict["Prisinklmoms"]! as NSString
                    cell.pris.text = sum.substringWithRange(NSRange(location: 0, length: 5)) + "kr"
                    cell.ölpris = sum.substringWithRange(NSRange(location: 0, length: 5)) + "kr"
                }
                if(dict["Namn"] != nil){
                    cell.ölmärke = dict["Namn"]!
                    cell.märke.text = cell.ölmärke
                }
                if(dict["Producent"] != nil){
                    cell.ölbryggeri = dict["Producent"]!
                }
                if(dict["Forpackning"] != nil){
                    cell.ölförpackning = dict["Forpackning"]!
                }
                if(dict["Ursprunglandnamn"] != nil){
                    cell.ölursprungsland = dict["Ursprunglandnamn"]!
                }
                if(dict["Varnummer"] != nil){
                    cell.ölid = dict["Varnummer"]!
                }
                if(dict["Volymiml"] != nil){
                    var volym = dict["Volymiml"]!.toInt()!
                    
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
                if(dict["Alkoholhalt"] != nil){
                    cell.procenthalt = dict["Alkoholhalt"]!
                    cell.alkoholhalt.text = cell.procenthalt
                }
                
                cell.name.text = dict["Namn2"]
                if(cell.name.text == nil){
                    cell.name.text = ""
                }else{
                    cell.ölnamn = dict["Namn2"]!
                    cell.name.text = cell.ölnamn
                }
            
                // Skapar pilen vid cellens högra kortsida.
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                
                return

            }
    
    

    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        let senderObject = sender as ItemCell
        let vc = segue.destinationViewController as BeerInfo
        
        let infoParser = XMLParser()
        
        // Gets the image representing the beer and the taste description
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
    
    // Size of each cell
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 110    }
    
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        
        self.searchResults = self.parser.objects.filter({( object: Dictionary<String,String>) -> Bool in
            if(object["Namn"] == nil){
                return false
            }
            var stringMatchBrand: NSString = NSString(string: object["Namn"]!).lowercaseString
            
            return (stringMatchBrand.rangeOfString(searchText.lowercaseString).location != NSNotFound)
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }
    
    
}
