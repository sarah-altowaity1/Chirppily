//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Sarah Al-Towaity on 30/09/2022.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    var favorited:Bool = false
    var retweeted:Bool = false
    var tweetId: Int = -1
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        
        if (toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetId, success:{
                self.setFavorite(true)
            }, failure: { (error)
                in print("Favorite did not succeed \(error)")
            })
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetId, success:{
                self.setFavorite(false)
            }, failure: { (error)
                in print("Unfavorite did not succeed \(error)")
            })
        }
        
    }
    
    @IBAction func retweetTweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Retweet did not succeed \(error)")
        })
        
    }
    
    func setRetweeted(_ isRetweeted: Bool){
        if (isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
        
        
    }

    func setFavorite(_ isFavorited: Bool){
        favorited = isFavorited
        if (favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
}
