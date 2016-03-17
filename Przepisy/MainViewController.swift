//
//  MainViewController.swift
//  Przepisy
//
//  Created by Dominika Czarnecka on 11.03.2016.
//  Copyright © 2016 Dominika Czarnecka. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView.init()
    var data:NSArray! // = ["jajecznica", "pizza", "chleb", "chamburger"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = [Danie.init(img: "jajecznica.jpg", opis: "I'm looking for behavior similar to Objective-C's +(void)initialize class method, in that the method is called once when the class is initialized, and never again thereafter.\nA simple class init () {} in a class closure would be really sleek! And obviously when we get to use class vars instead of static vars in a struct closure, this will all match really well!I'm looking for behavior similar to Objective-C's +(void)initialize class method, in that the method is called once when the class is initialized, and never again thereafter.\nA simple class init () {} in a class closure would be really sleek! And obviously when we get to use class vars instead of static vars in a struct closure, this will all match really well!I'm looking for behavior similar to Objective-C's +(void)initialize class method, in that the method is called once when the class is initialized, and never again thereafter.\nA simple class init () {} in a class closure would be really sleek! And obviously when we get to use class vars instead of static vars in a struct closure, this will all match really well!", tytul: "jajecznica", sklad: ["jajka", "mleko", "maslo"], sprzet: ["patelnia", "miska", "talerz"]), Danie.init(img: "pizza.jpg", opis: "PIZZA!!!", tytul: "pizza", sklad: ["ciasto", "ser", "sos"], sprzet:["blacha", "nóź"])]
        
        
        view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "Przepisy"
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "identyfikator")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[table]|", options: [], metrics: nil, views: ["table": tableView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[table]|", options: [], metrics: nil, views: ["table": tableView]))
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let dvc = DetailsViewController()
        dvc.danieID = indexPath.row
        dvc.danie = data.objectAtIndex(indexPath.row) as! Danie
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("identyfikator", forIndexPath: indexPath)
        cell.textLabel?.text = (data.objectAtIndex(indexPath.row) as? Danie)?.danieTytul
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
