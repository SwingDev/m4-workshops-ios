//
//  NetworkProviderImpl.swift
//  CatFacts
//
//  Created by Marek Matulski on 07/05/2019.
//  Copyright © 2019 SwingDev. All rights reserved.
//

import RxAlamofire
import RxSwift
import SwiftyJSON

private struct Constants {
    static let serverAddress = "https://catfact.ninja"
    static let breedPath = "/breeds?limit=1000"
}

class NetworkProviderImpl: NetworkProvider {
    func fetchBreeds() -> Observable<[CatBreed]> {
        return request(.get, URL(string: Constants.serverAddress + Constants.breedPath)!)
            .responseJSON()
            .map { response -> [CatBreed] in
                switch response.result {
                case .success(let jsonObject):
                    return try CatBreedResponse(json: JSON(jsonObject)).data
                case .failure(let error):
                    throw error
                }
            }
    }
}
