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
    
    private var lastTwitterRequest: Request?
    
    private var twitterRequest: Request? {
        if let query = searchString, !query.isEmpty {
            return Request(search: query + " -filters:retweets", count: 100)
        }
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchString = "#stanford"
    }
    
    private func searchForTweets() {
        if let request = twitterRequest {
            request.fetchTweets { [weak self] newTweets in
                DispatchQueue.main.async {
                    if self?.lastTwitterRequest == request && !newTweets.isEmpty {
                        self?.tweets.insert(newTweets, at: 0)
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.tweetCellIdentifier, for: indexPath)
        
        let tweet = tweets[indexPath.section][indexPath.row]
        
        if let tweetCell = cell as? TweetTableViewCell {
            tweetCell.tweet = tweet
        }
        
        return cell
    }
    
    private struct Storyboard {
        static let tweetCellIdentifier = "tweet"
    }

}
