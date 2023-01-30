//
//  Service.swift
//  MovieAppXib
//
//  Created by Burak Erden on 10.01.2023.
//

import Alamofire

protocol DetailServiceProtocol {
    func getMovieDetail(text: Int, onSuccess: @escaping (DetailApi?) -> Void, onError: @escaping (AFError) -> Void)
}



final class DetailService: DetailServiceProtocol {
    func getMovieDetail(text: Int, onSuccess: @escaping (DetailApi?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        ServiceManager.shared.fetch(path: "https://api.rawg.io/api/games/\(text)?key=07c12348def94b9bbdaea4c1734ae00c") { (response: DetailApi) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
}
