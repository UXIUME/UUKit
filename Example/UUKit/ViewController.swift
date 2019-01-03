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
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44), backgroundColor: .green)
        btn.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        //view.addSubviews(btn)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        
        print(Date().weekday)
        print(str.isSome)
    }
    
    @objc func clicked() {
        getContact { (name, phone) in
            print("\(name)的电话号码是\(phone)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

