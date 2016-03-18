//
//  DetailsViewController.swift
//  Przepisy
//
//  Created by Dominika Czarnecka on 13.03.2016.
//  Copyright © 2016 Dominika Czarnecka. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var danieID: Int!
    let tableView1 = UITableView.init()
    var danie: Danie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        self.navigationItem.title = danie.danieTytul!
        
        tableView1.translatesAutoresizingMaskIntoConstraints = false
        tableView1.registerClass(UITableViewCell.self, forCellReuseIdentifier: "identyfikator")
        tableView1.registerClass(UITableViewCell.self, forCellReuseIdentifier: "opis")
        tableView1.delegate = self
        tableView1.dataSource = self
        
        tableView1.registerNib(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
        
//        let obrazek = UIImageView.init()
//        obrazek.image = UIImage.init(named: danie.danieImg!)
//        obrazek.translatesAutoresizingMaskIntoConstraints = false
//    
//        let opis = UITextView.init()
//        opis.text = danie.danieOpis!
//        opis.font = UIFont.systemFontOfSize(20)
//        opis.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView1)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[table1]|", options: [], metrics: nil, views: ["table1":tableView1]))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[table1]|", options: [], metrics: nil, views: ["table1":tableView1]))
        
        tableView1.estimatedRowHeight = 44.0
        tableView1.rowHeight = UITableViewAutomaticDimension
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView1.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if (cell!.imageView?.image == UIImage.init(named: "circle-2.png")) {
            cell!.imageView?.image = UIImage.init(named: "circle.png")
        }else{
            cell!.imageView?.image = UIImage.init(named: "circle-2.png")
        }
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
                
                cell?.awakeFromNib()
                cell?.imageV.image = UIImage.init(named: danie.danieImg!)
                return cell!
            }
            if indexPath.row == 1{
                let cell = tableView.dequeueReusableCellWithIdentifier("opis", forIndexPath: indexPath)
                cell.textLabel?.lineBreakMode = .ByWordWrapping
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = danie.danieOpis
                return cell
            }
        }
        
       let cell = tableView.dequeueReusableCellWithIdentifier("identyfikator", forIndexPath: indexPath)
        if indexPath.section == 1{
            cell.textLabel?.text = danie.danieSprzet[indexPath.row]
        }else{
            cell.textLabel?.text = danie.danieSklad[indexPath.row]
        }

        cell.imageView?.image = UIImage.init(named: "circle-2.png")
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
