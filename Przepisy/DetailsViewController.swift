//
//  DetailsViewController.swift
//  Przepisy
//
//  Created by Dominika Czarnecka on 13.03.2016.
//  Copyright © 2016 Dominika Czarnecka. All rights reserved.
//

import UIKit
import SDWebImage
import EventKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let eventStore = EKEventStore()
    var reminders: [EKReminder]?
    var skladnikiDict: NSMutableDictionary!
    var danieID2: Int!
    let tableView1 = UITableView.init()
    var danie: Danie!
    let gotuj = UIButton.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        defaults.removeObjectForKey(danie.danieID)
        
        if (defaults.objectForKey((danie?.danieID)!) != nil){
            skladnikiDict = (defaults.objectForKey(danie.danieID) as! NSDictionary).mutableCopy() as! NSMutableDictionary
        }else{
            skladnikiDict = filldict()
            saveDict()
            
        }
        
        view.backgroundColor = UIColor.whiteColor()
        
        self.navigationItem.title = danie.danieTytul!
        
        
        gotuj.translatesAutoresizingMaskIntoConstraints = false
        gotuj.setTitle("GOTUJ", forState: .Normal)
        gotuj.titleLabel?.font = UIFont.boldSystemFontOfSize(30)
        gotuj.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        gotuj.setTitleColor(UIColor.darkTextColor(), forState: .Highlighted)
        gotuj.backgroundColor = kColorMain
        gotuj.addTarget(self, action: #selector(DetailsViewController.buttonAction), forControlEvents: .TouchUpInside)
        
        tableView1.translatesAutoresizingMaskIntoConstraints = false
        tableView1.registerClass(UITableViewCell.self, forCellReuseIdentifier: "identyfikator")
        tableView1.registerClass(UITableViewCell.self, forCellReuseIdentifier: "opis")
        tableView1.delegate = self
        tableView1.dataSource = self
        
        tableView1.registerNib(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
        
        view.addSubview(gotuj)
        view.addSubview(tableView1)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(space)-[table1][gotuj(==60)]|", options: [], metrics: ["space":(self.navigationController?.navigationBar.frame.height)! + 20], views: ["table1":tableView1, "gotuj":gotuj]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[table1]|", options: [], metrics: nil, views: ["table1":tableView1]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[gotuj]|", options: [], metrics: nil, views: ["gotuj":gotuj]))
        
        tableView1.estimatedRowHeight = 44.0
        tableView1.rowHeight = UITableViewAutomaticDimension
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView1.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.section == 1){
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            
            if ((skladnikiDict.objectForKey(danie.danieSklad[indexPath.row].nazwa) as! NSNumber).boolValue == false){
                skladnikiDict.setObject(true, forKey: danie.danieSklad[indexPath.row].nazwa)
                cell!.imageView?.image = UIImage.init(named: "circle.png")
            }
            else{
                skladnikiDict.setObject(false, forKey: danie.danieSklad[indexPath.row].nazwa)
                cell!.imageView?.image = UIImage.init(named: "circle-2.png")
            }
        }
        if(indexPath.section == 2){
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if (skladnikiDict.objectForKey(danie.danieSprzet[indexPath.row]) as! Bool == false){
                skladnikiDict.setObject(true, forKey: danie.danieSprzet[indexPath.row])
                //defaults.setBool(true, forKey: danie.danieSprzet[indexPath.row])
                cell!.imageView?.image = UIImage.init(named: "circle.png")
            }else{
                skladnikiDict.setObject(false, forKey: danie.danieSprzet[indexPath.row])
                cell!.imageView?.image = UIImage.init(named: "circle-2.png")
            }
        }
        saveDict()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 2:
            return "Sprzet"
        case 1:
            return "Sklad"
        default:
            return nil
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 2:
            return danie.danieSprzet.count
        case 1:
            return danie.danieSklad.count
        case 0:
            return 2
        default:
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCellWithIdentifier("ImageTableViewCell", forIndexPath: indexPath) as? ImageTableViewCell
                cell?.imageV.sd_setImageWithURL(NSURL.init(string: danie.danieImg))
                cell!.selectionStyle = .None
               // cell?.imageV.image = UIImage®.init(named: danie.danieImg!)
                return cell!
            }
            if indexPath.row == 1{
                let cell = tableView.dequeueReusableCellWithIdentifier("opis", forIndexPath: indexPath)
                cell.textLabel?.lineBreakMode = .ByWordWrapping
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = danie.danieOpis
                cell.selectionStyle = .None
                return cell
            }
        }
        
       let cell = tableView.dequeueReusableCellWithIdentifier("identyfikator", forIndexPath: indexPath)
        if(skladnikiDict) != nil{
            if indexPath.section == 2{
                cell.textLabel?.text = danie.danieSprzet[indexPath.row]
                
                if((skladnikiDict.objectForKey(danie.danieSprzet[indexPath.row]) as! NSNumber).boolValue == true){
                    cell.imageView?.image = UIImage.init(named: "circle.png")
                }else{
                    cell.imageView?.image = UIImage.init(named: "circle-2.png")
                }
            }else{
                cell.textLabel?.text = danie.danieSklad[indexPath.row].nazwa
                if (skladnikiDict.objectForKey(danie.danieSklad[indexPath.row].nazwa) as! Bool == true) {
                    cell.imageView?.image = UIImage.init(named: "circle.png")
                }else{
                    cell.imageView?.image = UIImage.init(named: "circle-2.png")
                }
            }
        }else{
            cell.imageView?.image = UIImage.init(named: "circle-2.png")
            
        }
        saveDict()
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            if indexPath.row == 0{
                return 240
            }else{
                return UITableViewAutomaticDimension
            }
        }
        return 44
    }
    
    func buttonAction(){
        let vc = gotujController()
        let nc = UINavigationController.init(rootViewController: vc)
        vc.kroki = danie.daniePrzepis
        self.presentViewController(nc, animated: true) { () -> Void in
            
        }
    }
    
    func filldict() -> NSMutableDictionary{
        let mDict:NSMutableDictionary = NSMutableDictionary()
        for i in (0 ..< danie.danieSklad.count){
            mDict.setObject(false, forKey: danie.danieSklad[i].nazwa)
        }
        for i in (0 ..< danie.danieSprzet.count){
            mDict.setObject(false, forKey: danie.danieSprzet[i])
        }
        return mDict
    }
    
    func saveDict(){
        defaults.setObject(NSDictionary.init(dictionary: skladnikiDict), forKey: danie.danieID)
        defaults.synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    override func viewWillAppear(animated: Bool) {
//        checkRemindersAuthorizationStatus()
//    }
//    
//    func checkRemindersAuthorizationStatus() {
//        let status = EKEventStore.authorizationStatusForEntityType(EKEntityType.Event)
//        
//        switch (status) {
//        case EKAuthorizationStatus.NotDetermined:
//            requestAccessToReminders()
//        case EKAuthorizationStatus.Authorized:
//            loadReminders()
//            refreshTableView()
//        case EKAuthorizationStatus.Restricted, EKAuthorizationStatus.Denied:
//            requestAccessToReminders()
//        }
//    }
//    
//    func requestAccessToReminders() {
//        eventStore.requestAccessToEntityType(EKEntityType.Event, completion: {
//            (accessGranted: Bool, error: NSError?) in
//            
//            if accessGranted == true {
//                dispatch_async(dispatch_get_main_queue(), {
//                    self.loadReminders()
//                    self.refreshTableView()
//                })
//            } else {
//                dispatch_async(dispatch_get_main_queue(), {
//                    self.requestAccessToReminders()
//                })
//            }
//        })
//    }
//    
//    func loadReminders() {
//        self.reminders = eventStore.calendarsForEntityType(EKEntityType.Event)
//    }
//    
//    func refreshTableView() {
//       remindersTableView.hidden = false
//        calendarsTableView.reloadData()
//    }

    
}
