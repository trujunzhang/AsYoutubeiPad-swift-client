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
    
//    @IBOutlet weak var loadingPanel: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loadingPanel.backgroundColor = UIColor.clearColor()
//        indicatorView.color = UIColor.lightGrayColor()
        indicatorView.color = UIColor.redColor()
    }
    
    // MARK: Loading panel
    func showLoadingPanel() {
//        loadingPanel.hidden = false
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
    }
    
    func hideLoadingPanel() {
//        loadingPanel.hidden = true
        indicatorView.stopAnimating()
    }
    
    // MARK: Layout Panel
    func layoutPanel(){
//       self.view.layoutPanelTopMarginAndHeight(40,height:60)
    }
}