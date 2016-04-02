//
//  Danie.swift
//  Przepisy
//
//  Created by Dominika Czarnecka on 13.03.2016.
//  Copyright © 2016 Dominika Czarnecka. All rights reserved.
//

import UIKit

class Danie: NSObject {

    var danieID: String!
    var danieImg: String!
    var danieOpis:String!
    var danieTytul: String!
    var danieSklad: [String]!
    var danieSprzet: [String]!
    var daniePrzepis: [krokPrzepisu]!
    
    init(img: String, opis: String, tytul: String, sklad: [String], sprzet: [String], przepis: [krokPrzepisu]){
        super.init()
        
        danieID = String(rand())
        danieImg = img
        danieOpis = opis
        danieTytul = tytul
        danieSklad = sklad
        danieSprzet = sprzet
        daniePrzepis = przepis
    }
}

class krokPrzepisu: NSObject {
    var tytul: String!
    var obraz: String!
    var czas: Int!
    var currentTime = 0
    var countingdown = false
    var opis: String!
    
    init(tytul: String, obraz: String, czas: Int, opis: String){
        super.init()
        self.tytul = tytul
        self.obraz = obraz
        self.czas = czas
        self.opis = opis
    }
}
