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
    let imageView = UIImageView.init()
    var data:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = [
            Danie.init(
                img: "http://www.festiwalbiegowy.pl/sites/default/files/main/articles/jajecznica.jpg",
                opis: "Jajecznica to jedno z najpopularniejszych dań śniadaniowych. Ja osobiście jem ją przynajmniej raz w tygodniu. Jedni lubią przygotować ją z samych jajek, inni z cebulką i boczkiem. Myślicie pewnie, że każde dziecko potrafi zrobić jajecznicę, ale czy potrafi przyrządzić jajecznicę idealną?",
                tytul: "Jajecznica",
                sklad: [
                    skladnik.init(nazwa: "jajka", ilosc: 4, typ: typp.sztuki),
                    skladnik.init(nazwa: "mleko", ilosc: 15, typ: typp.ml),
                    skladnik.init(nazwa: "masło", ilosc: 40, typ: typp.g),
                    skladnik.init(nazwa: "sól ", ilosc: 1, typ: .g),
                    skladnik.init(nazwa: "pieprz", ilosc: 1, typ: .g)],
                sprzet: ["patelnia", "miska", "talerz"],
                przepis:[
                    krokPrzepisu.init(tytul: "Krok 1", obraz: "http://www.obmawiamy.pl/wp-content/uploads/2009/04/541564763_cea1bd29eb-400x300.jpg", czas: 3, opis: "Nie przyprawiaj jajecznicy na początku, ale dopiero przed samym podaniem. Jeżeli dodasz sól na początku smażenia, jajecznica będzie bardziej wodnista i trudno będzie osiągnąć idealną konsystencję."),
                    krokPrzepisu.init(tytul: "Krok 2", obraz: "", czas: 3 * 60, opis: "Smażenie jajecznicy rozpocznij na zimnej patelni i na małym ogniu – nie idź na skróty.")]
            ),
            Danie.init(
                img: "http://www.mysticpizza.com/admin/resources/pizza-pepperoni-w857h456.jpg",
                opis: "Potrawa kuchni włoskiej, obecnie szeroko rozpowszechniona na całym świecie. W wersji podstawowej jest to płaski placek z wytrawnego ciasta makaronowego, znacznie później zaczęto także używać ciasta drożdżowego (focaccia), posmarowany sosem pomidorowym, posypany tartym serem mozzarella i ziołami, pieczony w bardzo mocno nagrzanym piecu. Pizzę podaje się na gorąco, lecz rozpowszechnione jest jedzenie jej również na zimno.",
                tytul: "Pizza",
                sklad: [
                    skladnik.init(nazwa: "ketchup", ilosc: 20, typ: .g),
                    skladnik.init(nazwa: "mleko", ilosc: 15, typ: typp.ml),
                    skladnik.init(nazwa: "masło", ilosc: 40, typ: typp.g),
                    skladnik.init(nazwa: "sól ", ilosc: 1, typ: .g),
                    skladnik.init(nazwa: "sos czosnkowy", ilosc: 20, typ: .g)],
                sprzet:["telefon", "numer do pizzerii"],
                przepis:[
                    krokPrzepisu.init(tytul: "Krok 1", obraz: "pizza.jpg", czas: 0, opis: "Wybierz na telefonie numer do pizzerii"),
                    krokPrzepisu.init(tytul: "Krok 2", obraz: "", czas: 0, opis: "Zamów wybraną pizzę"),
                    krokPrzepisu.init(tytul: "Krok 3", obraz: "", czas: 40 * 60, opis: "Czekaj")]
            )]
        
        view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "Przepisy"
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(imageView)
        view.addSubview(tableView)
      
        
        imageView.backgroundColor = UIColor.redColor()
        imageView.image = UIImage.init(named: "food.jpg")
        imageView.contentMode = .ScaleAspectFill
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "identyfikator")
        tableView.delegate = self
        tableView.dataSource = self
        
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[food]|", options: [], metrics: nil, views: ["food": imageView]))
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[food]|", options: [], metrics: nil, views: ["food": imageView]))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[table]|", options: [], metrics: nil, views: ["table": tableView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[table]|", options: [], metrics: nil, views: ["table": tableView]))
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let dvc = DetailsViewController()
        dvc.danieID2 = indexPath.row
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
    


}
