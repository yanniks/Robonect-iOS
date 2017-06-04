//
//  FirstViewController.swift
//  Robonect
//
//  Created by Yannik Ehlert on 03.06.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let mower = Mower.createMower(url: "http://mowerhostname") else {
            print("Mower object creation failed!")
            return
        }
        NetworkingRequest.setMowerName(mower: mower) { callback in
            print(callback.isSuccessful)
            if let value = callback.value {
                print(value.name ?? "No timer")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

