//
//  DetailViewController.swift
//  Flix
//
//  Created by Sarah Zhou on 6/16/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit
import AFNetworking

class DetailViewController: UIViewController {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, infoView.frame.origin.y + infoView.frame.size.height)
        
        let title = movie["title"] as? String
        let date = movie["release_date"] as? String
        
        var percent = movie["vote_average"] as! Double
        percent = percent * 10
        
        let overview = movie["overview"] as? String
        
        titleLabel.text = title
        dateLabel.text = date!
        percentLabel.text = String(format: "%.0f", percent) + "%"
        overviewLabel.text = overview
        overviewLabel.sizeToFit()
        
        if let poster = movie["poster_path"] as? String {
            
            let smallImageUrl = "https://image.tmdb.org/t/p/w45" + poster
            let largeImageUrl = "https://image.tmdb.org/t/p/original" + poster
            
            let smallImageRequest = NSURLRequest(URL: NSURL(string: smallImageUrl)!)
            let largeImageRequest = NSURLRequest(URL: NSURL(string: largeImageUrl)!)
            
            self.posterView.setImageWithURLRequest(
                smallImageRequest,
                placeholderImage: nil,
                success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
                
                    // smallImageResponse will be nil if the smallImage is already available in cache
                    
                    self.posterView.alpha = 0.0
                    self.posterView.image = smallImage;
                    
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        
                        self.posterView.alpha = 1.0
                        
                        }, completion: { (success) -> Void in
                            
                            // The AFNetworking ImageView Category only allows one request to be sent at a time
                            // per ImageView. This code must be in the completion block.
                            self.posterView.setImageWithURLRequest(
                                largeImageRequest,
                                placeholderImage: smallImage,
                                success: { (largeImageRequest, largeImageResponse, largeImage) -> Void in
                                    
                                    self.posterView.image = largeImage;
                                    
                                },
                                failure: { (request, response, error) -> Void in
                            })
                    })
                },
                failure: { (request, response, error) -> Void in
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
