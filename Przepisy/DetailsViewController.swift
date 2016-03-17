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
    var data: NSArray!
    let tableView1 = UITableView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = (data.objectAtIndex(danieID) as? Danie)?.danieTytul!
        
        tableView1.translatesAutoresizingMaskIntoConstraints = false
        tableView1.registerClass(UITableViewCell.self, forCellReuseIdentifier: "identyfikator")
        tableView1.delegate = self
        tableView1.dataSource = self
        
        let obrazek = UIImageView.init()
        obrazek.image = UIImage.init(named: ((data.objectAtIndex(danieID) as? Danie)?.danieImg)!)
        obrazek.translatesAutoresizingMaskIntoConstraints = false
    
        let opis = UITextView.init()
        opis.text = (data.objectAtIndex(danieID) as? Danie)?.danieOpis!
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
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let dvc = DetailsViewController()
        dvc.danieID = indexPath.row
        dvc.data = data
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((data.objectAtIndex(danieID) as? Danie)?.danieSprzet.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("identyfikator", forIndexPath: indexPath)
        cell.textLabel?.text = (data.objectAtIndex(indexPath.row) as? Danie)?.danieSprzet[indexPath.row]
        return cell
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableViewCell(tableViewCell: UITableViewCell, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
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
