//
//  GalleryViewController.swift
//  NV_ORG
//
//  Created by Netventure on 04/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
setUI()
        // Do any additional setup after loading the view.
    }
    
    func setUI(){
        //            leadershipCollectionView.backgroundColor = .lightGray
        self.galleryCollectionView!.register(GalleryCollectionViewReusableCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:"GalleryCollectionViewReusableCell")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.itemSize = CGSize(width: self.view.frame.width / 3 - 2, height: 140)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 50)
        galleryCollectionView!.collectionViewLayout = layout
        galleryCollectionView.layoutIfNeeded()
    }

    

}

extension GalleryViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GalleryCollectionViewReusableCell", for: indexPath) as! GalleryCollectionViewReusableCell
            header.headerLabels.text = "PHOTOS"
            header.backgroundColor = UIColor.clear
             return header
         }

         abort()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell =  galleryCollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCollectionViewCell", for: indexPath) as! galleryCollectionViewCell
        cell.contentView.setViewCornerRadiusWithBorder(radius: 2.0, borderColor: UIColor.lightGray, width: 0.5)
        cell.backgroundColor = .white
//        cell.setShadow(radius: 10.0)
        return cell
    }
    
}



