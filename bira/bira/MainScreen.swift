

import UIKit

class MainScreen: UIViewController {
    
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var backEndLogo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var pic = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("bärs", ofType: "jpg")!)
        var logo = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("poweredbyuntapped", ofType: "png")!)
        picture.image = UIImage(data: pic)
        backEndLogo.image = UIImage(data: logo)
        
        var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        titleLabel.font = UIFont(name: "Helvetica Light", size: 20)
        titleLabel.text = "BraBärs"
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.redColor()
        self.navigationItem.titleView = titleLabel
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!){
        println(segue.identifier)
        let vc = segue.destinationViewController as Beers
        switch segue.identifier{
        case "mörk":
            vc.titleText = "Mörk Lager"
            vc.path = NSBundle.mainBundle().pathForResource("mörk", ofType: "xml")!
        case "ljus":
            vc.titleText = "Ljus Lager"
            vc.path = NSBundle.mainBundle().pathForResource("ljus", ofType: "xml")!
        case "ale":
            vc.titleText = "Ale"
            vc.path = NSBundle.mainBundle().pathForResource("ale", ofType: "xml")!
        case "flera":
            vc.titleText = "Flera typer"
            vc.path = NSBundle.mainBundle().pathForResource("flera", ofType: "xml")!
        case "special":
            vc.titleText = "Special"
            vc.path = NSBundle.mainBundle().pathForResource("special", ofType: "xml")!
        case "porter":
            vc.titleText = "Porter och Stout"
            vc.path = NSBundle.mainBundle().pathForResource("porter", ofType: "xml")!
        default:
            println("Okänd typ") //Kommer aldrig hända
        }
    }

}

