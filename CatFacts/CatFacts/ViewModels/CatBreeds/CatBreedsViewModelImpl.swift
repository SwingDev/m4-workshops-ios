//
//  File.swift
//  CatFacts
//
//  Created by Krystian Bujak on 07/05/2019.
//  Copyright © 2019 SwingDev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CatBreedsViewModelImpl: CatBreedsViewModel {
    weak var delegate: AppCoordinatorDelegate?
    var context: AppContext
    var breedsCellsModels = BehaviorRelay<[CatBreedDetailsViewModel]>(value: [])
    var isInProgress = BehaviorRelay<Bool>(value: false)
    var errorMessage = BehaviorRelay<String?>(value: nil)
    var triggerCell = PublishSubject<CatBreedDetailsViewModel>()

    private let bag = DisposeBag()
    private var breeds = BehaviorRelay<[CatBreed]>(value: [])

    init(context: AppContext) {
        self.context = context
    }

    func setup() {
        context.network.fetchBreeds()
            .do(
                onNext: { [weak self] _ in
                    print("onNext")
                    self?.isInProgress.accept(false)
                    self?.errorMessage.accept(nil)
                },
                onError: { [weak self] error in
                    print("onError")
                    self?.isInProgress.accept(false)
                    let message = L10n.ErrorMessages.loadingFailed + ": \(error.localizedDescription)"
                    self?.errorMessage.accept(message)
                },
                onSubscribed: { [weak self] in
                    print("onSubscribed")
                    self?.isInProgress.accept(true)
                    self?.errorMessage.accept(nil)
                }
            )
            .catchErrorJustReturn([])
            .map { $0.map(CatBreedDetailsViewModelImpl.init) }
            .bind(to: breedsCellsModels)
            .disposed(by: bag)

        triggerCell
            .asObserver()
            .subscribe(onNext: { [weak self] catBreedDetailsViewModel in
                self?.delegate?.didSelectCell(with: catBreedDetailsViewModel)
            })
            .disposed(by: bag)
    }
}
