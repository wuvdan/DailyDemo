//
//  ViewController.swift
//  Demo-Swift
//
//  Created by wudan on 2020/4/27.
//  Copyright © 2020 wudan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
}

