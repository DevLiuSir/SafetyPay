//
//  ViewController.swift
//  SafetyPayExample
//
//  Created by Liu Chuan on 2018/4/1.
//  Copyright © 2018年 LC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*****  SafetyPayView  *****/
        let vi = SafetyPayView(frame: CGRect(x: (view.bounds.width - 300) / 2, y: 200, width: 300, height: 50))
        vi.style = .plaintext
        view.addSubview(vi)
    }
}
