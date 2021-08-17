//
//  TwittsViewController.swift
//  TwittsViewController
//
//  Created by Artem Goldenberg on 17.08.2021.
//

import UIKit
import Twitter

class TwittsViewController: UITableViewController {
    
    var tweets = [[Tweet]]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchString: String? {
        didSet {
            tweets.removeAll()
            searchForTweets()
            title = searchString
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchString = "#goldenberg"
    }
    
    private func searchForTweets() {}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }

}
