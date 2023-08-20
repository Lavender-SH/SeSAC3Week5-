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
 
        //serialSync()
        dispatchGroup()
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
    
    func dispatchGroup() {
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator:  " ")
            }
        }
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator:  " ")
            }
        }
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator:  " ")
            }
        }
        DispatchQueue.global().async(group: group) {
            for i in 301...400 {
                print(i, terminator:  " ")
            }
        }
        group.notify(queue: .main) {
            print("END")
        }
    
        
    }

}
