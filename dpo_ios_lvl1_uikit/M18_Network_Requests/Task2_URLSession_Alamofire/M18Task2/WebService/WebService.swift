//
//  WebService.swift
//  M19
//
//  Created by Николай Ногин on 17.08.2022.
//

import Alamofire

public struct WebService {
    private let forPostURL = "https://jsonplaceholder.typicode.com/posts"
    
    func sendDataWithURLSession(data: UserProfile, completion: @escaping ( (Int?, String?), String?) -> Void) {
        
        let encoder = JSONEncoder()
    
        let userData: Data? = try? encoder.encode(data)
        
        let url = URL(string: forPostURL)
        
        guard let safeUrl = url else { return }
        var request = URLRequest(url: safeUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = userData
        
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    return completion((nil, nil), err.localizedDescription)
                } else {
                    if let data = data {
                        
                        var location: String? = nil
                        if let httpResponse = resp as? HTTPURLResponse {
                             if let safeLocation = httpResponse.allHeaderFields["Location"] as? String {
                                location = safeLocation
                             }
                        }
                        
                        let decoder = JSONDecoder()
                        if let returnedObj = try? decoder.decode(UserProfile.self, from: data) {
                            return completion((returnedObj.id, location), nil)
                        } else {
                            return completion((nil, nil), "Decoding Error: Couldnt decode response from server")
                        }
                   
                    }
                }
            }
        }.resume()
    }
    
    func sendDataWithAlamofire(data: UserProfile, completion: @escaping ( (Int?, String?), String?) -> Void) {
        AF.request(
            forPostURL,
            method: .post,
            parameters: data,
            encoder: JSONParameterEncoder.default
        ).response { response in
            
            guard response.error == nil else {
                return completion((nil, nil), response.error?.localizedDescription)
            }
            
            let decoder = JSONDecoder()
            if let returnedObj = try? decoder.decode(UserProfile.self, from: response.data!) {
                var location: String? = nil
                if let safeLocation = response.response?.allHeaderFields["Location"] as? String {
                    location = safeLocation
                }
                return completion((returnedObj.id, location), nil)
            } else {
                return completion((nil, nil), "Decoding Error: Couldnt decode response from server")
            }
        }
    }
    
   
}
