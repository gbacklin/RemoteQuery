//
//  DetailTableViewController.swift
//  RemoteQuery
//
//  Created by Gene Backlin on 2/18/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    @IBOutlet weak var firstNameTableViewCell: UITableViewCell!
    @IBOutlet weak var lastNameTableViewCell: UITableViewCell!
    @IBOutlet weak var homeTownTableViewCell: UITableViewCell!
    @IBOutlet weak var ageTableViewCell: UITableViewCell!
    @IBOutlet weak var jobTableViewCell: UITableViewCell!
    
    var object: [String : AnyObject]?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Initialization
    
    func setupUI() {
        title = "Details"
        
        navigationController?.navigationBar.tintColor = UIColor.black
        firstNameTableViewCell.textLabel!.text = object!["Firstname"] as? String
        lastNameTableViewCell.textLabel!.text = object!["Lastname"] as? String
        homeTownTableViewCell.detailTextLabel!.text = object!["Hometown"] as? String
        ageTableViewCell.detailTextLabel!.text = object!["Age"] as? String
        jobTableViewCell.detailTextLabel!.text = object!["Job"] as? String
    }
}
