//
//  Menu.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/19/21.
//

import Foundation

struct Menu: Codable, Hashable {
    var id: Int
    var itemTitle: String
    var itemDescription: String
    var itemImage: String
    var day: WeeklyMenu?
}

enum WeeklyMenu: String, Codable, Hashable {
    case specials = "Specials"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
}


let specialMenu = [Menu(id: 0, itemTitle: "Sushi", itemDescription: "Chef's choice 10 pieces sushi, 15 piece sashimi, 1 spicy tuna rollm 1 rainbow roll, 1 sweet heart roll.", itemImage: "Sushi", day: .monday),
                   Menu(id: 1, itemTitle: "Salmon", itemDescription: "Easy baked and grilled salmon recipes. See tasty seasoning and marinade ideas for salmon fillets, with tips and reviews from home cooks.", itemImage: "salmon", day: .tuesday),
                   Menu(id: 2, itemTitle: "Tacos de Jamaica", itemDescription: "These delicious Mexican vegan tacos (tacos de jamaica) are made with hibiscus flowers and are garnished with pineapple, onion, cilantro, and salsa verde with avocado", itemImage: "tacos", day: .wednesday)
]


let weekOneMenu = [
    Menu(id: 3, itemTitle: "Chicken & Waffle", itemDescription: " Garlic, herbs and lemon—plus a glug of white wine—mean that these juicy, tender chicken breasts are as delicious as they are healthy.", itemImage: "chicken", day: .specials),
    Menu(id: 4, itemTitle: "Tacos", itemDescription: "These classic Ground Beef Tacos feature homemade taco meat loaded into freshly fried taco shells. Serve up with all your favorite toppings for an easy family meal that takes less than 30 minutes!.", itemImage: "tacos", day: .monday),
    
    Menu(id: 5, itemTitle: "Curry", itemDescription: "Traditional Jamaican curry is made with scotch bonnet peppers and Jamaican curry powder, neither of which I have easy access to here in Milwaukee.", itemImage: "curry", day: .tuesday),
    
    Menu(id: 6, itemTitle: "Pizza", itemDescription: "Wherever it started, English Muffin Pizza satisfies the need for easy, snackable, kid-friendly, gratifyingly cheesy goodness!", itemImage: "pizza", day: .wednesday),
    
    Menu(id: 7, itemTitle: "Sushi", itemDescription: "Chef's choice 10 pieces sushi, 15 piece sashimi, 1 spicy tuna rollm 1 rainbow roll, 1 sweet heart roll.", itemImage: "Sushi", day: .thursday),
    
    Menu(id: 8, itemTitle: "Tacos de Jamaica", itemDescription: "These delicious Mexican vegan tacos (tacos de jamaica) are made with hibiscus flowers and are garnished with pineapple, onion, cilantro, and salsa verde with avocado", itemImage: "tacos", day: .friday)
]

let weekTwoMenu = [
    Menu(id: 9, itemTitle: "Breakfast for Lunch", itemDescription: "I plan to serve my family these golden, glorious zucchini waffles every weekend, then rub my palms together in secret, subtly evil glee as our toddlers wolf them down, then beg for more..", itemImage: "Waffles", day: .monday),
    
    Menu(id: 10, itemTitle: "Burgers", itemDescription: "Made with a 50/50 blend of zesty Italian turkey sausage and lean ground turkey, smothered in mozzarella, asiago, and grilled peppers, these Italian Turkey Burgers are sure to be a hit at your next backyard festa.", itemImage: "burgers", day: .tuesday),
    Menu(id: 11, itemTitle: "Pasta", itemDescription: "This healthy Mediterranean Pasta is the breezy social butterfly of the dinner recipe crowd. So effortless! So chic! A light, easygoing mix of angel hair pasta, fresh lemon, and classic Mediterranean ingredients like tomato, Parmesan, and artichoke, this simple but splendid healthy pasta recipe can carry itself at any meal. Whether it’s a hectic family weeknight meal or romantic date night in, this Mediterranean pasta belongs.", itemImage: "sushi", day: .wednesday),
    Menu(id: 12, itemTitle: "Salmon", itemDescription: "If you are new to the salmon game, start with this million-dollar Baked Salmon in Foil (and take a moment to read this pro guide to cooking healthy salmon recipes). Even if you don’t make those recipes right away, they have some great tips.", itemImage: "salmon", day: .thursday),
    Menu(id: 13, itemTitle: "Sandwiches", itemDescription: "If you are new to the salmon game, start with this million-dollar Baked Salmon in Foil (and take a moment to read this pro guide to cooking healthy salmon recipes). Even if you don’t make those recipes right away, they have some great tips.", itemImage: "sandwich", day: .friday)
]
