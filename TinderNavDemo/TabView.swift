//
//  TabView.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/16/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

protocol TabViewDelegate: class {
    func tabView(tabView: TabView, didSelectTabAtIndex index: Int)
}

class TabView: UICollectionView {
    var tabs: [String] = ["Cards", "Basic", "Social", "Stuff"]
    var icons: [String] = []
    
    weak var tabDelegate: TabViewDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dataSource = self
        delegate = self
        
        registerNib(UINib(nibName: "TabViewCell", bundle: nil), forCellWithReuseIdentifier: "TabViewCellID")
    }
}

extension TabView: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TabViewCellID", forIndexPath: indexPath) as! TabViewCell
        
        cell.textLabel.text = tabs[indexPath.row]
        cell.iconImageView.image = UIImage(named: "Pic")
        
        return cell
    }
}

extension TabView: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return tabs.count > 0 ? CGSize(width: frame.width / CGFloat(tabs.count), height: frame.height) : CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeZero
    }
}

extension TabView: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        tabDelegate?.tabView(self, didSelectTabAtIndex: indexPath.row)
        
        
    }
}