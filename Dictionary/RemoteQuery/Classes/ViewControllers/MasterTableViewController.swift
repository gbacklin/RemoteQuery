//
//  MasterTableViewController.swift
//  RemoteQuery
//
//  Created by Gene Backlin on 2/18/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

let QUERY = "http://www.ehmz.org/ajax/ajax_query.php"

class MasterTableViewController: UITableViewController {

    var objects: [AnyObject] = [AnyObject]()
    var titleText = "Data"
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = titleText
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        titleText = title!
        title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        if let record: [String : AnyObject] = objects[indexPath.row] as? [String : AnyObject] {
            cell.textLabel!.text = record["Lastname"] as? String
            cell.detailTextLabel!.text = record["Firstname"] as? String
        } else {
            cell.textLabel!.text = "No record found"
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            let controller: DetailTableViewController = segue.destination as! DetailTableViewController
            let indexPath = tableView.indexPathForSelectedRow
            if let record: [String : AnyObject] = objects[indexPath!.row] as? [String : AnyObject] {
                controller.object = record
            } else {
                controller.object = [String : AnyObject]()
            }
        }
    }

    // MARK: - Initialization
    
    func setupUI() {
        titleText = "Fetching Data..."

        // Fetch data...
        Network.sharedInstance.get(url: QUERY) { [weak self] (results, error) in
            if error != nil {
                self!.handleError(error: error!)
            } else {
                if let response = results {
                    DispatchQueue.main.async {
                        self!.title = "Found (\(response.count)) records"
                        self!.objects = response
                        self!.tableView.reloadData()
                    }
                } else {
                    let error: NSError = self!.createError(domain: NSURLErrorDomain, code: -1955, text: "The results from the query were nil") as NSError
                    self!.handleError(error: error)
                }
            }
        }
    }
    
    // MARK: - Utility methods
    
    func handleError(error: Error) {
        let errorMessage = error.localizedDescription
        
        // alert user that our current record was deleted, and then we leave this view controller
        //
        let alert: UIAlertController = UIAlertController(title: NSLocalizedString("Cannot complete the process", comment: ""), message: errorMessage, preferredStyle: .actionSheet)
        let OKAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { (action) in
            // dissmissal of alert completed
        }
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }

    func createError(domain: String, code: Int, text: String) -> Error {
        let userInfo: [String : String] = [NSLocalizedDescriptionKey: text]
        
        return NSError(domain: domain, code: code, userInfo: userInfo)
    }

}
