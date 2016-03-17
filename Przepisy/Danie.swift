//
//  Danie.swift
//  Przepisy
//
//  Created by Dominika Czarnecka on 13.03.2016.
//  Copyright © 2016 Dominika Czarnecka. All rights reserved.
//

import UIKit

class Danie: NSObject {

    var danieImg: String!
    var danieOpis:String!
    var danieTytul: String!
    var danieSklad: [String]!
    var danieSprzet: [String]!
    
    init(img: String, opis: String, tytul: String, sklad: [String], sprzet: [String]){
        super.init()
        danieImg = img
        danieOpis = opis
        danieTytul = tytul
        danieSklad = sklad
        danieSprzet = sprzet
    }
    
   /* func sprzet(array: [String]) -> [String]{
        for i in array{
            danieSprzet.append(i)
        }
        return danieSprzet
    }
    
    func sklad(array: [String]) -> [String]{
        for i in array{
            danieSklad.append(i)
        }
        return danieSklad
    }
*/
}
