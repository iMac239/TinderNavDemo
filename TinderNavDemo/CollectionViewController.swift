//
//  CollectionViewController.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: UICollectionViewController {
    var navBar: NavigationBar?
    var startPoint: CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()

        navBar = navigationController?.navigationBar as? NavigationBar
        navBar?.navBarDelegate = self
        navBar?.collectionView = collectionView
        
        collectionView?.alwaysBounceHorizontal = true
        collectionView?.setContentOffset(CGPointZero, animated: false)
    
        collectionView?.registerNib(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCellID")
        collectionView?.registerNib(UINib(nibName: "SwapCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SwapCellID")
        collectionView?.registerNib(UINib(nibName: "ContactsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ContactsCellID")
    }
}

// MARK - CollectionView Data Source
extension CollectionViewController {
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProfileCellID", forIndexPath: indexPath) as! ProfileCollectionViewCell
            return cell
        
        case 1:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SwapCellID", forIndexPath: indexPath) as! SwapCollectionViewCell
            return cell

        case 2:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ContactsCellID", forIndexPath: indexPath) as! ContactsCollectionViewCell
            return cell
        
        default:

            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProfileCellID", forIndexPath: indexPath) as! ProfileCollectionViewCell
            return cell
        }
    }
}

// MARK - CollectionView Delegate Flow Layout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        return view.frame.size
    }
}

// MARK - ScrollView Delegate
extension CollectionViewController {
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
            let percent = scrollView.contentOffset.x / (scrollView.contentSize.width - scrollView.frame.width)
            let contentWidth = (navBar?.navCollectionView?.contentSize.width ?? 0)
            let frameWidth = (navBar?.navCollectionView?.frame.width ?? 0)
            let leftInset = (navBar?.navCollectionView.contentInset.left ?? 0)
            let rightInset = (navBar?.navCollectionView.contentInset.right ?? 0)
            let offset = -leftInset + percent * (contentWidth + leftInset + rightInset - frameWidth)
            
            navBar?.navCollectionView.contentOffset.x = offset
    }
}

// MARK - NavigationBar Delegate
extension CollectionViewController: NavigationBarDelegate {
    
    func navigationBar(navBar: NavigationBar, didSelectItemAtIndex index: Int) {
        collectionView?.setContentOffset(CGPoint(x: CGFloat(index) * (collectionView?.frame.width ?? 1), y: 0), animated: true)

    }
}