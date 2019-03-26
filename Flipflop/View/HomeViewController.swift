//
//  HomeViewController.swift
//  Flipflop
//
//  Created by Jahid Hassan on 3/26/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descriptionView: VideoDescriptionView!
    
    lazy var viewModel : HomeViewModel = {
        return HomeViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindObservables()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        viewModel.fetchVideoPosts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // video, playing in collection view cell, will continue playing after
        // view controller disapearance
        // sending notification to the current cell to stop playing
        NotificationCenter.default.post(name: HomeWillDisappear, object: nil)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // button actions
    @IBAction func sharePressed(_ sender: UIButton) {
        showAlert("Hmmm...", msg: "Feature is not implemented yet")
    }
    
    @IBAction func likePressed(_ sender: UIButton) {
        showAlert("Hmmm...", msg: "Feature is not implemented yet")
    }
    
    @IBAction func opProfilePressed(_ sender: Any) {
        showAlert("Hmmm...", msg: "Feature is not implemented yet")
    }
}

extension HomeViewController {
    fileprivate func configureView() {
        // adjust collection view top inset
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        collectionView.contentInset = .zero
        
        // handle middle recode button tap in AppDelegate
        self.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
        
        // register collection view cell
        let cell_id = Identifier.videoCell.rawValue
        collectionView.register(UINib(nibName: cell_id,
                                      bundle: nil),
                                forCellWithReuseIdentifier: cell_id)
        
        // left swipe functionality to slide poster profile
        let leftSwipGesture = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe(_:)))
        leftSwipGesture.direction = .left
        collectionView.addGestureRecognizer(leftSwipGesture)
    }
    
    fileprivate func bindObservables() {
        viewModel.onDataUpdate = { [weak self] error in
            if let err = error {
                self?.showAlert(msg: err.localizedDescription)
                return
            }
            
            self?.collectionView.reloadData()
        }
        
        viewModel.onIndexUpdate = { [weak self] post in
            self?.descriptionView.post = post
        }
    }
    
    fileprivate func showAlert(_ title: String = "ERROR!", msg: String) {
        let controller = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        present(controller, animated: true, completion: nil)
    }
    
    @objc private func leftSwipe(_ gesture: UISwipeGestureRecognizer) {
        guard let user = storyboard?.instantiateViewController(withIdentifier: "OPViewController") as? OPViewController else {
            return
        }
        
        navigationController?.pushViewController(user, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: VideoCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.videoCell.rawValue,
                                                                 for: indexPath) as! VideoCell
        
        let post = viewModel.getPost(for: indexPath.item)
        cell.videoUrl = Bundle.main.url(forResource: "glitch", withExtension: "mp4") ?? post.url
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.currentIndex = indexPath.item
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
