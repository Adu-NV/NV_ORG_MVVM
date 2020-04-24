//
//  UICollectionViewFlowLayout + Extensions.swift
//  NV_ORG
//
//  Created by Netventure on 23/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class DashBoardBaseCollectionViewLayout: UICollectionViewFlowLayout{
    private var _layoutMap = [IndexPath : UICollectionViewLayoutAttributes]()
    private var _columnsYoffset: [CGFloat]!
    private var _contentSize: CGSize = CGSize(width: 0, height: 0)
    
    private(set) var totalItemsInSection = 0
    
    var totalColumns = 0
    var interItemsSpacing: CGFloat = 8
    
    //MARK: getters
    var contentInsets: UIEdgeInsets {
        return collectionView!.contentInset
    }
    
    override var collectionViewContentSize: CGSize {
        return _contentSize
    }
    
    //MARK: Override methods
    override func prepare() {
        _layoutMap.removeAll()
        self.scrollDirection = .horizontal
        _columnsYoffset = Array(repeating: 0, count: totalColumns)

        totalItemsInSection = collectionView!.numberOfItems(inSection: 0)
        
        if totalItemsInSection > 0 && totalColumns > 0 {
            self.calculateItemsSize()
            
            var itemIndex = 0
            var contentSizeHeight: CGFloat = 0
            
            while itemIndex < totalItemsInSection {
                let indexPath = IndexPath(item: itemIndex, section: 0)
                let columnIndex = self.columnIndexForItemAt(indexPath: indexPath)

                let attributeRect = calculateItemFrame(indexPath: indexPath, columnIndex: columnIndex, columnYoffset: _columnsYoffset[columnIndex])
                let targetLayoutAttributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
                targetLayoutAttributes.frame = attributeRect
                
                contentSizeHeight = max(attributeRect.maxY, contentSizeHeight)
                _columnsYoffset[columnIndex] = attributeRect.maxY + interItemsSpacing
                _layoutMap[indexPath] = targetLayoutAttributes
                
                itemIndex += 1
            }
            
            
            _contentSize = CGSize(width: collectionView!.bounds.width - contentInsets.left - contentInsets.right,
                                  height: contentSizeHeight)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributesArray = [UICollectionViewLayoutAttributes]()
        
        for (_, layoutAttributes) in _layoutMap {
            if rect.intersects(layoutAttributes.frame) {
                layoutAttributesArray.append(layoutAttributes)
            }
        }
        
        return layoutAttributesArray
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return _layoutMap[indexPath]
    }
    
    //MARK: Abstract methods
    func columnIndexForItemAt(indexPath: IndexPath) -> Int {
        return indexPath.item % totalColumns
    }
    func calculateItemFrame(indexPath: IndexPath, columnIndex: Int, columnYoffset: CGFloat) -> CGRect {
        return CGRect.zero
    }
    
    func calculateItemsSize() {}
}




private let kSideItemWidthCoef: CGFloat = 0.3
private let kSideItemHeightAspect: CGFloat = 1
private let kNumberOfSideItems = 3

class DashBoardGalleryLayout: DashBoardBaseCollectionViewLayout {
    private var _mainItemSize: CGSize!
    private var _sideItemSize: CGSize!
    private var _columnsXoffset: [CGFloat]!

    //MARK: Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         self.scrollDirection = .horizontal
        self.totalColumns = 2
    }
    
    //MARK: Override getters
    override var description: String {
        return ""
    }

    //MARK: Override Abstract methods
    override func columnIndexForItemAt(indexPath: IndexPath) -> Int {
        let totalItemsInRow = kNumberOfSideItems + 1
        let columnIndex = indexPath.item % totalItemsInRow
        let columnIndexLimit = totalColumns - 1
        
        return columnIndex > columnIndexLimit  ? columnIndexLimit : columnIndex
    }
    
    override func calculateItemFrame(indexPath: IndexPath, columnIndex: Int, columnYoffset: CGFloat) -> CGRect {
        let size = columnIndex == 0 ? _mainItemSize : _sideItemSize
        return CGRect(origin: CGPoint(x: _columnsXoffset[columnIndex], y: columnYoffset), size: size!)
    }
    
    override func calculateItemsSize() {
        let floatNumberOfSideItems = CGFloat(kNumberOfSideItems)
        let contentWidthWithoutIndents = collectionView!.bounds.width - contentInsets.left - contentInsets.right
        let resolvedContentWidth = contentWidthWithoutIndents - interItemsSpacing
        
        // We need to calculate side item size first, in order to calculate main item height
        let sideItemWidth = resolvedContentWidth * kSideItemWidthCoef
        let sideItemHeight = sideItemWidth * kSideItemHeightAspect
        
        _sideItemSize = CGSize(width: sideItemWidth, height: sideItemHeight)
        
        // Now we can calculate main item height
        let mainItemWidth = resolvedContentWidth - sideItemWidth
        let mainItemHeight = sideItemHeight * floatNumberOfSideItems + ((floatNumberOfSideItems - 1) * interItemsSpacing)
        
        _mainItemSize = CGSize(width: mainItemWidth, height: mainItemHeight)
        
        // Calculating offsets by X for each column
        _columnsXoffset = [0, _mainItemSize.width + interItemsSpacing]
    }
}

