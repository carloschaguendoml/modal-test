//
//  ViewController.swift
//  TestView
//
//  Created by Carlos Chaguendo on 4/05/22.
//

import UIKit

struct Page {
    
    let tile: String
    let body: String
    let header: AndesModalPageHeaderView.ContentMode
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionVIew: UICollectionView!
    
    var pages: [Page] = []
    
    let modes:[AndesModalPageHeaderView.ContentMode] = [.full, .tmb, .hidden]
    var currentMode = 0
    
    @IBOutlet weak var headerView: AndesModalPageHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.mode = .hidden
        
        collectionVIew.dataSource = self
        collectionVIew.delegate = self
        
        let nib = UINib(nibName: "AndesModalPageCollectionViewCell", bundle: Bundle.main)
        collectionVIew.register(nib, forCellWithReuseIdentifier: "default")
        
        pages = [
            Page(tile: "Titulo", body: "Contenido", header: .tmb),
            Page(tile: "Titulo", body: "Contenido", header: .full)
        ]
        

    }
    
    @IBAction func updateContentModeAction(_ sender: Any) {
        currentMode += 1
        if currentMode >= modes.count {
            currentMode = 0
        }
        headerView.mode = modes[currentMode]
        collectionVIew.collectionViewLayout.invalidateLayout()
        collectionVIew.reloadData()
        
       
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath) as! AndesModalPageCollectionViewCell

        cell.page = self.pages[indexPath.row]
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

