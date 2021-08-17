//
//  TweetTableViewCell.swift
//  TweetTableViewCell
//
//  Created by Artem Goldenberg on 17.08.2021.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var bodyText: UILabel!
    
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        headlineLabel.text = nil
        createdLabel.text = nil
        profileImage.image = nil
        bodyText.text = nil
        
        if let tweet = tweet {
            bodyText.text = tweet.text
            if bodyText.text != nil {
                tweet.media.forEach { [weak self] _ in self?.bodyText.text! += " 📸" }
            }
        
        
            headlineLabel.text = tweet.user.description
            
            if let profileImageURL = tweet.user.profileImageURL {
                if let imageData = try? Data(contentsOf: profileImageURL as URL) {
                    profileImage.image = UIImage(data: imageData)
                }
            }
            
            let formatter = DateFormatter()
            if Date().timeIntervalSince(tweet.created as Date) > 24 * 60 * 60 {
                formatter.dateStyle = .short
            } else {
                formatter.timeStyle = .short
            }
            
            createdLabel.text = formatter.string(from: tweet.created as Date)
        }
    }
}
 
