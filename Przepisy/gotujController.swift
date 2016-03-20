//
//  gotujController.swift
//  Przepisy
//
//  Created by Maciej Matuszewski on 19.03.2016.
//  Copyright © 2016 Dominika Czarnecka. All rights reserved.
//

import UIKit

class gotujController: UIViewController {

    var pagecount: Int!
    var kroki: [krokPrzepisu]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var counter:Int = 0
//
//        let progress = UIProgressView.init()
//        let fractionalProgress = Float(counter) / 100.0
//        let animated = counter != 0
//        progress.setProgress(fractionalProgress, animated: animated)
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
        
        pagecount = kroki.count + 1
        view.backgroundColor = UIColor.whiteColor()
        
        let scrollView = UIScrollView.init()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scroll]|", options: [], metrics: nil, views: ["scroll":scrollView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scroll]|", options: [], metrics: nil, views: ["scroll":scrollView]))
        
        
        let v = UIView.init(frame: CGRect.init(x: 180, y: 60, width: 350, height: 80))
        v.backgroundColor = UIColor.redColor()
        scrollView.addSubview(v)
        scrollView.scrollEnabled = true
        scrollView.contentSize = CGSize.init(width: view.frame.width * CGFloat(pagecount), height: 0)
        scrollView.pagingEnabled = true
        
        for i in (0 ..< pagecount){
            generateView(i)
        }
        
    }

    func generateView(pageNumber: Int) -> UIView{
        let v = UIView.init(frame: CGRect.init(x: view.frame.width * CGFloat(pageNumber), y: 0, width: view.frame.width, height: view.frame.height))
      
        
        return v
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
