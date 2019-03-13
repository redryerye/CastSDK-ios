//
//  ViewController.swift
//  CastSDK-ios-demo
//
//  Created by Yuki Yamamoto on 2019/01/26.
//  Copyright © 2019 Yuki Yamamoto. All rights reserved.
//

import UIKit
import GoogleCast

class ViewController: UIViewController {
    
    @IBOutlet weak var demoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setCastButton()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setCastButton() {

        let castButton = GCKUICastButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        castButton.tintColor = UIColor.blue
        
        
        self.view.addSubview(castButton)
        
        castButton.center = CGPoint(x: view.center.x, y: view.center.y + 100)
        
        
    }
}

