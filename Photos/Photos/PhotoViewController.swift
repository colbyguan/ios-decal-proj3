//
//  PhotoViewController.swift
//  Photos
//
//  Created by Colby on 11/15/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    var idx: Int = 0
    var photos: [Photo]! = []
    var alreadyLiked = false
    
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBAction func likeButtonPressed(sender: AnyObject) {
        likeButton.setTitle("Liked!", forState: .Normal)
        if (!alreadyLiked) {
            photos[idx].likes! += 1
            likesLabel.text = String(photos[idx].likes) + " likes"
            alreadyLiked = true
        }
        
    }
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        let photo = photos[idx]
        usernameLabel.text = "By " + photo.username
        dateLabel.text = "Posted " + photo.date
        likesLabel.text = String(photo.likes) + " likes"
        
        let url = NSURL(string: photo.url)
        
        getDataFromUrl(url!) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                self.photoImage.image = UIImage(data: data)
            }
        }
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
}
