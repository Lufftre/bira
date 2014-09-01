
//
//  ViewController.swift
//  bira
//
//  Created by Ludvig Noring on 01/09/14.
//  Copyright (c) 2014 Ludvig Noring. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    func createViewController(title: String){
        let mainViewController: UIViewController = UIViewController()
        mainViewController.title = title
        mainViewController.view.backgroundColor = UIColor.redColor()
        let navController: UINavigationController = self.navigationController
        navController.pushViewController(mainViewController, animated: true)
    }
                            
    @IBAction func mLager(sender: UIButton) {
        
        createViewController(sender.currentTitle)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

