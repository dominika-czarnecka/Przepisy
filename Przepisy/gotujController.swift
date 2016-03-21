//
//  gotujController.swift
//  Przepisy
//
//  Created by Maciej Matuszewski on 19.03.2016.
//  Copyright © 2016 Dominika Czarnecka. All rights reserved.
//

import UIKit

class gotujController: UIViewController, UIScrollViewDelegate {

    var pagecount: Int!
    var kroki: [krokPrzepisu]!
    let scrollView = UIScrollView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagecount = kroki.count //+ 1
        view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Anuluj", style: .Plain, target: self, action: "dismissVC")
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        
        view.addSubview(scrollView)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scroll]|", options: [], metrics: nil, views: ["scroll":scrollView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scroll]|", options: [], metrics: nil, views: ["scroll":scrollView]))
        
        scrollView.scrollEnabled = true
        scrollView.contentSize = CGSize.init(width: view.frame.width * CGFloat(pagecount), height: 0)
        scrollView.pagingEnabled = true
        
        for i in (0 ..< pagecount){
            scrollView.addSubview(generateView(i))
        }
        
    }

    func generateView(pageNumber: Int) -> UIView{
        let v = UIView.init(frame: CGRect.init(x: view.bounds.width * CGFloat(pageNumber), y: 0, width: view.bounds.width, height: view.frame.height - 20 - (self.navigationController?.navigationBar.frame.height)!))

        let vimg = UIImageView.init(image: UIImage.init(named: kroki[pageNumber].obraz))
        let timel = UILabel.init()
        timel.tag = pageNumber
        timel.backgroundColor = UIColor(red:0.97, green:0.97, blue:1, alpha:1)
        timel.text = String(format: "%02d:%02d", arguments: [Int(kroki[pageNumber].czas / 60), Int(kroki[pageNumber].czas % 60)])
        timel.textAlignment = .Center
        timel.font = UIFont.boldSystemFontOfSize(50)
        let tap = UITapGestureRecognizer.init(target: self, action: "tapped:")
        timel.userInteractionEnabled = true
        timel.addGestureRecognizer(tap)
        
        
        let vdes = UITextView.init()
        vdes.editable = false
        vdes.text = kroki[pageNumber].opis
        vdes.font = UIFont.systemFontOfSize(18)
        vdes.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(vdes)
        
        if kroki[pageNumber].obraz != ""{
            vimg.translatesAutoresizingMaskIntoConstraints = false
            v.addSubview(vimg)
        }
        if kroki[pageNumber].czas != 0{
            timel.translatesAutoresizingMaskIntoConstraints = false
            v.addSubview(timel)
        }
        if kroki[pageNumber].obraz != "" && kroki[pageNumber].czas != 0{
            v.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[image][desc][time(==90)]|", options: [], metrics: nil, views: ["image":vimg, "desc":vdes, "time":timel]))
            v.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[image]|", options: [], metrics: nil, views: ["image":vimg]))
            v.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[desc]-|", options: [], metrics: nil, views: ["desc":vdes]))
            v.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[time]|", options: [], metrics: nil, views: ["time":timel]))
        }
        if kroki[pageNumber].obraz == "" && kroki[pageNumber].czas != 0{
            v.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[desc][time(==90)]|", options: [], metrics: nil, views: ["time":timel, "desc":vdes]))
            v.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[desc]-|", options: [], metrics: nil, views: ["desc":vdes]))
            v.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[time]|", options: [], metrics: nil, views: ["time":timel]))
        }
        if kroki[pageNumber].obraz != "" && kroki[pageNumber].czas == 0{
            v.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[image][desc]|", options: [], metrics: nil, views: ["image":vimg, "desc":vdes]))
            v.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[image]|", options: [], metrics: nil, views: ["image":vimg]))
            v.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[desc]-|", options: [], metrics: nil, views: ["desc":vdes]))
        }
        if kroki[pageNumber].obraz == "" && kroki[pageNumber].czas == 0{
            v.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[desc]|", options: [], metrics: nil, views: ["desc":vdes]))
            v.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[desc]-|", options: [], metrics: nil, views: ["desc":vdes]))
        }
        
        return v
    }
    
    func dismissVC(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.navigationItem.title = kroki[Int(scrollView.contentOffset.x / view.frame.width)].tytul
    }
    
    func tapped(sender: UITapGestureRecognizer){
        let timel = sender.view as! UILabel
        performSelector("countdown:", withObject: timel, afterDelay: 1.0)
    }
    
    func countdown(timel: UILabel){
        kroki[timel.tag].czas = kroki[timel.tag].czas - 1
        timel.text = String(format: "%02d:%02d", arguments: [Int(kroki[timel.tag].czas / 60), Int(kroki[timel.tag].czas % 60)])
        if(kroki[timel.tag].czas > 0){
            performSelector("countdown:", withObject: timel, afterDelay: 1.0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

