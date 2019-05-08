//
//  CatBreedDetailsViewController.swift
//  CatFacts
//
//  Created by Krystian Bujak on 08/05/2019.
//  Copyright © 2019 SwingDev. All rights reserved.
//

import UIKit

class CatBreedDetailsViewController: UIViewController {
    private let countryLabel = UILabel()
    private let originLabel = UILabel()
    private let coatLabel = UILabel()
    private let patternLabel = UILabel()
    private let viewModel: CatBreedDetailsViewModel

    init(viewModel: CatBreedDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()

        [countryLabel, originLabel, coatLabel, patternLabel].forEach { view.addSubview($0 )}

        setupLayouts()
        setupStyles()

        viewModel.setup()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: L10n.Button.back,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backButtonTapped))
    }

    @objc private func backButtonTapped() {
        viewModel.backButtonTriggered.onNext(())
    }
}

extension CatBreedDetailsViewController {
    private func setupLayouts() {
        countryLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 50)
        originLabel.autoPinEdge(.top, to: .bottom, of: countryLabel, withOffset: 50)
        coatLabel.autoPinEdge(.top, to: .bottom, of: originLabel, withOffset: 50)
        patternLabel.autoPinEdge(.top, to: .bottom, of: coatLabel, withOffset: 50)

        countryLabel.autoMatch(.width, to: .width, of: view)
        originLabel.autoMatch(.width, to: .width, of: view)
        coatLabel.autoMatch(.width, to: .width, of: view)
        patternLabel.autoMatch(.width, to: .width, of: view)
    }

    private func setupStyles() {
        view.backgroundColor = .white
        navigationItem.title = viewModel.catBreed.breed

        countryLabel.textAlignment = .center
        originLabel.textAlignment = .center
        coatLabel.textAlignment = .center
        patternLabel.textAlignment = .center

        countryLabel.text = viewModel.catBreed.country
        originLabel.text = viewModel.catBreed.origin
        coatLabel.text = viewModel.catBreed.coat
        patternLabel.text = viewModel.catBreed.pattern
    }
}
