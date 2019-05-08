//
//  CatBreedDetailsViewModel.swift
//  CatFacts
//
//  Created by Krystian Bujak on 07/05/2019.
//  Copyright © 2019 SwingDev. All rights reserved.
//

import Foundation
import RxSwift

protocol CatBreedDetailsViewModel {
    var catBreed: CatBreed { get }
    var backButtonTriggered: PublishSubject<Void> { get }

    func setup()
}
