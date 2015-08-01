//
//  ContactsCollectionViewCell.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit
import Foundation

class ContactsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.registerNib(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactTableViewCellID")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset.left = 72
    }
}

extension ContactsCollectionViewCell: UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactTableViewCellID", forIndexPath: indexPath) as! ContactTableViewCell
        
        cell.thumbImageView.image = UIImage(named: "Pic")
        cell.nameLabel.text = "Ian M."
        cell.dateLabel.text = "Swapped on 6/15"
        
        return cell
    }
}

extension ContactsCollectionViewCell: UITableViewDelegate {
    
}
