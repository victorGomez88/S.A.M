//
//  BaseNetworkManager.swift
//  S.A.M
//
//  Created by Victor Gomez on 14/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import CryptoSwift

class BaseServiceManager {
    
    /// Base GET request method
    /// - Parameter params: Params necessary in the request (optional)
    /// - Parameter url: Complete URL path of request
    /// - Parameter succeed: Return data obtained from request (Json)
    /// - Parameter fail: Return data error from request (Json)
    public static func doGetRequest(params: [String:Any]?,
                                    url: String,
                                    success succeed: (@escaping (Data) -> Void),
                                    failure fail: (@escaping (Any) -> Void)) {
        
        var finalParams: [String: Any] = [:]
        
        if let params = params {
            finalParams.merge(params){(current, _) in current}
        }
        
        finalParams.merge(obtainSecurityParams()){(current, _) in current}
        
        AF.request(url, method: .get, parameters:finalParams).response { response in
            guard let data = response.data else { return }
            
            print(response.request!)
            
            switch response.result {
                
            case .success:
                if response.response?.statusCode == 200 {
                    print(data)
                    succeed(data)
                } else {
                    print(response.result)
                    fail(data)
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                fail(error)
                break
            }
            
        }
    }
    
    /// Call to retrieve image from URL
    /// - Parameter imageURL: Complete URL path of image
    /// - Parameter succeed: Returns a UIImage retrieved from url response data
    /// - Parameter fail: Return data error from request
    public static func doGetImageRequest(with imageURL: String,
                                         success succeed: (@escaping (UIImage) -> Void),
                                         failure fail: (@escaping (Any) -> Void)) {
        
        guard let url = URL(string: imageURL) else { return }
        let urlRequest = URLRequest(url: url)
        
        ImageDownloader().download(urlRequest, completion:  { response in
            
            switch response.result {
            
            case .success(let image):
                succeed(image)
                break
            case .failure(let error):
                fail(error)
                break
                
            }
            
            debugPrint(response.result)
        })
    }
    
    
    
    /// Creates the url with security params (timestamp, apikey and hash -> md5(ts+publicKey+privateKey)
    /// - Parameter url: basic url without security params
    /// - Returns: Complete url with security params
    private static func obtainSecurityParams() -> [String:Any] {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHmss"
        let timestamp = dateFormatter.string(from: date)
        
        let hash = (timestamp + APIConstants.privateKey + APIConstants.publicKey).md5()
        
        return ["ts": timestamp,
                "hash": hash,
                "apikey": APIConstants.apiKey]
    }

}
