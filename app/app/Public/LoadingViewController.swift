//
//  LoadingViewController.swift
//  app
//
//  Created by djzhang on 5/6/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var loadingPanel: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingPanel.backgroundColor = UIColor.clearColor()
        
        indicatorView.color = UIColor.lightGrayColor()
    }
    
    // MARK: Loading panel
    func showLoadingPanel() {
        
        
        loadingPanel.hidden = false
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
        
        
    }
    
    func hideLoadingPanel() {
        loadingPanel.hidden = true
        indicatorView.stopAnimating()
    }
    
    // MARK: Layout Panel
    func layoutPanel(){
        layout(self.view) {
            view1 in
            
            view1.leading == view1.superview!.leading
            view1.trailing == view1.superview!.trailing
            
            view1.top == view1.superview!.top + 40
            view1.height == 60
        }
    }
}