//
//  Service.swift
//  MovieAppXib
//
//  Created by Burak Erden on 10.01.2023.
//

import Alamofire

protocol ServiceProtocol {
    func getMovie(onSuccess: @escaping (GameApi?) -> Void, onError: @escaping (AFError) -> Void)
}

final class Service: ServiceProtocol {
    func getMovie(onSuccess: @escaping (GameApi?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        ServiceManager.shared.fetch(path: "https://api.rawg.io/api/games?key=07c12348def94b9bbdaea4c1734ae00c") { (response: GameApi) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
}


