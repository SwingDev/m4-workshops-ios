//
//  Coordinator.swift
//  CatFacts
//
//  Created by Krystian Bujak on 06/05/2019.
//  Copyright © 2019 SwingDev. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    func start()
}

protocol RootCoordinator: Coordinator {
    var rootController: UINavigationController? { get set }

    func pop(_ coordinator: ChildCoordinator)
}

protocol ChildCoordinator: Coordinator {
    var controller: UIViewController? { get set }
    var rootCoordinator: RootCoordinator? { get }
}
