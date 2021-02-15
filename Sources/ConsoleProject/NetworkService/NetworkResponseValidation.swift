//
//  Created by Anatoly Gurbanov on 15.02.2021.
//

import Foundation

enum NetworkResponse: String {
    case success
    case emptyField = "Nickname was not input"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum ResponseResult<String> {
    case success
    case failure(String)
}
