//
//  Created by Anatoly Gurbanov on 15.02.2021.
//

import Foundation

enum NetworkConfiguration {
    case baseURLString(userName: String)
    
    var urlString: URL? {
        switch self {
        case .baseURLString(let userName):
            return URL(string: "https://api.github.com/users/\(userName)/repos")
        }
    }
}
