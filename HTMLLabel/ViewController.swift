//
//  ViewController.swift
//  HTMLLabel
//
//  Created by Jim Huang on 2022/5/23.
//

import UIKit

class ViewController: UIViewController, HTMLLabelDelegate {

    @IBOutlet weak var label: HTMLLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let linkStr = "Click <a href='http://google.com'>here</a> to Google."
        
//        self.label.setHTMLText(linkStr)
//        self.label.linkDelegate = self
        
        self.label.setHTMLText(htmlText: linkStr)
        self.label.linkDelegate = self
    }

//    func tappedLinkTextFunction(_ linkString: URL) {
//        UIApplication.shared.open(linkString, options: [:], completionHandler: nil)
//    }
    
    func tappedLinkTextFunction(linkString: URL) {
        UIApplication.shared.open(linkString, options: [:], completionHandler: nil)
    }
}

