import Alamofire
import Foundation

print("Input user's nickname:")

guard let userName = readLine()?.trimmingCharacters(in: CharacterSet.urlPathAllowed.inverted),
      !userName.isEmpty else {
    print(NetworkResponse.emptyField.rawValue)
    exit(0)
}

print("Searching repositories for: \(userName)")

guard let userRepoURL = NetworkConfiguration.baseURLString(userName: userName).urlString else {
    print("Invalid URL")
    exit(0)
}

Alamofire.request(userRepoURL)
    .validate()
    .responseJSON(queue: DispatchQueue.global(qos: .background), options: .allowFragments) { response in
        
        if let error = response.error {
            print("Error - \(error.localizedDescription)")
            exit(0)
        }
        
        if let response = response.response {
            let result = handleNetworkResponse(response)
            
            switch result {
            case .success:
                break
            case .failure(let responseError):
                print("Error - \(responseError)")
                exit(0)
            }
        }
        
        if let responseData = response.data,
           let repositories = try? JSONDecoder().decode([Repository].self, from: responseData) {
            if repositories.isEmpty {
                print("User has no repositories")
                exit(0)
            }
            print("Repositories: \(repositories.map { $0.name })")
            exit(0)
        } else {
            print("Error - \(NetworkResponse.noData.rawValue)")
            exit(0)
        }
    }

func handleNetworkResponse(_ response: HTTPURLResponse) -> ResponseResult<String>{
    switch response.statusCode {
    case 200:
        return .success
    case 404:
        return .failure(NetworkResponse.failed.rawValue)
    case 501...599:
        return .failure(NetworkResponse.badRequest.rawValue)
    case 600:
        return .failure(NetworkResponse.outdated.rawValue)
    default:
        return .failure(NetworkResponse.failed.rawValue)
    }
}

while(true) {}
