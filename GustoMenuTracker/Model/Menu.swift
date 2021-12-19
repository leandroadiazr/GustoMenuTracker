//
//  Menu.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/19/21.
//

import Foundation

struct Menu: Hashable {
    var id: Int
    var itemTitle: String
    var itemDescription: String
    var itemImage: String
    var day: WeeklyMenu
}

enum WeeklyMenu: String, Hashable {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
}


let specialMenu = [Menu(id: 0, itemTitle: "Sushi", itemDescription: "Chef's choice 10 pieces sushi, 15 piece sashimi, 1 spicy tuna rollm 1 rainbow roll, 1 sweet heart roll.", itemImage: "Sushi", day: .monday),
                   Menu(id: 1, itemTitle: "Salmon", itemDescription: "Easy baked and grilled salmon recipes. See tasty seasoning and marinade ideas for salmon fillets, with tips and reviews from home cooks.", itemImage: "Sushi", day: .tuesday),
                   Menu(id: 2, itemTitle: "Tacos de Jamaica", itemDescription: "These delicious Mexican vegan tacos (tacos de jamaica) are made with hibiscus flowers and are garnished with pineapple, onion, cilantro, and salsa verde with avocado", itemImage: "Sushi", day: .wednesday)
]
