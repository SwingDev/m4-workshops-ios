//
//  CatBreedDetailsViewModelImpl.swift
//  CatFacts
//
//  Created by Krystian Bujak on 07/05/2019.
//  Copyright © 2019 SwingDev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CatBreedDetailsViewModelImpl: CatBreedDetailsViewModel {
    var backButtonTriggered = PublishSubject<Void>()
    var catBreed: CatBreed
    weak var delegate: CatBreedDetailsDelegate?

    private let bag = DisposeBag()

    init(catBreed: CatBreed) {
        self.catBreed = catBreed
    }

    func setup() {
        backButtonTriggered
            .asObservable()
            .throttle(2, scheduler: ConcurrentMainScheduler.instance)
            .asDriver(onErrorJustReturn: ())
            .drive(
                onNext: { [weak self] _ in
                    self?.delegate?.backButtonTapped()
                }
            )
            .disposed(by: bag)
    }
}
