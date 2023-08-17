//
//  GCDBasicViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class GCDBasicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        serialSync()
    }
    
    func serialSync() {
        print("Start")
        
        for i in 1...100 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
}
