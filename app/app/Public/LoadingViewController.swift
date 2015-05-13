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
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        indicatorView.color = UIColor.lightGrayColor()
        indicatorView.color = UIColor.redColor()
    }
    
    // MARK: Loading panel
    func showLoadingPanel() {
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
    }
    
    func hideLoadingPanel() {
        indicatorView.stopAnimating()
    }
    
    // MARK: Layout Panel
    func layoutPanel(){
       self.view.layoutPanelTopMarginAndHeight(80,height:60)
    }
}