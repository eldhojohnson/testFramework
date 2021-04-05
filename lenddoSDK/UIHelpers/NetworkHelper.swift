//
//  NetworkHelper.swift
//  lenddo SDK
//
//  Created by iOS dev on 26/03/21.
//

import Foundation


class NetworkHelper: NSObject {
    
    static let shared = NetworkHelper()
 
    func makeApiCall(url : String, parameters:[String:Any], token : String?, method : String, completionHandler: @escaping (Any?) -> Swift.Void) {
        
        var urlString = url
        
        if let token = token{
            urlString += "?service_token=\(token)"
        }
        
        print(urlString)
        
        let Url = String(format: urlString)
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = method
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        print(parameters)
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    completionHandler(json)
                } catch {
                    print(error)
                    completionHandler(error)
                }
            }
        }.resume()
    }
}

