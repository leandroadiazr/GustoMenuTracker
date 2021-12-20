//
//  PersistenceManager.swift
//  GustoMenuTracker
//
//  Created by Leandro Diaz on 12/19/21.
//

import Foundation

enum ErrorMessage: String, Error {
    case unableToDecode = "unableToDecode"
    case alreadyExist = "Item is already in the cart"
}

enum PersistenceHandler {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let menuItems = "menuItems"
    }
    
    static func updateWith(menuItem: Menu, actionType: PersistenceHandler, completed: @escaping (ErrorMessage?) -> Void){
        retreiveItems { result in
            
            switch result {
            case .success(let items):
                var retreivedItems = items
                
                switch actionType {
                case .add:
                    guard !retreivedItems.contains(menuItem) else {
                        completed(.alreadyExist)
                        return
                    }
                    retreivedItems.append(menuItem)
                case .remove:
                    retreivedItems.removeAll { $0.id == menuItem.id }
                }
                
                completed(addToCart(items: retreivedItems))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retreiveItems(completed: @escaping (Result<[Menu], ErrorMessage>) -> Void) {
        guard let itemsData = defaults.object(forKey: Keys.menuItems) as? Data else {
            completed(.success([]))
            return
        }
        do{
            let decoder = JSONDecoder()
            let items = try decoder.decode([Menu].self, from: itemsData)
            completed(.success(items))
        } catch {
            completed(.failure(.unableToDecode))
        }
    }
    
    static func addToCart(items:  [Menu]) -> ErrorMessage? {
        do{
            let encoder = JSONEncoder()
            let encodedItems = try encoder.encode(items)
            defaults.set(encodedItems, forKey: Keys.menuItems)
            return nil
        } catch {
            return .unableToDecode
        }
    }
    
}
