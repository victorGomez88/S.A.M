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
import CryptoKit

class BaseNetworkManager {
    
    /// Base GET request method
    /// - Parameter params: Params necessary in the request (optional)
    /// - Parameter url: Complete URL path of request
    /// - Parameter succeed: Return data obtained from request (Json)
    /// - Parameter fail: Return data error from request (Json)
    public static func doGetRequest(params: [String:Any]?,
                                    url: String,
                                    success succeed: (@escaping (Any) -> Void),
                                    failure fail: (@escaping (Any) -> Void)) {
    
        AF.request(obtainFinalURL(url), method: .get, parameters:params).responseJSON { response in
            
            print(response.request!)
            
            switch response.result {
                
            case .success(let value):
                succeed(value)
                break
            case .failure(let error):
                fail(error)
                break
            }
            
            print(response.response ?? "Without Response (ERROR?)")
            debugPrint(response.result)
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
    private static func obtainFinalURL(_ url: String) -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHmss"
        
        let timestamp = "?ts=" + dateFormatter.string(from: date)
        
        let md5 = Insecure.MD5.hash(data: (timestamp + APIConstants.privateKey + APIConstants.publicKey).data(using: .utf8)!)
        let hash = "&hash=" + String(md5.description.split(separator: " ")[2])//CHANGE!!
        
        return url + timestamp + APIConstants.apiKey + hash
    }

}