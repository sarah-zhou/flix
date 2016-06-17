//
//  DetailViewController.swift
//  Flix
//
//  Created by Sarah Zhou on 6/16/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
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
        
        let percent = movie["popularity"] as? Double
        
        let overview = movie["overview"] as? String
        
        titleLabel.text = title
        dateLabel.text = date!
        percentLabel.text = String(format: "%.0f", percent!) + "%"
        overviewLabel.text = overview
        overviewLabel.sizeToFit()
        
        let baseURL = "http://image.tmdb.org/t/p/w500"
        
        if let poster = movie["poster_path"] as? String {
            let posterURL = NSURL(string: baseURL + poster)
            posterImageView.setImageWithURL(posterURL!)
        }
        
        // Do any additional setup after loading the view.
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
