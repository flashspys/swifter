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
        var error: NSError?
        do {
            try server.start(error: &error)
        } catch _ {
            print("Server start error: \(error)")
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

