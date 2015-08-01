//
//  ProfileCollectionViewCell.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.registerNib(UINib(nibName: "ProfileCardCell", bundle: nil), forCellReuseIdentifier: "ProfileCardCellID")
        tableView.registerNib(UINib(nibName: "ProfileHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ProfileHeaderViewID")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ProfileCollectionViewCell: UITableViewDataSource {
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier("ProfileHeaderViewID") as! ProfileHeaderView
        view.tabView.tabDelegate = self
        return view
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 224
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCardCellID", forIndexPath: indexPath) as! ProfileCardCell
        
        cell.textLabel?.text = "Ian M."
        cell.detailTextLabel?.text = "Swapped on 6/15"
        
        return cell
    }
}

extension ProfileCollectionViewCell: UITableViewDelegate {
    
}

extension ProfileCollectionViewCell: TabViewDelegate {
    func tabView(tabView: TabView, didSelectTabAtIndex index: Int) {
        print("tab \(index)")
    }
}
