//
//  ViewController.swift
//  AnalogCounterViewDemo
//
//  Created by mac on 26/10/18.
//  Copyright © 2018 Dominator. All rights reserved.
//

import UIKit
import AnalogCounterView 
class ViewController: UIViewController {

    @IBOutlet weak var counterView: CounterView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func addAction(_ sender: Any) {
        if counterView.counter < counterView.numberOfItem{
        counterView.counter += 1
        }
    }
    
    @IBAction func subaction(_ sender: Any) {
        if counterView.counter > 0{
        counterView.counter -= 1
        }
    }
}

