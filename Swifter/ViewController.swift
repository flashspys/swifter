//
//  ViewController.swift
//  Swifter
//  Copyright (c) 2014 Damian Kołakowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var server: HttpServer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let server = demoServer(NSBundle.mainBundle().resourcePath)
        self.server = server
        if !server.start() {
            print("Server start error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func likedThis(sender: UIButton) {
        self.server?.stop();
        self.server = nil;
    }
}

