//
//  CatBreedsViewModel.swift
//  CatFacts
//
//  Created by Krystian Bujak on 07/05/2019.
//  Copyright © 2019 SwingDev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CatBreedsViewModel {
    var breedsCellsModels: BehaviorRelay<[CatBreedDetailsViewModel]> { get }
    var isInProgress: BehaviorRelay<Bool> { get }
    var errorMessage: BehaviorRelay<String?> { get }
    var triggerCell: PublishSubject<CatBreedDetailsViewModel> { get }

    func setup()
}
