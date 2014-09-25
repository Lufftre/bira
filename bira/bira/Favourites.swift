//
//  Favourites.swift
//  bira
//
//  Created by Erik Linder-Norén on 2014-09-25.
//  Copyright (c) 2014 Ludvig Noring. All rights reserved.
//

import UIKit

class Favourites: UITableViewController {
    
    var cache_images = Dictionary<String, UIImage>()
    var favs = [Dictionary<String,String>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        titleLabel.font = UIFont(name: "Helvetica Light", size: 20)
        titleLabel.text = "Favoriter"
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.grayColor()
        self.navigationItem.titleView = titleLabel
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favs.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FavCell", forIndexPath: indexPath) as FavCell

        setCellVariables(cell, dict: favs[indexPath.row])

        return cell
    }
    
    func setCellVariables(cell: FavCell, dict: Dictionary<String,String>){
        
        var kr = 0.0
        var alcohol = 0.0
        var vol = 0.0
        
        var formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        cell.beerInfo = dict
        
        if(dict["Prisinklmoms"] != nil){
            
            let sum = dict["Prisinklmoms"]! as NSString
            kr = NSDecimalNumber.decimalNumberWithString(sum, locale: nil)
            cell.pris.text = NSString(format:"%.2f", kr) + "kr"
            cell.ölpris = NSString(format:"%.2f", kr) + "kr"
        }
        if(dict["Namn"] != nil){
            cell.ölmärke = dict["Namn"]!
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
        
        
        //Placeholders
        cell.bild.image = UIImage()
        cell.ölLabel.text = "ÖL"
        cell.ölbild = nil
        if(cache_images[cell.ölid] != nil){
            cell.bild.image = cache_images[cell.ölid]
            cell.ölbild = cache_images[cell.ölid]
            cell.ölLabel.text = ""
            println(cell.ölid)
        }else{
            if(dict["image"] != nil){
                let request: NSURLRequest = NSURLRequest(URL: NSURL(string: dict["image"]!))
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                    if(error == nil){
                        dispatch_async(dispatch_get_main_queue()) {
                            cell.bild.image = UIImage(data: data)
                            cell.ölbild = cell.bild.image
                            self.cache_images[cell.ölid] = cell.ölbild
                            cell.ölLabel.text = ""
                        }
                    }else{
                        println("Error: \(error.localizedDescription)")
                    }
                    
                })
            }
        }
        
        if(dict["fragrance"] != nil){
            cell.ölsmak = dict["fragrance"]!
        }
        
        if(dict["Volymiml"] != nil){
            var volym = dict["Volymiml"]!.toInt()!
            vol = formatter.numberFromString(dict["Volymiml"]!)!.doubleValue
            
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
        cell.vol.text = cell.ölvolym
        if(dict["Alkoholhalt"] != nil){
            let proc = dict["Alkoholhalt"]!
            cell.procenthalt = proc
            cell.alkoholhalt.text = proc
            
            var numb = proc.stringByReplacingOccurrencesOfString("%", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            var test = NSDecimalNumber.decimalNumberWithString(numb, locale: nil)
            alcohol = test.doubleValue
            
        }
        
        var apk = ((alcohol*0.01*vol)/kr)
        cell.apk = NSString(format:"%.2f", apk)
        cell.APK.text = cell.apk + "ml/kr"
        
        
        cell.name.text =  "" // Placeholder
        cell.ölnamn = "" // Placeholder
        if(dict["Namn2"] != nil){
            cell.ölnamn = dict["Namn2"]!
            cell.name.text = cell.ölnamn
        }
        
        // Skapar pilen vid cellens högra kortsida.
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return
        
    }

    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        let senderObject = sender as ItemCell
        let vc = segue.destinationViewController as BeerInfo
        
        vc.beerInfo = senderObject.beerInfo
        vc.placeholderImgText = senderObject.ölLabel.text!
        vc.bild = senderObject.ölbild
        vc.apk = senderObject.apk
        vc.smak = senderObject.ölsmak
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
    

}
