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
    let section = [1,2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        self.navigationItem.title = danie.danieTytul!
        
        tableView1.translatesAutoresizingMaskIntoConstraints = false
        tableView1.registerClass(UITableViewCell.self, forCellReuseIdentifier: "identyfikator")
        tableView1.delegate = self
        tableView1.dataSource = self
        
        let obrazek = UIImageView.init()
        obrazek.image = UIImage.init(named: danie.danieImg!)
        obrazek.translatesAutoresizingMaskIntoConstraints = false
    
        let opis = UITextView.init()
        opis.text = danie.danieOpis!
        opis.font = UIFont.systemFontOfSize(20)
        opis.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView1)
        view.addSubview(obrazek)
        view.addSubview(opis)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[obr(==300)][table1][opis]|", options: [], metrics: nil, views: ["obr":obrazek, "opis":opis, "table1":tableView1]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[obr]|", options: [], metrics: nil, views: ["obr":obrazek]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[table1]|", options: [], metrics: nil, views: ["table1":tableView1]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[opis]|", options: [], metrics: nil, views: ["opis":opis]))
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
        return self.section.count
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1{
            return "Sprzet"
        }else{
            return "Sklad"
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
        return danie.danieSprzet.count
        }else{
         return danie.danieSklad.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier("identyfikator", forIndexPath: indexPath)
        //if UITableView.section == 1{
            cell.textLabel?.text = danie.danieSprzet[indexPath.row]
        /*}else{
            cell.textLabel?.text = danie.danieSklad[indexPath.row]
        }
*/
        cell.imageView?.image = UIImage.init(named: "circle-2.png")
        return cell
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
