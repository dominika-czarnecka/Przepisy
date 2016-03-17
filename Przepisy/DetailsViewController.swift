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
    var clik: Bool = false
    
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
        if clik == false {
            cell!.imageView?.image = UIImage.init(named: "circle.png")
        }else{
            cell!.imageView?.image = UIImage.init(named: "circle-2.png")
        }
        clik = !clik
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return danie.danieSprzet.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier("identyfikator", forIndexPath: indexPath)
        cell.textLabel?.text = danie.danieSprzet[indexPath.row]
        cell.imageView?.image = UIImage.init(named: "circle-2.png")
        return cell
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
