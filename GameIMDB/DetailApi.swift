// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct DetailApi: Codable {
    let name: String //
    let metacritic: Int   //
    let released: String   //
    let backgroundImage, backgroundImageAdditional: String
    let descriptionRaw: String
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case name
        case metacritic
        case released
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case descriptionRaw = "description_raw"
        case rating
    }
}




