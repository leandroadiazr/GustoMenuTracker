//
//  GlobalProtocols.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/18/21.
//

import Foundation
public typealias VoidClosure = () -> Void

protocol SelfConfiguringCell {
    static var reuseID: String { get }
    func configure(with menu: Menu)
}
