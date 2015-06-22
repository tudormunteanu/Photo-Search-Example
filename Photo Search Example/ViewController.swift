//
//  ViewController.swift
//  Photo Search Example
//
//  Created by Shaun Chua on 21/6/15.
//  Copyright (c) 2015 Shaun Chua. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let manager = AFHTTPRequestOperationManager()
        
        manager.GET( "https://api.instagram.com/v1/tags/clararockmore/media/recent?client_id=af21bd0936304303b7c7f37879c4e0ca",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                println("JSON: " + responseObject.description)
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
        
        if let dataArray = responseObject["data"] as? [AnyObject] {
            var urlArray:[String] = []                  //1
            for dataObject in dataArray {               //2
                if let imageURLString = dataObject.valueForKeyPath("images.standard_resolution.url") as? String { //3
                    urlArray.append(imageURLString)     //4
                }
            }
            self.scrollView.contentSize = CGSizeMake(320, 320 * CGFloat(dataArray.count))
            for var i = 0; i < urlArray.count; i++ {
                let imageData = NSData(contentsOfURL: NSURL(string: urlArray[i])!)         //1
                if let imageDataUnwrapped = imageData {                                     //2
                    let imageView = UIImageView(image: UIImage(data: imageDataUnwrapped))   //3
                    imageView.frame = CGRectMake(0, 320 * CGFloat(i), 320, 320)               //4
                    self.scrollView.addSubview(imageView)                                        //5
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

