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
        
        pagecount = kroki.count //+ 1
        view.backgroundColor = UIColor.whiteColor()
        
        let scrollView = UIScrollView.init()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scroll]|", options: [], metrics: nil, views: ["scroll":scrollView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scroll]|", options: [], metrics: nil, views: ["scroll":scrollView]))
        
        
//        let v = UIView.init(frame: CGRect.init(x: 180, y: 60, width: 350, height: 80))
//        v.backgroundColor = UIColor.redColor()
//        scrollView.addSubview(v)
        scrollView.scrollEnabled = true
        scrollView.contentSize = CGSize.init(width: view.frame.width * CGFloat(pagecount), height: 0)
        scrollView.pagingEnabled = true
        
        for i in (0 ..< pagecount){
            
            scrollView.addSubview(generateView(i))
        }
        
    }

    func generateView(pageNumber: Int) -> UIView{
        let v = UIView.init(frame: CGRect.init(x: view.bounds.width * CGFloat(pageNumber), y: 0, width: view.bounds.width, height: view.bounds.height))
        self.navigationItem.title = kroki[pageNumber].tytul
        if kroki[pageNumber].czas == 0{
                let vimg = UIImageView.init(image: UIImage.init(named: kroki[pageNumber].obraz))
                let vdes = UILabel.init()
                vdes.lineBreakMode = .ByWordWrapping
                vdes.numberOfLines = 0
                vdes.text = kroki[pageNumber].opis
                v.addSubview(vimg)
                v.addSubview(vdes)
                v.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[image][desc]|", options: [], metrics: nil, views: ["image":vimg, "desc":vdes]))
                v.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[image]|", options: [], metrics: nil, views: ["image":vimg]))
                v.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[desc]|", options: [], metrics: nil, views: ["desc":vdes]))
            
        }
        
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
