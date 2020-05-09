//
//  LeaderShipViewController.swift
//  NV_ORG
//
//  Created by Netventure on 31/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class LeaderShipViewController: UIViewController {
    let leadershipVM = LeaderShipViewModel()
    @IBOutlet weak var leadershipCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        leadershipVM.skipButtontapped(view: self)
    }

}

extension LeaderShipViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        leadershipVM.numberOfRowsInSection(section)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LeadershipCollectionViewReusableCell", for: indexPath) as! LeadershipCollectionViewReusableCell
            header.headerLabel.text = "MEMBERS"
            header.backgroundColor = UIColor.clear
             return header
         }

         abort()
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell =  LeadershipCollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeadershipCollectionViewCell", for: indexPath) as! LeadershipCollectionViewCell
        cell.contentView.setViewCornerRadiusWithBorder(radius: 10.0, borderColor: UIColor.lightGray, width: 1.0)
        cell.backgroundColor = .white
        cell.setShadow(radius: 10.0)
        return cell
    }
    
}
    extension LeaderShipViewController {
        func setUI(){
            //            leadershipCollectionView.backgroundColor = .lightGray
            self.leadershipCollectionView!.register(LeadershipCollectionViewReusableCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:"LeadershipCollectionViewReusableCell")
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//            layout.itemSize = CGSize(width: self.view.frame.width / 2 - 15, height: 180)
//            layout.minimumInteritemSpacing = 10
//            layout.minimumLineSpacing = 10
//            layout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 50)
            leadershipCollectionView!.collectionViewLayout = layout.getLayoutWithEdgeAndSpacing(scrollDirection: .vertical, itemWidth:  self.view.frame.width / 2 - 15, itemHeight: 180, edge: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), lineSpace: 10, itemSpace: 10, headerSize: CGSize(width: self.view.frame.width, height: 50))
            leadershipCollectionView.layoutIfNeeded()
        }
}

