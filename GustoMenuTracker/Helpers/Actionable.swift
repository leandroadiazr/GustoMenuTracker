//
//  Actionable.swift
//  GustoMenuTracker
//
//  Created by Leandro Diaz on 12/19/21.
//

import UIKit

protocol Actionable: AnyObject {
    associatedtype ActionType
    associatedtype Delegate
    func notify(_ action: ActionType)
}

extension Actionable {

    func notify(_ action: ActionType) -> () -> Void {
        return { [weak self] in
            self?.notify(action)
        }
    }
}
