//
//  BuissnessWebViewVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 09/11/23.
//

import UIKit
import WebKit

class BuissnessWebViewVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    var webUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSwipeNavigation()
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.navigationDelegate = self
        // Load URL
        if let url = URL(string: webUrl ?? "") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    private func setSwipeNavigation(){
        // Add a swipe gesture recognizer for left swipes
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        leftSwipeGesture.direction = .left
        view.addGestureRecognizer(leftSwipeGesture)
        
        // Add a swipe gesture recognizer for right swipes
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        rightSwipeGesture.direction = .right
        view.addGestureRecognizer(rightSwipeGesture)
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            print("")
        } else if gesture.direction == .right {
            self.navigationController?.popViewController(animated: true)
        }
    }

}
