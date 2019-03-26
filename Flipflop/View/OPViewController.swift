//
//  OPViewController.swift
//  Flipflop
//
//  Created by Jahid Hassan on 3/26/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import UIKit

class OPViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRightSwipeDismiss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
    //MARK:-
    private func addRightSwipeDismiss() {
        let swipGesture = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe(_:)))
        swipGesture.direction = .right
        self.view.addGestureRecognizer(swipGesture)
    }
    
    @objc private func rightSwipe(_ gesture: UISwipeGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}
