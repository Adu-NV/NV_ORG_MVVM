//
//  UICollectionViewLayout + Extension.swift
//  NV_ORG
//
//  Created by Netventure on 09/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewLayout {
    func getLayout(scrollDirection :UICollectionView.ScrollDirection , itemWidth : CGFloat, itemHeight : CGFloat) -> UICollectionViewFlowLayout{
        var layout = UICollectionViewFlowLayout()
        layout.sectionInset  = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.scrollDirection = scrollDirection
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        return layout
    }
    
    func getLayoutWithEdgeAndSpacing(scrollDirection :UICollectionView.ScrollDirection , itemWidth : CGFloat, itemHeight : CGFloat, edge : UIEdgeInsets , lineSpace : CGFloat , itemSpace : CGFloat ,headerSize : CGSize?) -> UICollectionViewFlowLayout{
        var layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = itemSpace
        layout.minimumLineSpacing = lineSpace
        layout.sectionInset  = edge
        layout.scrollDirection = scrollDirection
        layout.headerReferenceSize = headerSize ?? CGSize(width: 0, height: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        return layout
    }
}
