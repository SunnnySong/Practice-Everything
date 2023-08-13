//
//  ViewController.swift
//  Combine+UIKit_practice
//
//  Created by Sunny on 2023/07/03.
//

import UIKit
import Combine

extension Notification.Name {
    static let newBlogPost = Notification.Name("newPost")
}

struct BlogPost {
    let title: String
}

class ViewController: UIViewController {

    @IBOutlet weak var blogTextField: UITextField!
    @IBOutlet weak var publishButton: UIButton!
    @IBOutlet weak var subscribedLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        publishButton.addTarget(self, action: #selector(publishButtonTapped), for: .primaryActionTriggered)
        
        // create a publisher
        let publisher = NotificationCenter.Publisher(center: .default, name: .newBlogPost, object: nil)
            .map { (notification) -> String? in
                return (notification.object as? BlogPost)?.title ?? ""
            }
        
        // create a subscriber
        let subscriber = Subscribers.Assign(object: subscribedLabel, keyPath: \.text)
        publisher.subscribe(subscriber)
    }
    
    @objc func publishButtonTapped() {
        
        // post the notification
        let title = blogTextField.text ?? "Coming soon"
        let blogPost = BlogPost(title: title)
        NotificationCenter.default.post(name: .newBlogPost, object: blogPost) 
    }


}




