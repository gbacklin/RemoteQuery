//
//  Network.swift
//  RemoteQuery
//
//  Created by Gene Backlin on 2/18/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

class Network: NSObject {
    static let sharedInstance = Network()
    
    func get(url: String, completion: @escaping (_ result: [AnyObject]?, _ error: NSError?) -> Void) {
        let request: URLRequest = URLRequest(url: URL(string: url)!)
        let sessionTask: URLSessionDataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // in case we want to know the response status code
            // let HTTPStatusCode = (response as! HTTPURLResponse).statusCode
            if error != nil {
                OperationQueue.main.addOperation({
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    if (error! as NSError).code == NSURLErrorAppTransportSecurityRequiresSecureConnection {
                        // if you get error NSURLErrorAppTransportSecurityRequiresSecureConnection (-1022),
                        // then your Info.plist has not been properly configured to match the target server.
                        //
                        completion(nil, error as NSError?)
                    } else {
                        completion(nil, error as NSError?)
                    }
                })
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [AnyObject]
                    completion(json, nil)
                } catch let error as NSError {
                    completion(nil, error as NSError?)
                }
            }
        }
        sessionTask.resume()
    }

    func getJSON(url: String, completion: @escaping (_ json: Data?, _ error: NSError?) -> Void) {
        let request: URLRequest = URLRequest(url: URL(string: url)!)
        let sessionTask: URLSessionDataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // in case we want to know the response status code
            // let HTTPStatusCode = (response as! HTTPURLResponse).statusCode
            if error != nil {
                OperationQueue.main.addOperation({
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    if (error! as NSError).code == NSURLErrorAppTransportSecurityRequiresSecureConnection {
                        // if you get error NSURLErrorAppTransportSecurityRequiresSecureConnection (-1022),
                        // then your Info.plist has not been properly configured to match the target server.
                        //
                        completion(nil, error as NSError?)
                    } else {
                        completion(nil, error as NSError?)
                    }
                })
            } else {
                completion(data, nil)
            }
        }
        sessionTask.resume()
    }

}

