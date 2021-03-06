//
//  ViewController.swift
//  UUKit
//
//  Created by mail@uxiu.me on 01/03/2019.
//  Copyright (c) 2019 mail@uxiu.me. All rights reserved.
//

import UIKit
import UUKit

class ViewController: UIViewController {
    
    var str: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UUKit"
        
        let btn = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 200), backgroundColor: .green)
        btn.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        view.addSubviews(btn)
        print(Date().weekday)
        print(str.isSome)
        
        btn.setBorder(30, UIColor(hexInt: 0xff0ff0)).setRoundCorner(direction: .topLeft)
        
        let btn1 = UIButton(frame: CGRect(x: 100, y: 410, width: 200, height: 200), backgroundColor: .green)
        btn1.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        view.addSubviews(btn1)
        
    }
    
    @objc func clicked() {
        getContact { (name, phone) in
            //print("\(name)的电话号码是\(phone)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

