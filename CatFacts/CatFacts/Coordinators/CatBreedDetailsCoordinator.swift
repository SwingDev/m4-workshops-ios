//
//  CatBreedDetailsCoordinator.swift
//  CatFacts
//
//  Created by Krystian Bujak on 08/05/2019.
//  Copyright © 2019 SwingDev. All rights reserved.
//

import Foundation
import UIKit

protocol CatBreedDetailsDelegate: AnyObject {
    func backButtonTapped()
}

class CatBreedDetailsCoordinator: ChildCoordinator {
    var controller: UIViewController?
    weak var rootCoordinator: RootCoordinator?

    private var context: AppContext
    private var breed: CatBreed

    init(context: AppContext, breed: CatBreed) {
        self.context = context
        self.breed = breed
    }

    func start() {
        let viewModel = CatBreedDetailsViewModelImpl(catBreed: breed)
        viewModel.delegate = self
        controller = CatBreedDetailsViewController(viewModel: viewModel)
    }
}

extension CatBreedDetailsCoordinator: CatBreedDetailsDelegate {
    func backButtonTapped() {
        rootCoordinator?.pop(self)
    }
}
