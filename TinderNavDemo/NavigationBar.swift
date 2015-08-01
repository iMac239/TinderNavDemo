//
//  TinderNavigationBar.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

protocol NavigationBarDelegate: class {
    func navigationBar(navBar: NavigationBar, didSelectItemAtIndex index: Int)
}

class NavigationBar: UINavigationBar {
    var itemSize: CGFloat = 30
    var sideSpacing: CGFloat = 16
    var navItems: [String] = []
    
    weak var collectionView: UICollectionView?
    weak var navBarDelegate: NavigationBarDelegate?
    var navCollectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = (frame.width - 3 * itemSize - 2 * sideSpacing) / 2
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.scrollDirection = .Horizontal
        layout.headerReferenceSize = CGSizeZero
        layout.footerReferenceSize = CGSizeZero
        layout.sectionInset = UIEdgeInsetsZero

        return layout
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navItems = ["0", "1", "2"]
        
        navCollectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        navCollectionView.registerClass(NavigationCollectionViewCell.self, forCellWithReuseIdentifier: "NavigationCellID")
        navCollectionView.backgroundColor = nil
        navCollectionView.showsHorizontalScrollIndicator = false
        navCollectionView.dataSource = self
        navCollectionView.delegate = self
        
        addSubview(navCollectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        navCollectionView.frame = bounds
        navCollectionView.setCollectionViewLayout(layout, animated: false)
        navCollectionView.contentInset.left = navCollectionView.frame.width / 2 - itemSize / 2
        navCollectionView.contentInset.right = navCollectionView.frame.width / 2 - itemSize / 2
    }
}

extension NavigationBar: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return navItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("NavigationCellID", forIndexPath: indexPath) as! NavigationCollectionViewCell
        return cell
    }
}

extension NavigationBar: UICollectionViewDelegate {
    
    func snapToPage(inout scrollView: UIScrollView) {
        let x = (scrollView.contentOffset.x + scrollView.contentInset.left) / (layout.itemSize.width + layout.minimumLineSpacing)
        
        var item = round(x)
        if item < 0 {
            item = 0
        } else if item > CGFloat(navItems.count - 1) {
            item = CGFloat(navItems.count - 1)
        }
        
        let offset = item * (layout.itemSize.width + layout.minimumLineSpacing) - scrollView.contentInset.left
        scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        print("will begin dragging")
    }
    
    func scrollViewWillBeginDecelerating(var scrollView: UIScrollView) {
        print("will begin decelerating")
        snapToPage(&scrollView)
    }
    
    func scrollViewDidEndDragging(var scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("did end dragging: will decelerate: \(decelerate)")
        snapToPage(&scrollView)
    }
    
    func scrollViewWillEndDragging(var scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("will end dragging: with velocity \(velocity): offset \(targetContentOffset.memory)")
        snapToPage(&scrollView)
    }
    
    func scrollViewDidEndDecelerating(var scrollView: UIScrollView) {
        print("did end decelerating")
        snapToPage(&scrollView)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        print("did scroll")

        let percent = (scrollView.contentOffset.x + scrollView.contentInset.left) / (scrollView.contentSize.width - itemSize)
        let offset = percent * ((collectionView?.contentSize.width ?? 0) - (collectionView?.frame.width ?? 0))
        collectionView?.contentOffset.x = offset
    }
    
    func scrollViewDidEndScrollingAnimation(var scrollView: UIScrollView) {
        
        print("did end animation")

        print("decelerating = \(scrollView.decelerating), dragging = \(scrollView.dragging), tracking = \(scrollView.tracking)")
        snapToPage(&scrollView)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let offset = CGFloat(indexPath.row) * (layout.itemSize.width + layout.minimumLineSpacing) - collectionView.contentInset.left
//        navCollectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
//        
//        navBarDelegate?.navigationBar(self, didSelectItemAtIndex: indexPath.row)
    }
}

class NavigationCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.greenColor()

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}