import Foundation

class APIHandler {
    func getIngredients(completion: @escaping ([BackendFridgeItemResult]?, Error?) -> Void) {
            let headers = [
                "X-Parse-Application-Id": "",
                "X-Parse-REST-API-Key": ""
            ]
            
            let request = NSMutableURLRequest(url: URL(string: "https://parseapi.back4app.com/classes/Ingredients")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    let error = NSError(domain: "Invalid HTTP response", code: 0, userInfo: nil)
                    completion(nil, error)
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    // Successful response
                    if let data = data {
                        print(String(data: data, encoding: .utf8))
                        // Parse and handle the response data here
                        do {
                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .iso8601
                            
                            let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                            let jsonArray = jsonDict?["results"] as? [[String: Any]]
                            
                            if let jsonArray = jsonArray {
                                let backendItems = try decoder.decode([BackendFridgeItemResult].self, from: JSONSerialization.data(withJSONObject: jsonArray))
                                completion(backendItems, nil)
                            } else {
                                let error = NSError(domain: "Invalid JSON format: 'results' key not found or not an array", code: 0, userInfo: nil)
                                completion(nil, error)
                            }
                        } catch {
                            completion(nil, error)
                        }
                    }
                } else {
                    // Handle non-successful response
                    let error = NSError(domain: "HTTP response code: \(httpResponse.statusCode)", code: httpResponse.statusCode, userInfo: nil)
                    completion(nil, error)
                }
            }
            
            dataTask.resume()
        }
    
    func getRecipes(completion: @escaping ([BackendRecipeResult]?, Error?) -> Void) {
            let headers = [
                "X-Parse-Application-Id": "",
                "X-Parse-REST-API-Key": ""
            ]
            
            let request = NSMutableURLRequest(url: URL(string: "https://parseapi.back4app.com/classes/Recipe")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    let error = NSError(domain: "Invalid HTTP response", code: 0, userInfo: nil)
                    completion(nil, error)
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    // Successful response
                    if let data = data {
                        print(String(data: data, encoding: .utf8))
                        // Parse and handle the response data here
                        do {
                            let decoder = JSONDecoder()
                            
                            let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                            let jsonArray = jsonDict?["results"] as? [[String: Any]]
                            
                            if let jsonArray = jsonArray {
                                let backendItems = try decoder.decode([BackendRecipeResult].self, from: JSONSerialization.data(withJSONObject: jsonArray))
                                completion(backendItems, nil)
                            } else {
                                let error = NSError(domain: "Invalid JSON format: 'results' key not found or not an array", code: 0, userInfo: nil)
                                completion(nil, error)
                            }
                        } catch {
                            completion(nil, error)
                        }
                    }
                } else {
                    // Handle non-successful response
                    let error = NSError(domain: "HTTP response code: \(httpResponse.statusCode)", code: httpResponse.statusCode, userInfo: nil)
                    completion(nil, error)
                }
            }
            
            dataTask.resume()
        }
    }

struct BackendFridgeItemResult: Codable {
    let Name: String
    let Category: [String]
    let objectId: String
    let createdAt: String
    let updatedAt: String
    let expirationTime: Int
}
