//
//  WebKitViewController.swift
//  Bout Time
//
//  Created by Tom Bastable on 27/03/2018.
//  Copyright © 2018 Tom Bastable. All rights reserved.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    //String that will be assigned the eventUrl when requested.
    var eventUrl: String = ""
    
    @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let url = URL(string: eventUrl) {
            let req = URLRequest(url: url)
            myWebView.load(req)
        }
    }
    
    //"One shall dismiss ones self when requested to" - Da Queen
    @IBAction func popWebKitView(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //To match the mockup I removed the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
